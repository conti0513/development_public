package main

import "fmt"


func main() {

    // s := 75 の評価を、switch を使って判定してください。
// 80以上: 「優秀」
// 60以上: 「合格」
// それ以外: 「不合格」

    s := 75

    // switchの後に変数を書かない「自由形式」がGoの定番です
    switch {
    case s >= 80:
        fmt.Println("優秀")
    case s >= 60:
        fmt.Println("合格")
    default:
        fmt.Println("不合格")
    }
}