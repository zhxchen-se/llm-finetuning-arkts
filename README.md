# Automating Code Generation for a New Ecosystem: ArkTS & HarmonyOS

This repository contains the official implementation, datasets, and evaluation framework for the paper: **"Automating Code Generation for a New Ecosystem: Establishing Baselines with Large Language Model Based Code Generation for ArkTS and HarmonyOS."**

It provides the necessary tools to replicate our experiments, including the **Iterative Compilation Feedback (ICF)** loop and the **ArkTS-Test** benchmark.

## 📂 Repository Structure

The repository is structured as a standard HarmonyOS project (DevEco Studio compatible) with additional Python automation scripts:

- **Datasets:**
  - `arkTS_test_data.csv`: The **ArkTS-Test** evaluation dataset. Contains 100 high-quality instruction-code pairs covering 20 core UI components.
  - `arkTS_train_data.csv`: The training dataset used for fine-tuning GPT-4o-mini. Contains 1,000 instruction-code pairs derived from OpenHarmony Gitee repositories.

- **Automation Scripts:**
  - `compiler_tool.py`: The core script that orchestrates the evaluation. It handles code injection, environment configuration, `hvigor` build execution, and error log parsing.
  - `FileCache.py`: Utility for caching file states to ensure the project can be restored after every compilation attempt.

- **HarmonyOS Project Files:**
  - `entry/`, `AppScope/`, `oh_modules/`: Standard HarmonyOS project directories where the generated code is injected and compiled.
  - `hvigorw`, `build-profile.json5`, `hvigorfile.ts`: Build configuration and wrapper scripts.

---

## 🚀 Reproduction Steps

### 1. Prerequisites & Environment Setup

To run the compilation framework, you must have the Huawei development environment installed:

1.  **Install DevEco Studio 4.0+**: Download and install the official IDE from the [Huawei Developer website](https://developer.huawei.com/consumer/en/deveco-studio/).
2.  **SDK Setup**: Ensure the HarmonyOS SDK (API 9 or higher) is installed via DevEco Studio.
3.  **Environment Variables**:
    You need to set the `DEVECO_HOME` environment variable to point to your DevEco Studio installation directory. You may also need to set `JAVA_HOME` and `NODE_HOME` if they are not in your system path.

    *Example (MacOS/Linux):*
    ```bash
    export DEVECO_HOME="/Applications/DevEco-Studio.app/Contents"
    # The script uses internal tools found inside this directory
    ```

### 2. Running the Evaluation

The `compiler_tool.py` script serves as the main entry point. It reads instructions from the dataset, queries the model (if configured) or takes generated code, injects it into the `entry` module, and attempts compilation.

**To run the syntactic validation:**

```bash
python compiler_tool.py --input arkTS_test_data.csv
