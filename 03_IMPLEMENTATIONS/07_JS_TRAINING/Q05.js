/**
 * Mastery Drill: No.05 (Accessing Array Elements)
 * --------------------------------------------------
 * 【お題】配列の最初の要素（インデックス0）を取得する
 * --------------------------------------------------
 */

var arr = [10, 20, 30];

// --- [ES5: Legacy Style (PHPの $val = $arr[0] と同じ)] ---
// 1つずつ地道に変数へ代入します。
var first_legacy  = arr[0];
var second_legacy = arr[1];
console.log('ES5: ' + first_legacy + ', ' + second_legacy);


// --- [ES6: Modern Style (分割代入)] ---
// 左辺に [ ] を書くことで、「配列の中身をこの変数たちに配れ！」と命令できます。
const [a, b] = arr; 
console.log(`ES6: ${a}, ${b}`); 


/* ▼ 配列アクセスの比較表
 *  -------------------------------------------------------------
 *  | 機能 | ES5 (Legacy) | PHP (Reference) | ES6 (Modern) |
 *  | :--- | :--- | :--- | :--- |
 *  | 基本取得 | arr[0] | $arr[0] | arr[0] |
 *  | 一括取得 | (なし) | list($a, $b) = $arr | [a, b] = arr |
 *  | 存在確認 | indexOf() | in_array() | includes() / indexOf() |
 *  -------------------------------------------------------------
 */

/**
 * 【解法ポイント】
 * 1. 分割代入はES6からの新機能。ES5（ServiceNow等）で [a, b] = arr と書くと構文エラーで即死する。
 * 2. PHPの list() に慣れているなら、ES6の分割代入は非常に親和性が高い。
 * 3. 実務（ES5）では、地道に arr[0] で取得しつつ、取得した値が null や undefined でないかチェックする慎重さが求められる。
 */
