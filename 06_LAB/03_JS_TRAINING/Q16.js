/**
 * Mastery Drill: No.17 (JSON Parsing & Data Cleaning)
 * --------------------------------------------------
 * 【シナリオ】
 * DBから届いた不完全なJSON文字列をパースし、
 * IDが欠落している「ゴミデータ」を除去して、有効なリストを作成せよ。
 * --------------------------------------------------
 */

// 1. DBやAPIから届いた「生のJSON文字列」
var rawJsonResponse = '[{"id": 101, "name": "Taro"}, {"id": null, "name": "Guest User"}, {"id": 103, "name": "Saburo"}]';

// 2. 文字列をJSオブジェクト（配列）に変換
var allUsers = JSON.parse(rawJsonResponse);

// 3. 【オシャレな刻み】filterを使って有効なユーザーだけに絞り込む
// 変数名に「active」や「clean」と付けることで、意図を明確にする
var activeUsers = allUsers.filter(function(user) {
    // IDが存在し、かつ null でないものだけを true として残す
    return user.id !== null && user.id !== undefined;
});

// 4. 結果の出力
console.log('--- 処理結果 ---');
console.log('全データ件数: ' + allUsers.length + ' 件');
console.log('洗浄後データ: ' + activeUsers.length + ' 件');

// 洗浄後のデータをループで回して確認
activeUsers.forEach(function(user) {
    console.log('有効なユーザー: ID[' + user.id + '] Name[' + user.name + ']');
});

/**
 * 【ハックのポイント】
 * ・JSON.parse した直後の `allUsers` をそのまま使わず、一度 `filter` を通す。
 * ・この「一工程挟む」余裕が、後続の処理（mapや計算）でのエラーを防ぐ。
 * 1行ハック：「for文で if 判定して push する泥臭いコードを見つけたら、filter 1行でエレガントに『検疫』せよ」
 */