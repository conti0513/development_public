/**
 * Mastery Drill: No.18 (Array Find)
 * --------------------------------------------------
 * 【シナリオ】
 * DBから取得した全ユーザーリストから、IDが "USER_003" の人を特定せよ。
 * --------------------------------------------------
 */

var users = [
    { id: "USER_001", name: "Taro" },
    { id: "USER_002", name: "Jiro" },
    { id: "USER_003", name: "Saburo" }
];

var searchId = "USER_003";

// --- [モダンな1件検索] ---
// findは条件に合う最初の1要素を返す。なければ undefined。
var targetUser = users.find(function(u) {
    return u.id === searchId;
});

// --- [プロのガード句] ---
// 見つからなかった時に .name を参照するとシステムが爆発するので必ずチェック
if (targetUser) {
    console.log('ターゲット発見：' + targetUser.name);
} else {
    console.log('エラー：ID ' + searchId + ' は存在しません。');
}