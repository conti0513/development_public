package main

import "fmt"


//Q3 "7 は奇数です（余り: 1）"とでればOK

func main() {
    num := 7

    // ここに if 前置宣言を使って書いてください
    if remainder := num % 2; remainder == 0 {
        fmt.Printf("%d は偶数です（余り: %d）\n", num, remainder)
    } else {
        fmt.Printf("%d は奇数です（余り: %d）\n", num, remainder)
    }

    // fmt.Println(remainder) // ここで呼ぶとエラーになることをイメージしてください
}