@echo off
setlocal

cd /d "%~dp0"

set "INPUT_CSV=%~1"
if "%INPUT_CSV%"=="" set "INPUT_CSV=arkTS_test_data.csv"

set "OUTPUT_ROOT=eval_outputs"
set "LOG_LEVEL=INFO"
set "REQUEST_RETRIES=3"

rem Add or remove model names below. Each model runs sequentially.
for %%M in (
    "nex-agi/Nex-N2-Pro"
    "Pro/zai-org/GLM-5.1"
    "Qwen/Qwen3.5-397B-A17B"
    "Pro/moonshotai/Kimi-K2.6"
) do (
    echo.
    echo ============================================================
    echo Running model: %%~M
    echo Input CSV: %INPUT_CSV%
    echo Output root: %OUTPUT_ROOT%
    echo ============================================================

    python compiler_tool.py --input "%INPUT_CSV%" --model "%%~M" --output-root "%OUTPUT_ROOT%" --log-level "%LOG_LEVEL%" --request-retries "%REQUEST_RETRIES%"
    if errorlevel 1 (
        echo.
        echo Evaluation failed for model: %%~M
        exit /b 1
    )
)

echo.
echo All model evaluations completed.
endlocal
