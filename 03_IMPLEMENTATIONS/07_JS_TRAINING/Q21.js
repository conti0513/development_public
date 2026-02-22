/**
 * Mastery Drill: No.21 (JSON.parse / 文字列からオブジェクトへ)
 * --------------------------------------------------
 * 【シナリオ】
 * DBのカラムやAPIから届いた「JSON文字列」をJSで操作可能な「オブジェクト」に変換せよ。
 * また、不正なデータが来た際にシステムがクラッシュするのを防げ。
 * --------------------------------------------------
 */

// 1. 正常なケース
var jsonStr = '{"id": 101, "name": "Tanaka", "roles": ["admin", "editor"]}';
var userObj = JSON.parse(jsonStr);

console.log('Q21 ID: ' + userObj.id);     // 101
console.log('Q21 Role: ' + userObj.roles[0]); // admin


// 2. 実務の防衛策（try-catch）
// もし文字列が空だったり、形式が壊れていると JSON.parse は即死（エラー）する。
var brokenJson = '{"id": 102, "name": "Suzuki", }'; // おしりのカンマが余分（不正なJSON）

try {
    var result = JSON.parse(brokenJson);
    console.log(result.name);
} catch (e) {
    // ここでエラーをキャッチしないと、スクリプト全体の実行が止まる。
    console.error('Q21 Error: JSONの形式が正しくありません。');
}

/**
 * 【ハックのポイント：精読の眼力】
 * ・JSON.parse() に渡す文字列の「シングルクォート」と「ダブルクォート」に注意。
 * JSON規格ではキーも値も "ダブルクォート" が必須です。
 * ・「気まずいスクリプト」の中に try-catch なしの JSON.parse を見つけたら、
 * それは「データが壊れた瞬間にシステムが止まる」爆弾コードです。
 */