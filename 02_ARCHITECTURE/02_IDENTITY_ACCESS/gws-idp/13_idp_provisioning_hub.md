# 🛡️ IdP Provisioning Hub

## Source of Truth に基づくマルチSaaS ID同期基盤

---

## 1. 概要

本プロジェクトは、人事スプレッドシートおよび承認済みワークフローを起点とし、

* Google Workspace（GWS）
* Microsoft 365（M365）
* その他SaaS（VPN / Slack / Apple Business Manager 等）

へ ID を安全かつ自動的に同期する **IdP中核基盤（Provisioning Hub）** の設計である。

目的は単なる自動化ではない。

> 「誰がどのSaaSにアクセスできるか」という認証の中枢を、
> 個人依存から脱却させ、再現可能なアーキテクチャで定義すること。

---

# 2. 全体アーキテクチャ

本システムは **疎結合3層構造** を採用する。

```text
[入力層]                     [処理層]                    [実行層]
+-----------------+          +------------------+        +------------------+
| 人事スプレッド  |          | Cloud Run (Go)   | -----> | Google Workspace |
| 承認WF          |          |                  |        +------------------+
+--------+--------+          | 1. Validation    |
         |                   | 2. Diff Calc     | -----> | Microsoft 365    |
         | POST JSON         | 3. ConstraintChk |        +------------------+
         ▼                   | 4. Dry-run       |
+--------+--------+          | 5. Execute       | -----> | その他SaaS        |
| GAS / Gateway   |          | 6. Audit Log     |        +------------------+
+-----------------+          +---------+--------+
                                       |
                                       ▼
                               Cloud Logging / JSONL
```

---

# 3. 各レイヤーの責務

## 3.1 入力層（Input）

* 人事スプレッドシートをUIとして維持
* 承認済フラグをトリガーにJSON発行
* GAS/AppSheetは **単なるGateway**

👉 入力層は「事実を記録する」だけ。ロジックは持たない。

---

## 3.2 処理層（Planner / Hubの心臓部）

Cloud Run（Go）にて以下を実行。

### ① Validation

* 必須キー検証
* employee_idの一意性確認
* ライセンス種別妥当性チェック

### ② Diff計算

「あるべき状態」と「現在の状態」の差分を算出。

* CREATE
* UPDATE
* SUSPEND

👉 命令ベースではなく、**状態ベース更新（冪等設計）**

---

### ③ 制約チェック（Accumulation思想）

単なるID追加ではなく、

* ライセンス枠超過
* グループ上限
* API制限
* SPFのような累積制限思想

を事前検証。

これは過去のSPF 10-Lookup問題から得た思想を転用している。

---

### ④ Dry-run → Execute

* `is_dry_run = true` → 差分表示のみ
* false → 実API呼び出し

---

### ⑤ 監査ログ出力

* JSONL形式
* request_id付与
* approval_no紐付け
* Severity付き構造化ログ

---

## 3.3 実行層（Execute）

各SaaS APIを直接叩く。

### Google Workspace

* Admin SDK
* OU配置
* グループ追加
* 属性更新

### Microsoft 365

* Microsoft Graph API
* ライセンス付与
* ユーザー作成

### その他SaaS

* GWSグループをSource of Truth化
* SCIM連携が可能なものはSCIM経由

---

# 4. JSONインターフェース仕様

本システムの共通言語。

```json
{
  "request_meta": {
    "approval_no": "WF-2026-001",
    "operator": "admin@example.com",
    "is_dry_run": true
  },
  "payload": [
    {
      "action": "CREATE",
      "employee_id": "12345",
      "target": {
        "email": "user@example.com",
        "name_ja": "山田 太郎",
        "dept": "営業部",
        "title": "マネージャー",
        "m365_license": "E3",
        "gws_ou": "/Sales",
        "termination_policy": "MOVE_TO_ARCHIVE"
      }
    }
  ]
}
```

特徴：

* フラット構造
* 人間が読める
* 手動転記可能
* AIが解釈しやすい

---

# 5. プロビジョニング戦略（結果整合性対策）

## HENNGE + GWS の時差問題対策

* HENNGE：SSOの器を作成
* GWS：属性を直接Admin SDKで注入

👉 認証とディレクトリを分離し、整合性ラグを吸収。

---

# 6. エラーハンドリング設計

## 自動リトライ

* Exponential Backoff
* 最大3回

## 冪等性

* 状態ベース更新
* 二重実行でも破壊しない

---

# 7. 監視・通知設計

```text
Cloud Run
   ↓
Cloud Logging
   ↓
Log Router
   ↓
Pub/Sub
   ↓
Cloud Functions
   ↓
Slack通知
```

通知対象：

* ERROR以上
* ライセンス不足
* API認証失敗
* Dry-run結果サマリー

通知内容：

* Target User
* Action
* Approval No
* Reason

👉 「次に人間が何をすべきか」が分かる通知にする。

---

# 8. SaaS連携方針（実戦的整理）

### M365

Cloud Run → Graph API

### VPN

SAML統合（個別パスワード廃止）

### Apple Business Manager

GWS / Entra IDとのFederation

### Slack

GWSグループをSource of Truth化

---

# 9. 非常時マニュアル（最終防衛線）

1. Cloud LoggingからJSON取得
2. 本仕様に基づき手動登録
3. 手動作業ログを別保存
4. 復旧後に突合

---

# 10. 設計思想の核

このHubは単なる自動化ツールではない。

* Source of Truth の明確化
* 冪等設計
* 累積制限思想の内包
* AI時代の保守性

を前提にした **IdP中枢基盤の抽象設計** である。

---

# 11. 優先順位（ポートフォリオ戦略）

1. GWS属性注入（心臓部）
2. M365ライセンス付与
3. 監査ログ + 通知
4. Apple/VPNは設計提示レベル

👉 全部作らない。心臓部を作る。

---
