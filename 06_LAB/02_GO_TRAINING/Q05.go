package main

import "fmt"

// テストの点数 score := 85 を判定し、80点以上なら「合格」、そうでなければ「不合格」と出力してください。
// 条件として、必ず 「ifの前置宣言（; を使う書き方）」 で score を定義してください。
// 【実験】 if文の外側で score を表示しようとして、Goに怒られる（コンパイルエラー）のを体験してください。

func main() {
	// 1. ifの前置宣言で score を定義
	if score := 85; score >= 80 {
		fmt.Printf("結果：合格（スコア：%d）\n", score)
	} else {
		fmt.Printf("結果：不合格（スコア：%d）\n", score)
	}

	// 2. 【わざとエラーを出す】
	// ここで score を使おうとするとどうなるか？
	// fmt.Println("外側のスコア:", score) 
}