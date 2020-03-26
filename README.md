[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# SAS_Macros
SAS Macro library

# how to use
After Clone in an appropriate directory, write the following option at the beginning of SAS code

```OPTIONS MAUTOSOURCE SASAUTOS=(SASAUTOS fileref);```

# Brief Description

|Name|Description|
|:---|:---|
|num2char|Convert a numeric variable to a character variable without changing the name. Multiple variables can be converted at the same time.|
|char2num|Convert a character variable to a numeric variable without changing the name. Multiple variables can be converted at the same time.|
|setDs|Combine multiple datasets vertically. If a character variable with a different length exists for the same variable name, it is converted to the maximum length to prevent data lost.|
|Surv_prob|Returns the value S(x) of the estimated survival function at point X with reference to the ODS Table "SurvivalPlot" in the Survival Analysis Procedure.|


# 使い方
適当なフォルダにClone後、SASコード冒頭に以下optionを書く

```OPTIONS MAUTOSOURCE SASAUTOS=(SASAUTOS fileref);```

# 簡単な説明

|名前|説明|
|:---|:---|
|num2char|数値変数を、変数名を変えずに文字変数に変換する。複数の変数を同時に変換可能。|
|char2num|文字変数を、変数名を変えずに数値変数に変換する。複数の変数を同時に変換可能。|
|setDs|複数のデータセットを縦方向に結合する。同じ変数名でLengthが異なる文字変数が存在した場合は最長Lengthに変換して文字切れを防止する。|
|Surv_prob|生存解析ProcedureのODS Table "SurvivalPlot"を参照して、X時点での推定した生存関数の値S(x)を返す。|
