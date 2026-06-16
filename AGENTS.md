# Repository Guidelines

## Project Structure & Module Organization

This repository is a DevEco Studio-compatible HarmonyOS project plus an ArkTS code-generation evaluation workflow. The app module lives in `entry/`; ArkTS UI code is under `entry/src/main/ets/`, resources under `entry/src/main/resources/`, and native N-API/C++ code under `entry/src/main/cpp/`. App-level metadata and icons live in `AppScope/`. Unit tests are in `entry/src/test/`, device/UI tests are in `entry/src/ohosTest/`, and mocks are in `entry/src/mock/`. Evaluation assets include `arkTS_train_data.csv`, `arkTS_test_data.csv`, `compiler_tool.py`, `FileCache.py`, and generated run artifacts in `eval_outputs/`.

## Build, Test, and Development Commands

- `python compiler_tool.py --input arkTS_test_data.csv`: run ArkTS-Test and create `eval_outputs/<model>_<timestamp>/` with `code/`, `logs/`, and `results.csv`; request failures are retried three times after the first pass.
- `python compiler_tool.py --input arkTS_test_data.csv --log-level DEBUG`: rerun evaluation with verbose diagnostics.
- `.\run_eval_models.bat`: run the configured model list sequentially; edit the model names in the batch file before large comparisons.
- Build and test the HarmonyOS app through DevEco Studio or the project Hvigor task runner configured by `hvigorfile.ts` and `build-profile.json5`. Keep DevEco Studio 4.0+ and HarmonyOS SDK API 9+ available, and set `DEVECO_HOME` when using scripts.

## Coding Style & Naming Conventions

Use ArkTS/TypeScript conventions in `.ets` files: 2-space indentation, PascalCase component/class names, camelCase variables and functions, and clear resource keys. Keep generated UI code focused in `entry/src/main/ets/pages/Index.ets` unless adding reusable app code. C++ code should follow the existing `snake_case` filenames and N-API module layout under `entry/src/main/cpp/`. ArkTS lint scope is defined in `code-linter.json5`; C++ checks are listed in `.clang-tidy`.

## Testing Guidelines

Use Hypium-based tests for ArkTS behavior. Put local unit tests in `entry/src/test/*.test.ets` and device tests in `entry/src/ohosTest/ets/test/*.test.ets`; follow the existing `List.test.ets` and `Ability.test.ets` naming pattern. For evaluation changes, rerun `compiler_tool.py` against `arkTS_test_data.csv` and inspect the latest run under `eval_outputs/`.

## Commit & Pull Request Guidelines

Recent history uses short, direct summaries, for example `Enhance README with project details and setup instructions` or concise workflow/update notes. Keep commits scoped to one logical change. Pull requests should describe the change, list reproduction or test commands run, mention affected datasets or generated outputs, and include screenshots only for visible HarmonyOS UI changes.

## Security & Configuration Tips

Do not commit API keys, local SDK paths, or machine-specific secrets. Keep `local.properties` and environment variables such as `DEVECO_HOME` and `SiliconCloud_API_KEY` local to your machine. Treat `eval_outputs/` as generated output; update it only when the result artifacts are intentionally part of the change.
