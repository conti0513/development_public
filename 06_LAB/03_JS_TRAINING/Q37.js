/**
 * Mastery Drill: No.37 (try-catch / クラッシュ回避術)
 * --------------------------------------------------
 * 【シナリオ】
 * 1. 外部から届いた不正な形式のJSONを処理せよ。
 * 2. システムを停止させず、エラーログを吐いて安全にデフォルト値を返せ。
 * --------------------------------------------------
 */

var dangerousJson = '{"id": 101, "status": "active", }'; // 末尾カンマがある不正なJSON

function parseSafe(jsonStr) {
    try {
        // --- [tryブロック] ---
        // ここに「失敗する可能性がある処理」を書く
        var data = JSON.parse(jsonStr);
        return data;

    } catch (e) {
        // --- [catchブロック] ---
        // エラーが発生した瞬間、処理がここにジャンプする
        // システムは止まらず、後続の処理が続けられる
        console.error("Q37 Error Catch: JSONの解析に失敗しました。");
        console.error("理由: " + e.message); // エラー内容を確認

        // 安全なデフォルト値を返す（フォールバック）
        return { id: 0, status: "unknown" };

    } finally {
        // --- [finallyブロック] ---
        // 成功しても失敗しても「必ず」実行される（後片付け用）
        console.log("Q37: 処理が完了しました（成功・失敗問わず）");
    }
}

var result = parseSafe(dangerousJson);
console.log("Q37 Result:", result); // クラッシュせず、デフォルト値が返る


/**
 * 【ハックのポイント：精読時の眼力】
 * 1. 「やりっぱなし」のパース:
 * 精読中、try-catch なしで `JSON.parse(str)` をしている箇所があれば、
 * 「ここ、データが1文字でも欠けたらサービス全体が落ちますよ」という最強の指摘ポイントになります。
 * 2. 変数の生存範囲（スコープ）:
 * try の中で `var data = ...` と宣言した変数は、外側からは見えなくなることがあります。
 * Q12（スコープ）の知識を活かし、変数を try の外で先に定義しておくのがプロの書き方です。
 */