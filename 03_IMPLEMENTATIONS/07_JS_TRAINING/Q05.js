/**
 * Mastery Drill: No.05 (Accessing Array Elements)
 * --------------------------------------------------
 * 【お題】配列の最初の要素（インデックス0）を取得する
 * --------------------------------------------------
 */

var arr = [10, 20, 30];

// --- [ES5: Legacy Style] ---
// 配列の添字自体は共通ですが、取得した値の「型」に注意。
var first_legacy = arr[0];
console.log('ES5 Element: ' + first_legacy);


// --- [ES6: Modern Style] ---
// 分割代入（Destructuring）を使ってスマートに抜くのがモダン。
const [first_modern] = arr;
console.log(`ES6 Element: ${first_modern}`);
/**
 * 【解法ポイント】
 * ES5では分割代入 ([a, b] = arr) が不可。添字 [0] で地道にアクセスし、型変換を常に意識する。
 */
