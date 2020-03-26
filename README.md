# SAS_Macros
SAS Macro library


# 説明

|名前|概要|引数|
|:---|:---|:---|
|num2char|数値変数を、名前を変えずに文字変数に変換する。変数は複数指定可能。|Input：入力データセット名を記載（ライブラリ指定可能。実行時に存在しないとエラーになる）<br>Output：出力データセット名を記載（マクロが作成する。ライブラリ指定可能）<br>Var=：変換する変数名を記載。$区切りで複数指定可能。 <br>Clen：出力する文字変数のLengthを数値で指定。省力すると5000が割り当てられる。|
