package main

import "fmt"

// 以下の3つの条件を、Goで判定して表示してください。
// 数値の比較: 整数 a := 10 と 整数 b := 10 が等しいか。
// 型の壁を体験: 整数 age := 20 と 浮動小数点 targetAge := 20.0 を、どちらかをキャストして比較してください。（そのまま比較するとエラーになります）
// ブール値の出力: 比較した結果（true/false）を変数 isAdult に代入し、fmt.Printf の %t を使って表示してください。

func main() {
    // 1. 同じ型（int）同士
    a, b := 10, 10
    fmt.Printf("Q04-1: a == b は %t です\n", a == b)

    // 2. 違う型（int と float64）
    age := 20
    targetAge := 20.0

    // ↓ここを修正して計算を成立させてください（キャストが必要です）
    isAdult := float64(age) == targetAge 

    fmt.Printf("Q04-2: 二つの年齢は等しい？ %t\n", isAdult)
    fmt.Printf("Q04-3: isAdult変数の型は %T です\n", isAdult) // %T で型名を表示できます
}