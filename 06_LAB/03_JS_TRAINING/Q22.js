/**
 * Mastery Drill: No.22 (JSON.stringify / 荷造りと可視化)
 * --------------------------------------------------
 * 【シナリオ】
 * 1. オブジェクトをDB保存用、またはAPI送信用の文字列に変換せよ。
 * 2. 巨大なオブジェクトの中身を、読みやすく整形してログに出力せよ。
 * --------------------------------------------------
 */

var userObj = {
    id: 101,
    name: "Tanaka",
    roles: ["admin", "editor"],
    config: {
        theme: "dark",
        notifications: true
    }
};

// --- [1. 基本の直列化] ---
// 1行の文字列になる。API送信やDB保存に最適。
var minifiedJson = JSON.stringify(userObj);
console.log('Q22 (Minified): ' + minifiedJson);


// --- [2. プロのデバッグ技（整形出力）] ---
// 第3引数に「スペースの数」を指定すると、改行とインデントが入る。
// これを使わないと、複雑なオブジェクトのデバッグは不可能。
var prettyJson = JSON.stringify(userObj, null, 4); 
console.log('Q22 (Pretty Print):\n' + prettyJson);


/**
 * 【ハックのポイント：精読時の武器】
 * 1. [object Object] の呪い:
 * ログに console.log("Data: " + obj); と書くと "[object Object]" としか出ない。
 * 必ず JSON.stringify(obj) で中身をさらけ出すのが鉄則。
 * * 2. データの欠損に注意:
 * 値が `undefined` のプロパティや「関数」は、stringify すると消滅する。
 * 「送ったはずのデータが届いていない」原因の多くはこれ。
 * ポイント：「中身が見えないオブジェクトは JSON.stringify() で文字列化して、中身を丸裸にせよ」
 */