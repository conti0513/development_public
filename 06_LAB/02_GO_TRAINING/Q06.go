package main

import "fmt"

// 変数 s := 75 の値を判定して、以下の評価を画面に出力してください。
// 80以上: 「優秀」
// 60以上: 「合格」
// それ以外: 「不合格」

func main() {
    s := 90

    if s >= 80 {
        fmt.Println("優秀")
    } else if s >= 60 {
        fmt.Println("合格")
    } else {
        fmt.Println("不合格")
    }
}