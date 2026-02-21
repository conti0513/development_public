/**
 * Mastery Drill: No.02 (String Declaration)
 * --------------------------------------------------
 * 【お題】変数 s に文字列 "Hello" を代入する
 * --------------------------------------------------
 */

// --- [ES5: Legacy Style] ---
// シングルクォート (') または ダブルクォート (") を使用。
var s_legacy = 'Hello';
console.log('ES5 Result: ' + s_legacy);


// --- [ES6: Modern Style] ---
// 文字列そのものは const を使用。
const s_modern = 'Hello';

// 出力時にテンプレートリテラルを使うのがモダン流
console.log(`ES6 Result: ${s_modern}`);
/**
 * 【解法ポイント】
 * ES5ではテンプレートリテラル (` `) が使えないため、シングル/ダブルクォートを使い分ける。
 */
