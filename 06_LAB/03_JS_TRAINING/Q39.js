/**
 * Mastery Drill: No.39 (for-in / プロパティの全走査)
 * --------------------------------------------------
 * 【シナリオ】
 * 外部APIのレスポンス（userObj）のすべての項目をループで回し、
 * キーと値をセットでログ出力せよ。
 * --------------------------------------------------
 */

var userObj = {
    id: "U001",
    name: "Taro",
    role: "Admin",
    status: "Active"
};

// --- [基本形] ---
for (var key in userObj) {
    // userObj[key] で、動的に値を取得できる（ブラケット記法）
    console.log("Q39: " + key + " の値は " + userObj[key] + " です");
}


// --- [実務での活用: 特定のキーがあるか探す] ---
var targetKey = "role";
var hasRole = false;

for (var k in userObj) {
    if (k === targetKey) {
        hasRole = true;
        break; 
    }
}
console.log("Q39 Search Result: " + (hasRole ? "見つかりました" : "ありません"));

/**
 * 【ハックのポイント：精読時の眼力】
 * 1. Object.keys (Extra B) との違い:
 * Object.keys は「配列」を生成しますが、for-in は配列を作らずに
 * 直接ループを回します。メモリ節約のために古いコードでは for-in が好まれます。
 * 2. 継承の罠 (hasOwnProperty):
 * 実は for-in は、そのオブジェクトが「親」から受け継いだ余計なプロパティまで
 * 拾ってしまうことがあります。精読中、if (obj.hasOwnProperty(key)) という
 * 判定が中に入っていたら、それは「混じりけのないデータだけを扱いたい」という
 * 非常に誠実なプロのコードです。
 */