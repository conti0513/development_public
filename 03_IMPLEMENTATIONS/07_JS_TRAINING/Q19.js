/**
 * Mastery Drill: No.18 (Array.find / 1件抽出)
 * --------------------------------------------------
 * 【シナリオ】
 * 全ユーザーリストから、特定のIDを持つ「1人」を最速で特定せよ。
 * --------------------------------------------------
 */

var users = [
    { id: "USER_001", name: "Taro" },
    { id: "USER_002", name: "Jiro" },
    { id: "USER_003", name: "Saburo" }
];

var searchId = "USER_003";

// --- [モダンな1件検索] ---
// 条件に一致した「最初の1件」を見つけた瞬間にループを終了する。
var targetUser = users.find(function(u) {
    return u.id === searchId;
});

// --- [防衛策：存在確認の徹底] ---
if (targetUser) {
    console.log('Q18 発見：' + targetUser.name);
} else {
    // ここを通さず参照すると「Cannot read property... of undefined」で落ちる
    console.log('Q18：対象が見つかりません。');
}

/**
 * 【ハックのポイント：精読の眼力】
 * * 1. [find vs filter]
 * filterは「条件に合うものを全部集めて配列にする」が、findは「最初の1つだけ」で止まる。
 * ID検索のように一意のものを探すなら、計算効率が良い find を選んでいるかチェック。
 * * 2. [見つからない前提の設計]
 * find の戻り値は、見つからないと「undefined」になる。
 * その直後に targetUser.name と書いているコードは、未入力データが来た瞬間に爆死する「地雷」である。
 * 1行ハック：「for文を回して if(match){ break; } する泥臭いコードを見つけたら、find 1行へのリファクタリング対象と心得よ」
 */