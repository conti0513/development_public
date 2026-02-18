package main

import "fmt"

func main() {
    price := 1000   // int
    tax := 1.1      // float64

    // price(int) を float64 に一時的に格上げして計算する
    total := float64(price) * tax

    fmt.Printf("Q02: 合計金額は %.1f 円です\n", total)
}