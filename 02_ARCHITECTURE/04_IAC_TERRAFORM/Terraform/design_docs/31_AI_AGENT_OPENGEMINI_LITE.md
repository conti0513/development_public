# OpenGemini-Lite 実装メモ (2026.02.16 暫定版)

Slackから入ってきたメモをGeminiでいい感じにMarkdown化して、GitHubのPRまで自動で持っていく仕組み。
数日間にわたる「動かない」との格闘を経て、ようやく「これなら安定する」と言える形に落ち着いたので、その要点をまとめる。

---

## 1. ざっくりとした仕組み

今の構成は、**「Slack → Cloud Run (Go) → GitHub Actions」** の3段構え。

* **Cloud Run (Go)**: 「脳みそ」担当。Slackの3秒ルールをGoroutineで回避しつつ、Geminiに構造化（JSON化）を依頼する。
* **GitHub Actions**: 「手足」担当。Goから飛んできたデータをファイルにして、プルリク（PR）を投げる。

---

## 2. 現場でハマったポイントと対策 (教訓)

### ① 特殊文字による「自爆」対策 (Base64)

一番苦労したのが、AIが生成したMarkdownの中に `$`, `( )`, `"` とかの記号が入ると、GitHub Actionsのシェルが誤作動してエラーを吐く問題。

* **対策**: Go側で中身を一旦 **Base64** でグチャグチャ（符号化）にして送り、GitHub側で受け取った瞬間に戻すことにした。これで、どんな変な記号が来ても壊れない「セキュアなトンネル」が完成。

### ② モデル名「404」との根競べ (Alias)

モデル名を `gemini-1.5-flash` と律儀に書くと、SDKのバージョンによって「そんなモデルはない」と怒られる。

* **対策**: `gemini-flash-latest` という「エイリアス（あだ名）」を指定。これでGoogle側がその時一番安定しているモデルを勝手に選んでくれるようになり、404エラーを撲滅。

### ③ 安全フィルターの「全開放」

デフォルトだと、ちょっとした破壊的なコマンド例（`rm -rf` とか）を書くとGeminiがビビって回答を拒否する。

* **対策**: `SafetySettings` を `HarmBlockNone`（全開放）に設定。余計な忖度をさせず、エンジニアの書いたコードをそのまま構造化させるように教育し直した。

---

## 3. 実装のキモ (Goのコード抜粋)

「ここだけは変えるな」というポイント。

```go
// モデルは「あだ名」で指定するのが安定の秘訣
model := client.GenerativeModel("gemini-flash-latest")

// 特殊文字でGitHub側を壊さないよう、Base64で「封印」して送る
encodedContent := base64.StdEncoding.EncodeToString([]byte(res.Content))

// GitHubへのDispatch
payload, _ := json.Marshal(map[string]interface{}{
    "event_type": "ai-exec-command",
    "client_payload": map[string]interface{}{
        "content": encodedContent, // 封印済みデータ
        "reqID":   reqID,
    },
})

```

---

## 4. 最後に

エラーが「動かない（404/127）」から「回数制限（429）」に変わった時、それは実装が「正解」に辿り着いた合図。
あとはAPIの枠が回復するのを待って、Slackを叩くだけ。
AI時代といっても、最後は「URLの1文字」や「記号のパース」といった泥臭い修正が、システムを動かす力になる。

---