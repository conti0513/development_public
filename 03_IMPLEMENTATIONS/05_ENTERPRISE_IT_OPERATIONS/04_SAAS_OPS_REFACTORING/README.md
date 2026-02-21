# Slack Ops Modernization: Deployment & Connection Report

---

## 1. 概要

本レポートは、既存のレガシー運用基盤を Google Cloud Run および Slack Bolt SDK を用いて再構成した際の実装内容、発生した課題、および対応内容を整理したものである。

主な目的は以下の通り。

- 認証・認可の明確化
- Secret の安全な管理
- IAM 最小権限化
- 設定手順の標準化
- 再利用可能な ChatOps 構成の確立

---

## 2. 実装環境

- Runtime: Node.js 20.x（Cloud Run）
- Framework: Slack Bolt SDK
- 認証方式: HMAC-SHA256 Signature Verification
- データストア: BigQuery
- Secret 管理: Secret Manager
- デプロイ: gcloud CLI

---

## 3. 疎通確認済みエンドポイント

```

[https://legacy-app-uej4aqldoq-an.a.run.app/slack/events](https://legacy-app-uej4aqldoq-an.a.run.app/slack/events)

```

確認項目：

- Slash Commands の Request URL と一致
- Event Subscriptions の Request URL と一致
- Interactivity の Request URL と一致
- `/slack/events` パスが付与されていること

---

## 4. 発生した課題と対応内容

| カテゴリ | 課題内容 | 原因 | 対応 |
|----------|------------|------------|------------|
| Authentication | Slack `dispatch_failed` (401) | Signing Secret 不一致、Secret更新未反映 | Secret Manager更新後、Cloud Run再デプロイ |
| Network | スラッシュコマンド無応答 | Cloud Run URL と Slack 設定不一致 | 実URLを確認しSlack側3箇所修正 |
| Security/IAM | 403 Forbidden | Invoker未設定 | `roles/run.invoker` を `allUsers` に付与 |
| Authorization | `missing_scope` | `chat:write` 未設定 | Scope追加後、App再インストール |
| Infrastructure | Codespaces停止 | 月間利用上限到達 | Spending Limit調整 |

---

## 5. Slack API 設定チェックリスト

### 5.1 Endpoints

- [ ] Slash Commands URL 一致
- [ ] Event Subscriptions URL 一致
- [ ] Interactivity URL 一致
- [ ] `/slack/events` パス確認

### 5.2 Scopes

- [ ] `chat:write`
- [ ] `chat:write.public`
- [ ] Scope変更後に再インストール実施

### 5.3 Secret確認

- [ ] Signing Secret 一致確認
- [ ] Bot Token のワークスペース確認
- [ ] Cloud Run 最新リビジョン確認

---

## 6. 稼働確認

実行コマンド：

```

/task-check-lab ASIS-BOMB

````

確認結果：

- BigQueryから対象レコード取得
- Slackへメッセージ送信成功
- Bolt SDK `say()` 正常動作確認

---

## 7. アーキテクチャ比較

### 7.1 AS-IS

課題：

- トークンのハードコード
- IAM過剰権限
- ロジック密結合
- 変更影響範囲不明

```mermaid
graph TD
    User([ユーザー]) -- "/task-check-lab" --> Slack[Slack API]
    Slack -- "Webhook" --> CR[Cloud Run: legacy-app]
    
    subgraph CloudRun [Legacy Logic]
        Code[legacy_system.js]
        Secret[Hardcoded Token]
        Logic[Monolithic Logic]
        Code --- Secret
        Code --- Logic
    end

    CR -- "roles/owner" --> BQ[(BigQuery)]
````

---

### 7.2 TO-BE

改善点：

* Secret Manager 管理
* 署名検証有効化
* IAM最小権限
* クエリのパラメータ化

```mermaid
graph TD
    User([ユーザー]) -- "/task-check" --> Slack[Slack API]
    Slack -- "Verified Webhook" --> CR[Cloud Run]
    
    subgraph GCP
        subgraph SM
            S1[SLACK_BOT_TOKEN]
            S2[SLACK_SIGNING_SECRET]
        end
        
        subgraph CR_Modern
            App[Refactored Logic]
            IAM[Least Privilege SA]
        end
        
        BQ[(BigQuery)]
    end

    S1 -.-> App
    S2 -.-> App
    App --> BQ
    IAM --> BQ
```

---

## 8. 今後の改善項目

* 非同期処理（Cloud Tasks）への移行検討
* リトライ対策（idempotency設計）
* TerraformによるIaC化
* ログ構造化と監視強化

---

## 9. まとめ

本対応により、

* 認証・認可の明確化
* Secretの安全管理
* IAMの最小権限化
* 設定手順の標準化

を実現した。

今後はIaC化と監視強化を進め、再利用可能な構成として整備する。

