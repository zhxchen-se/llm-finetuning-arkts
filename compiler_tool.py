import argparse
import csv
import logging
import os
import re
import subprocess
import time
from pathlib import Path
from typing import Optional

from openai import OpenAI

from FileCache import FileCache


API_KEY_ENV = "SiliconCloud_API_KEY"
DEFAULT_BASE_URL = "https://api.siliconflow.cn/v1"
DEFAULT_MODEL = "deepseek-ai/DeepSeek-V4-Pro"
PROJECT_ROOT = Path(__file__).resolve().parent
INDEX_FILE_PATH = PROJECT_ROOT / "entry" / "src" / "main" / "ets" / "pages" / "Index.ets"
LOGGER = logging.getLogger("arkts_eval")


def configure_logging(log_level: str) -> None:
    logging.basicConfig(
        level=getattr(logging, log_level.upper()),
        format="%(asctime)s [%(levelname)s] %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )


def format_command(command: list[str]) -> str:
    return " ".join(f'"{part}"' if " " in part else part for part in command)


def create_llm_client(base_url: str) -> OpenAI:
    api_key = os.environ.get(API_KEY_ENV)
    if not api_key:
        raise RuntimeError(
            f"Missing API key. Set environment variable {API_KEY_ENV} before running evaluation."
        )
    LOGGER.info("Creating LLM client: base_url=%s api_key_env=%s", base_url, API_KEY_ENV)
    return OpenAI(api_key=api_key, base_url=base_url)


def resolve_deveco_home(cli_value: Optional[str]) -> Path:
    candidates = [
        cli_value,
        os.environ.get("DEVECO_HOME"),
        r"D:\Program Files\Huawei\DevEco Studio",
        r"C:\Program Files\Huawei\DevEco Studio",
    ]
    for candidate in candidates:
        if not candidate:
            continue
        path = Path(candidate).expanduser()
        if path.exists():
            return path.resolve()
    raise FileNotFoundError(
        "DevEco Studio was not found. Set DEVECO_HOME or pass --deveco-home."
    )


def first_existing(paths: list[Path], description: str) -> Path:
    for path in paths:
        if path.exists():
            return path
    searched = ", ".join(str(path) for path in paths)
    raise FileNotFoundError(f"Could not find {description}. Searched: {searched}")


def create_build_environment(deveco_home: Path) -> tuple[dict[str, str], Path, Path]:
    node_home = deveco_home / "tools" / "node"
    hvigorw_dir = deveco_home / "tools" / "hvigor" / "bin"
    sdk_home = deveco_home / "sdk"

    node_path = first_existing(
        [
            node_home / "node.exe",
            node_home / "bin" / "node",
            node_home / "node",
        ],
        "DevEco Node executable",
    )
    hvigor_path = first_existing([hvigorw_dir / "hvigorw.js"], "hvigorw.js")
    java_home = first_existing(
        [
            deveco_home / "jbr",
            deveco_home / "jbr" / "Contents" / "Home",
        ],
        "DevEco bundled JBR",
    )

    env = os.environ.copy()
    env["NODE_HOME"] = str(node_home)
    env["DEVECO_SDK_HOME"] = str(sdk_home)
    env["JAVA_HOME"] = str(java_home)

    path_parts = [
        str(hvigorw_dir),
        str(node_home),
        str(node_home / "bin"),
        str(java_home / "bin"),
        env.get("PATH", ""),
    ]
    env["PATH"] = os.pathsep.join(part for part in path_parts if part)
    return env, node_path, hvigor_path


def extract_code_from_response(response: str) -> str:
    """Extract the longest code block from a model response."""
    code_pattern = r"```(?:arkts|typescript|ts|javascript|js)?\s*([\s\S]*?)\s*```"
    matches = re.findall(code_pattern, response)
    if matches:
        return max(matches, key=len).strip()
    return response.strip()


def generate_arkts_code(client: OpenAI, model: str, instruction: str) -> str:
    prompt_preview = " ".join(instruction.split())[:160]
    LOGGER.info(
        "Calling LLM: model=%s prompt_chars=%d prompt_preview=%r",
        model,
        len(instruction),
        prompt_preview,
    )
    started_at = time.perf_counter()
    try:
        response = client.chat.completions.create(
            model=model,
            messages=[
                {
                    "role": "system",
                    "content": (
                        "You are a HarmonyOS ArkTS developer. Return only a complete "
                        "ArkTS source file for entry/src/main/ets/pages/Index.ets. "
                        "Do not include markdown fences or explanations."
                    ),
                },
                {"role": "user", "content": instruction},
            ],
            temperature=0,
        )
    except Exception:
        LOGGER.exception("LLM request failed after %.1fs", time.perf_counter() - started_at)
        raise

    raw_content = response.choices[0].message.content or ""
    code = extract_code_from_response(raw_content)
    LOGGER.info(
        "LLM returned: response_chars=%d code_chars=%d elapsed=%.1fs",
        len(raw_content),
        len(code),
        time.perf_counter() - started_at,
    )
    return code


def count_errors(message: str) -> int:
    return message.upper().count("ERROR") if message else 0


class ArkTSCompiler:
    def __init__(self, index_file_path: Path, deveco_home: Path):
        self.index_file_path = index_file_path.resolve()
        self.env, self.node_path, self.hvigor_path = create_build_environment(deveco_home)
        self.file_cache = FileCache()
        self.file_cache.cache_file(str(self.index_file_path))
        self._restored = False
        LOGGER.info("DevEco home: %s", deveco_home)
        LOGGER.info("DevEco node: %s", self.node_path)
        LOGGER.info("DevEco hvigor: %s", self.hvigor_path)
        LOGGER.info("Target Index.ets: %s", self.index_file_path)

    def compile_code(self, code: str) -> tuple[int, str]:
        LOGGER.info(
            "Writing generated code to project entry file: path=%s code_chars=%d",
            self.index_file_path,
            len(code),
        )
        self.file_cache.update_file(str(self.index_file_path), new_content=code)
        build_cmd = [
            str(self.node_path),
            str(self.hvigor_path),
            "--mode",
            "module",
            "-p",
            "module=entry@default",
            "-p",
            "product=default",
            "-p",
            "requiredDeviceType=phone",
            "-p",
            "arkts.compiler.ets.tsType.nullable=true",
            "-p",
            "arkts.compiler.ets.type-check=false",
            "assembleHap",
            "--analyze=normal",
            "--parallel",
            "--incremental=false",
            "--daemon",
        ]
        LOGGER.info(
            "Starting hvigor compile: cwd=%s command=%s",
            PROJECT_ROOT,
            format_command(build_cmd),
        )
        started_at = time.perf_counter()
        try:
            result = subprocess.run(
                build_cmd,
                cwd=PROJECT_ROOT,
                capture_output=True,
                text=True,
                encoding="utf-8",
                errors="replace",
                env=self.env,
            )
        except Exception:
            LOGGER.exception("hvigor compile failed before completion after %.1fs", time.perf_counter() - started_at)
            raise
        message = "\n".join(part for part in [result.stdout, result.stderr] if part)
        LOGGER.info(
            "hvigor compile finished: return_code=%s output_chars=%d elapsed=%.1fs",
            result.returncode,
            len(message),
            time.perf_counter() - started_at,
        )
        return result.returncode, message

    def restore_original(self) -> None:
        if not self._restored:
            LOGGER.info("Restoring original Index.ets: %s", self.index_file_path)
            self.file_cache.revert_file(str(self.index_file_path))
            self._restored = True


def infer_instruction_column(fieldnames: list[str], requested_column: Optional[str]) -> str:
    if requested_column:
        if requested_column not in fieldnames:
            raise ValueError(
                f"CSV column '{requested_column}' was not found. Available columns: {fieldnames}"
            )
        return requested_column

    for candidate in ["instruction", "Test Instructions", "prompt"]:
        if candidate in fieldnames:
            return candidate
    raise ValueError(
        "Could not infer instruction column. Pass --instruction-column. "
        f"Available columns: {fieldnames}"
    )


def read_instructions(input_csv: Path, instruction_column: Optional[str]) -> list[dict[str, str]]:
    with input_csv.open("r", newline="", encoding="utf-8-sig") as f:
        reader = csv.DictReader(f)
        if not reader.fieldnames:
            raise ValueError(f"Input CSV has no header: {input_csv}")
        column = infer_instruction_column(reader.fieldnames, instruction_column)
        rows = []
        for row_index, row in enumerate(reader, start=1):
            instruction = (row.get(column) or "").strip()
            if instruction:
                rows.append({"index": str(row_index), "instruction": instruction})
        return rows


def write_result_header(results_csv: Path) -> None:
    results_csv.parent.mkdir(parents=True, exist_ok=True)
    with results_csv.open("w", newline="", encoding="utf-8-sig") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "index",
                "instruction",
                "output_file_path",
                "compile_passed",
                "return_code",
                "error_count",
                "compile_log_path",
                "error",
            ],
        )
        writer.writeheader()


def append_result(results_csv: Path, row: dict[str, object]) -> None:
    with results_csv.open("a", newline="", encoding="utf-8-sig") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "index",
                "instruction",
                "output_file_path",
                "compile_passed",
                "return_code",
                "error_count",
                "compile_log_path",
                "error",
            ],
        )
        writer.writerow(row)


def run_evaluation(args: argparse.Namespace) -> None:
    configure_logging(args.log_level)
    input_csv = Path(args.input).resolve()
    output_dir = Path(args.output_dir).resolve()
    code_dir = output_dir / "code"
    log_dir = output_dir / "logs"
    results_csv = Path(args.results_csv).resolve()

    instructions = read_instructions(input_csv, args.instruction_column)
    if args.limit is not None:
        instructions = instructions[: args.limit]

    LOGGER.info("Input CSV: %s", input_csv)
    LOGGER.info("Instruction count: %d", len(instructions))
    LOGGER.info("Output directory: %s", output_dir)
    LOGGER.info("Results CSV: %s", results_csv)

    code_dir.mkdir(parents=True, exist_ok=True)
    log_dir.mkdir(parents=True, exist_ok=True)
    write_result_header(results_csv)

    client = create_llm_client(args.base_url)
    compiler = ArkTSCompiler(INDEX_FILE_PATH, resolve_deveco_home(args.deveco_home))

    try:
        total = len(instructions)
        for position, item in enumerate(instructions, start=1):
            row_index = int(item["index"])
            instruction = item["instruction"]
            code_path = code_dir / f"{row_index:04d}.ets"
            log_path = log_dir / f"{row_index:04d}.log"

            LOGGER.info("[%d/%d] Start row: csv_row=%d", position, total, row_index)
            try:
                code = generate_arkts_code(client, args.model, instruction)
                code_path.write_text(code, encoding="utf-8")
                LOGGER.info("[%d/%d] Saved generated code: %s", position, total, code_path)

                LOGGER.info("[%d/%d] Compiling generated code: %s", position, total, code_path.name)
                return_code, compile_message = compiler.compile_code(code)
                log_path.write_text(compile_message, encoding="utf-8")
                compile_passed = return_code == 0
                error_count = 0 if compile_passed else count_errors(compile_message)
                LOGGER.info("[%d/%d] Saved compile log: %s", position, total, log_path)

                append_result(
                    results_csv,
                    {
                        "index": row_index,
                        "instruction": instruction,
                        "output_file_path": str(code_path),
                        "compile_passed": compile_passed,
                        "return_code": return_code,
                        "error_count": error_count,
                        "compile_log_path": str(log_path),
                        "error": "",
                    },
                )
                status = "PASS" if compile_passed else "FAIL"
                LOGGER.info(
                    "[%d/%d] Finished row: status=%s return_code=%s error_count=%s",
                    position,
                    total,
                    status,
                    return_code,
                    error_count,
                )
            except Exception as exc:
                append_result(
                    results_csv,
                    {
                        "index": row_index,
                        "instruction": instruction,
                        "output_file_path": str(code_path) if code_path.exists() else "",
                        "compile_passed": False,
                        "return_code": "",
                        "error_count": "",
                        "compile_log_path": str(log_path) if log_path.exists() else "",
                        "error": str(exc),
                    },
                )
                LOGGER.exception("[%d/%d] Row failed: csv_row=%d error=%s", position, total, row_index, exc)
                if args.stop_on_error:
                    raise
    finally:
        compiler.restore_original()

    LOGGER.info("Evaluation complete. Results: %s", results_csv)
    LOGGER.info("Generated code files: %s", code_dir)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run sequential ArkTS code-generation and compilation evaluation."
    )
    parser.add_argument("--input", default="arkTS_test_data.csv", help="Input CSV path.")
    parser.add_argument(
        "--instruction-column",
        default=None,
        help="Column containing prompts. Defaults to auto-detecting instruction/Test Instructions/prompt.",
    )
    parser.add_argument(
        "--output-dir",
        default="evaluation_outputs",
        help="Directory for generated code files and compile logs.",
    )
    parser.add_argument(
        "--results-csv",
        default="evaluation_outputs/results.csv",
        help="CSV file that records prompt, output file path, and compile status.",
    )
    parser.add_argument(
        "--deveco-home",
        default=None,
        help="DevEco Studio installation directory. Defaults to DEVECO_HOME or common Windows paths.",
    )
    parser.add_argument("--base-url", default=DEFAULT_BASE_URL, help="OpenAI-compatible API base URL.")
    parser.add_argument("--model", default=DEFAULT_MODEL, help="Model name used for generation.")
    parser.add_argument("--limit", type=int, default=None, help="Only evaluate the first N rows.")
    parser.add_argument("--stop-on-error", action="store_true", help="Stop instead of continuing after a row error.")
    parser.add_argument(
        "--log-level",
        default="INFO",
        choices=["DEBUG", "INFO", "WARNING", "ERROR"],
        help="Console log level.",
    )
    return parser.parse_args()


if __name__ == "__main__":
    run_evaluation(parse_args())
