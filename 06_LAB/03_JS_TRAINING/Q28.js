/**
 * Mastery Drill: No.28 (String.trim / 空白除去)
 * --------------------------------------------------
 * 【シナリオ】
 * 外部システムから連携されたIDや、ユーザーが入力した値に
 * 紛れ込んだ「不要なスペース」を取り除き、完全一致を確実にせよ。
 * --------------------------------------------------
 */

var rawInput = "  admin_user  ";

// --- [基本の形] ---
// 文字列の「前」と「後」にあるスペース、タブ、改行をすべて削除する
var cleanInput = rawInput.trim();

console.log("Q28 Original: [" + rawInput + "]");
console.log("Q28 Trimmed:  [" + cleanInput + "]");

// --- [実務での致命的な差] ---
var dbValue = "admin_user";

if (rawInput === dbValue) {
    // ここは通らない（スペースがあるため）
}

if (rawInput.trim() === dbValue) {
    console.log("Q28 Success: 空白を除去したので一致しました！");
}

/**
 * 【ハックのポイント：精読時の眼力】
 * 1. 目に見えない敵:
 * ログに [admin_user] と出ていても、実は [admin_user ]（後ろに半角スペース）
 * というケースが非常に多いです。精読中は「入力を信じるな、まずtrimせよ」が鉄則。
 * * 2. 古い環境の代用（RegExp）:
 * 非常に古い環境では .trim() が使えないことがあり、
 * .replace(/^\s+|\s+$/g, '') という正規表現で代用されている場合があります。
 * これを見つけたら「あ、trimしてるんだな」と読み替えてください。
 */