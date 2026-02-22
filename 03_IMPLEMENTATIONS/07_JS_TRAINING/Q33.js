/**
 * Mastery Drill: No.33 (Short-circuit / デフォルト値の代入)
 * --------------------------------------------------
 * 【シナリオ】
 * 関数の引数が渡されなかった場合や、DBの項目が空だった場合に、
 * システムが止まらないよう「標準値（デフォルト）」をセットせよ。
 * --------------------------------------------------
 */

function greet(name) {
    // 【短絡評価の仕組み】
    // 左側 (name) が「偽」と判定される値なら、右側 ("Guest") を採用する。
    // JSの「偽」: null, undefined, "", 0, false, NaN
    var displayName = name || "Guest"; 
    
    console.log("Q33: Hello, " + displayName);
}

greet("Taro"); // "Hello, Taro"
greet("");     // "Hello, Guest" (空文字は偽なので右が採用される)
greet();       // "Hello, Guest" (undefinedは偽なので右が採用される)

/**
 * 【ハックのポイント：精読時の致命的な罠】
 * 1. 「0」や「false」も上書きされる:
 * もし `name` に数値の 0 を入れたい場合でも、0 は「偽」なので "Guest" になります。
 * 「0は有効な値として扱いたい」コードでこれを使っているのを見つけたら、
 * Q31 の厳密なチェック（=== null）への書き換えを提案すべきポイントです。
 * * 2. 連続コンボ:
 * var config = input.config || saved.config || "Default";
 * このように、「第1希望 || 第2希望 || 最終手段」という優先順位付けにも使われます。