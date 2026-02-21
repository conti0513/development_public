/**
 * Mastery Drill: No.04 (Array Declaration)
 * --------------------------------------------------
 * 【お題】配列 arr に 1, 2, 3 を入れる
 * --------------------------------------------------
 */

// --- [ES5: Legacy Style] ---
// varを使用。操作は push や length など基本は同じ。
var arr_legacy = [1, 2, 3];
console.log('ES5 Array: ' + arr_legacy.join(', '));


// --- [ES6: Modern Style] ---
// constを使用。
const arr_modern = [1, 2, 3];
console.log(`ES6 Array: ${arr_modern}`);

// [補足] モダンならスプレッド演算子で展開して結合なども可能
const new_arr = [...arr_modern, 4]; // [1, 2, 3, 4]

/**
 * 【解法ポイント】
 * ES5ではスプレッド演算子 (...) が使えない。配列操作は push/join 等の基本メソッドに頼る。
 */
