/**
 * Mastery Drill: No.36 (isNaN / 非数値の防衛)
 * --------------------------------------------------
 * 【シナリオ】
 * 1. 外部から届いた「価格」と「個数」を計算せよ。
 * 2. 入力が数値でない場合、NaNの拡散を防ぎ、デフォルト値 0 で計算を完結させよ。
 * --------------------------------------------------
 */

var rawPrice = "1200";
var rawQty = "abc"; // ユーザーの入力ミスやDBのゴミデータ

// --- [1. NaNの発生] ---
var price = parseInt(rawPrice); // 1200
var qty = parseInt(rawQty);     // NaN (Not a Number)

// --- [2. NaNの汚染（スプレッド現象）] ---
// NaNが一度混じると、どんな計算をしても結果は NaN になる
var total = price * qty; 
console.log("Q36 Total (汚染後):", total); // NaN


// --- [3. プロの防衛術：isNaNでの検疫] ---
var safeQty = parseInt(rawQty);

if (isNaN(safeQty)) {
    // もし数値変換に失敗していたら、0として扱う（または処理を中断する）
    console.warn("Q36: 個数が正しくありません。0として処理します。");
    safeQty = 0; 
}

var safeTotal = price * safeQty;
console.log("Q36 Safe Total:", safeTotal); // 0 (計算が成立する)

/**
 * 【ハックのポイント：精読時の眼力】
 * 1. 「NaN === NaN」は false:
 * NaNは特殊すぎて、自分自身と比較しても false になります。
 * そのため `if (num === NaN)` というコードは絶対に動きません。
 * 必ず `isNaN(num)` を使っているかチェックしてください。
 * * 2. 0 vs NaN:
 * Q13で学んだ通り、0 は「数値」ですが、NaN は「数値になれなかったゴミ」です。
 * 精読中、parseInt() や 割り算(/) をしている箇所を見つけたら、
 * その直後に isNaN チェックがあるか確認するのが「勝ち筋」です。
 */