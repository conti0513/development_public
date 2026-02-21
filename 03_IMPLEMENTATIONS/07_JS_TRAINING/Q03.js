/**
 * Mastery Drill: No.03 (Arithmetic Operations)
 * --------------------------------------------------
 * 【お題】変数 x(10) と y(20) を足して結果を出力する
 * --------------------------------------------------
 */

var x = 10;
var y = 20;

// --- [ES5: Legacy Style] ---
// 文字列結合と計算が混ざるとバグの元。カッコで囲うのが「古参の知恵」。
var result_legacy = x + y;
console.log('ES5 Result: ' + result_legacy); 
// ※ もし console.log('Result: ' + x + y); と書くと "Result: 1020" になる罠！


// --- [ES6: Modern Style] ---
// テンプレートリテラルなら計算式を直接埋め込めて安全。
const x_m = 10;
const y_m = 20;
console.log(`ES6 Result: ${x_m + y_m}`);
/**
 * 【解法ポイント】
 * ES5では「'合計: ' + x + y」と書くと文字列結合で事故るため、(x + y) と括弧で括るのが鉄則。
 */
