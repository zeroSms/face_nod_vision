# ディレクトリ構成
## const
都道府県の情報など値に変更がない固定値を定義

## extension
DateTime や String などの extension を定義

## model
モデル層。アーキテクチャの種類によっては、モデル層は、データの保持に加え、ビジネスロジックを記述することがあるが、今回は、データの保持だけを行う。

## plugin
Flutter で実現できなかったことをネイティブで行うための plugin を記述。

MethodChannel を使用してネイティブのメソッドを呼び出している。MethodChannel は Dart からネイティブのメソッドを呼び出すか、ネイティブから Dart のメソッドを呼び出すためのAPI。

## res
色や文字のスタイルなどを定義

## service
API通信の処理を記述

## UI
ページごとにディレクトリを分けて作成。

例えば、login_screenというディレクトリを用意し、LoginScreenというWidgetを作成する．

## view_model
ui層と同じ要領で、LoginViewModelなどを作成