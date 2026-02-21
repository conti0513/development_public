# 📝 Slack Ops Refactoring: Connection Checklist

このドキュメントは、SaaS Ops リファクタリングにおいて Slack API と Google Cloud Run を接続する際の「死のトラップ」を回避するための備忘録である。

## 1. インフラ・エンドポイント層 (Network)

Slackがサーバーを見つけられない「サイレント拒絶」を防ぐ。

* [ ] **Request URL の完全一致**:
* `gcloud run services describe` で得られる最新のURL（例: `https://...run.app`）に、プログラムで定義したパス（例: `/slack/events`）が正確に付与されているか。
* **確認箇所**: `Slash Commands`, `Event Subscriptions`, `Interactivity & Shortcuts` の3箇所。


* [ ] **IAM 権限 (Allow Unauthenticated)**:
* 外部（Slack）からのアクセスを許可するため、`roles/run.invoker` に `allUsers` が割り当てられているか。


* [ ] **物理再インストール**:
* URLを変更した後は、必ず **`Install App > Reinstall to Workspace`** を実行してSlack内部のルーティングキャッシュを更新したか。



## 2. セキュリティ層 (Authentication)

`dispatch_failed` (401 Unauthorized) を防ぐ。

* [ ] **Signing Secret の整合性**:
* Secret Manager に登録された値が、Slack 管理画面の `Basic Information > Signing Secret` と1文字も違わず一致しているか。


* [ ] **シークレットの即時反映**:
* 鍵を更新した際、Cloud Run のリビジョンを新しくデプロイ（または update）して、最新の鍵を再ロードさせたか。



## 3. 権限層 (OAuth Scopes)

`missing_scope` エラー（サーバーは動いているがSlackが拒絶する状態）を防ぐ。

* [ ] **Bot Token Scopes**:
* アプリがメッセージを投稿するために **`chat:write`** が付与されているか。
* 公開チャンネルへの投稿をスムーズにするために **`chat:write.public`** があるか。


* [ ] **権限変更後の Reinstall**:
* Scope を追加した後は、黄色いバナーの **`reinstall your app`** をクリックしてトークンを更新したか。



## 4. アプリケーション動作層 (Runtime)

* [ ] **3秒ルール (Timeout)**:
* Slack API は 3秒以内に `ack()` (HTTP 200) を返さないとエラーになる。BigQuery 等の重い処理の前にレスポンスを返しているか。


* [ ] **環境変数**:
* `SLACK_BOT_TOKEN` (xoxb-...) が正しくセットされているか。



---

### 💡 運用エンジニアへの訓示

> 「何も起きない」ときはURLを疑え。「エラーが出る」ときは権限を疑え。「金で解決できる環境」があるなら、迷わず予算上限を上げろ。

---