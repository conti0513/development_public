package main

import "fmt"

func main() {
	// 1. varを使った明示的な宣言（PHPにはない感覚）
	var name string = "conti0513"

	// 2. := を使った短縮宣言（Goで最も使われる書き方）
	age := 51
	job := "Engineer"

	// 3. Printfでフォーマット出力
	// %s = string, %d = decimal(int)
	fmt.Printf("名前：%s、年齢：%d歳、現職：%s\n", name, age, job)
}