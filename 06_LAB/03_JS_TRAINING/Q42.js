/**
 * Mastery Drill: No.42 (Env Detection / 環境判定)
 * --------------------------------------------------
 * 【シナリオ】
 * 開発環境(Dev)では詳細なログを出し、本番(Prod)では秘匿情報を隠蔽せよ。
 * --------------------------------------------------
 */

// SaaSのシステムプロパティ等から環境名を取得するイメージ
var currentEnv = gs.getProperty('instance_name'); // 例: 'dev', 'test', 'prod'

var config = {
    apiKey: "SECRET_KEY_PROD",
    isDebug: false
};

// 環境に応じた「身バレ・事故防止」の切り替え
if (currentEnv === 'dev') {
    config.apiKey = "DUMMY_KEY_DEV"; // 開発用はダミー
    config.isDebug = true;           // 開発中のみログを出す
}

if (config.isDebug) {
    console.log("Q42 Debug: 現在の開発用APIキーは " + config.apiKey);
}

/**
 * 【精読ポイント：身バレを防ぐために】
 * 1. ハードコーディングの禁止:
 * コードの中に直接パスワードや個人名、機密URLを書き込んではいけません。
 * 必ず「環境変数」や「システムプロパティ」から読み込むように作られているかチェックします。
 * 2. ログの検疫:
 * 開発中に console.log(userObject) と書くと、本番で個人情報がログに流れるリスクがあります。
 */