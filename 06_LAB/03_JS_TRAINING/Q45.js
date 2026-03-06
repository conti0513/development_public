/**
 * Mastery Drill: No.45 (Async & Timeout / インフラ連動の制御)
 * --------------------------------------------------
 * 【シナリオ】
 * 1. 外部API（Slack等）を叩く際、応答がない場合に処理を強制終了させよ。
 * 2. タイムアウト時間は、Terraformから注入された設定値（プロパティ）を使用せよ。
 * --------------------------------------------------
 */

// Terraform側 variable "api_timeout_ms" { default = 5000 } からの値と想定
var TIMEOUT_LIMIT = parseInt(gs.getProperty('ext_api.timeout_ms')) || 3000;

function callExternalApi() {
    var request = new sn_ws.RESTMessageV2('Slack API', 'post');
    
    // ✅ タイムアウト設定をプロパティ（Terraform管理）から反映
    request.setHttpTimeout(TIMEOUT_LIMIT); 

    try {
        var response = request.execute();
        var httpStatus = response.getStatusCode();
        
        if (httpStatus === 200) {
            console.log("Q45: API通信成功");
        }
    } catch (e) {
        // タイムアウト発生時はここに入る
        console.error("Q45: 指定の " + TIMEOUT_LIMIT + "ms 以内に応答がありませんでした。");
    }
}

/**
 * 【現場での勝ち筋】
 * インフラ(Terraform)で「10秒」と決めた制限時間を、JS側で「15秒」に
 * 設定してしまうと、インフラ側で先に切断され、原因不明のエラーに悩まされます。
 * 「設定値のソース（出処）」を一本化するのが、トラブルを防ぐ鍵です。
 */