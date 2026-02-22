/**
 * Mastery Drill: No.18 (Array Find & Guard Clauses)
 * --------------------------------------------------
 * 【シナリオ】
 * DBから届いた全ユーザーリスト（配列）の中から、
 * 特定のID（USER_003）を持つユーザーを1件だけ特定し、その名前を表示せよ。
 * --------------------------------------------------
 */

var users = [
    { id: "USER_001", name: "Taro" },
    { id: "USER_002", name: "Jiro" },
    { id: "USER_003", name: "Saburo" }
];

var searchId = "USER_003";

// --- [モダンな1件検索：find] ---
// findは条件に合う「最初の1要素」を返す。なければ undefined を返す。
// filter(配列を返す) との違いを意識するのがプロの所作。
var targetUser = users.find(function(u) {
    return u.id === searchId;
});

// --- [プロのガード句（防御）] ---
// データが見つからなかった時に targetUser.name を参照すると
// "Cannot read property 'name' of undefined" でシステムが死ぬため、必ず存在チェックを入れる。
if (targetUser) {
    console.log('Q18 ターゲット発見：' + targetUser.name);
} else {
    console.log('Q18 エラー：ID ' + searchId + ' は存在しません。');
}

/**
 * 【ハックのポイント】
 * 1. 計算効率: 
 * filterは全件チェックしますが、findは見つかった瞬間にループを抜けるので高速です。
 * 2. ServiceNow実務での応用:
 * GlideRecordで1件だけ取得したい時（get()メソッドなど）と同じ思考回路です。
 */