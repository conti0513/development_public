# GCP IAM（ACE / 2026 最終版）

GCPのIAMは次の基本式で理解する。

```
Identity + Role → Resource
```

この関係を **Binding** が結び付ける。

IAMはこの式から理解すると整理しやすい。

---

# 1. IAMの基本構造

## 1.1 IAMの構成要素

```mermaid
graph TD
Identity --> Binding
Role --> Binding
Binding --> Resource

Identity --> User
Identity --> Group
Identity --> ServiceAccount

Role --> Basic
Role --> Predefined
Role --> Custom
```

| 要素       | 内容    |
| -------- | ----- |
| Identity | 誰     |
| Role     | 何ができる |
| Resource | どこ    |
| Binding  | 紐付け   |

IAMは

```
Identity + Role → Resource
```

の構造で権限を管理する。

---

# 2. Identity（主体）

## 2.1 Identityの種類

| Identity        | 用途  |
| --------------- | --- |
| User            | 人   |
| Group           | チーム |
| Service Account | アプリ |

---

## 2.2 運用ベストプラクティス

```
User → Group → Role
```

理由

* User直接付与は管理不能
* Groupで管理する

---

## 2.3 ACE試験判断

```
人管理 → Group
```

---

# 3. IAM階層

IAMは **上位階層から継承**される。

## 3.1 IAM階層構造

```mermaid
graph TD
Organization --> Folder
Folder --> Project
Project --> Resource
```

| レベル          | 用途 |
| ------------ | -- |
| Organization | 全社 |
| Folder       | 部門 |
| Project      | 環境 |
| Resource     | 個別 |

---

## 3.2 ACE判断

```
全Project制御 → Organization IAM
```

---

# 4. IAM Policy

IAMは **Policy → Binding** で構成される。

## 4.1 Policy例

```
member: user:alice@example.com
role: roles/viewer
```

---

## 4.2 Policy構造

```mermaid
graph TD
Policy --> Binding
Binding --> Member
Binding --> Role
```

---

# 5. Role

## 5.1 Roleの種類

| 種類         | 説明                      |
| ---------- | ----------------------- |
| Basic      | viewer / editor / owner |
| Predefined | Google提供                |
| Custom     | 独自作成                    |

---

## 5.2 ACE判断

```
最小権限 → Predefined Role
```

理由

```
Basic Roleは広すぎる
```

---

# 6. Service Account

Service Accountは **アプリ用Identity**。

---

## 6.1 Service Account利用例

```mermaid
graph TD
Compute --> ServiceAccount
ServiceAccount --> GCP_API
```

| シナリオ            | 解決              |
| --------------- | --------------- |
| VM → API        | Service Account |
| Cloud Run → API | Service Account |
| Functions → API | Service Account |

---

## 6.2 ACE判断

```
Compute → Service Account
```

---

# 7. Service Account認証

GCP内部アクセスは **Metadata Server** を利用する。

```
Compute
   |
Service Account
   |
Metadata Server
   |
Access Token
   |
GCP API
```

メリット

* Key不要
* 自動トークン更新
* 高セキュリティ

---

# 8. 外部Identityアクセス（2026）

2026年の推奨方式

```
Workload Identity Federation
```

---

## 8.1 Workload Identity Federation

外部IDを **Service Accountに安全にマッピング**する仕組み。

```mermaid
graph TD
ExternalIdentity --> Federation
Federation --> ServiceAccount
ServiceAccount --> GCP_API
```

---

### 対応Identity

| 外部ID     | 例           |
| -------- | ----------- |
| AWS IAM  | cross-cloud |
| Azure AD | enterprise  |
| OIDC     | GitHub      |
| SAML     | Okta        |

---

### 典型例

```
GitHub Actions → GCP
```

```
GitHub OIDC
↓
Workload Identity Federation
↓
Service Account
↓
GCP API
```

---

### メリット

| 問題         | 解決    |
| ---------- | ----- |
| JSON key漏洩 | Key不要 |
| Secret管理   | 不要    |
| ローテーション    | 不要    |

---

### ACE判断

```
External identity → Workload Identity Federation
```

---

# 9. Service Account Impersonation

Service Accountを **一時利用する仕組み**。

```mermaid
graph TD
User --> Impersonation
Impersonation --> ServiceAccount
ServiceAccount --> API
```

---

## 利用ケース

| 問題         | 解決            |
| ---------- | ------------- |
| JSON key回避 | Impersonation |
| 一時権限       | Impersonation |

---

## ACE判断

```
key回避 → SA Impersonation
```

---

# 10. Workload Identity（GKE）

GKE Pod → GCP API認証。

```mermaid
graph TD
Pod --> WorkloadIdentity
WorkloadIdentity --> ServiceAccount
ServiceAccount --> API
```

---

## 構造

```
GKE ServiceAccount
↓
Workload Identity
↓
IAM Service Account
↓
GCP API
```

---

## メリット

| 問題       | 解決 |
| -------- | -- |
| JSON key | 不要 |
| Pod認証    | 安全 |
| Token    | 自動 |

---

## ACE判断

```
Pod → API
→ Workload Identity
```

---

# 11. IAM Conditions

条件付きIAM。

```mermaid
graph TD
Identity --> Binding
Binding --> Condition
Condition --> Resource
```

---

## 条件例

| 条件       | 例      |
| -------- | ------ |
| 時間       | 勤務時間   |
| IP       | 社内IP   |
| Resource | bucket |

---

## ACE判断

```
条件付きアクセス → IAM Conditions
```

---

# 12. Organization Policy

組織レベルの制御。

---

## 代表例

| 制限       | 例                                    |
| -------- | ------------------------------------ |
| 外部IP禁止   | compute.vmExternalIpAccess           |
| SA key禁止 | iam.disableServiceAccountKeyCreation |
| region制限 | resourceLocations                    |

---

## ACE判断

```
組織制御 → Org Policy
```

---

# 13. Cross Project Access

別Projectのリソースにアクセス。

---

## 構造

```
Project A (Service Account)
       |
       v
Project B (Resource)
```

---

## 重要ポイント

```
Resource側IAMで許可
```

---

# 14. Default Service Account

GCPが自動作成。

例

```
PROJECT_NUMBER-compute@developer.gserviceaccount.com
```

---

## 問題

```
Editor roleが付与される
```

---

## 推奨

```
専用Service Account
```

---

# 15. 専用Service Account

VMごとにSA分離。

```
VM A → SA_A → Storage
VM B → SA_B → BigQuery
```

---

## 理由

| 問題     | 解決   |
| ------ | ---- |
| 権限拡散   | 専用SA |
| セキュリティ | 最小権限 |

---

# 16. Project Isolation

GCPの最強境界。

---

## 用途

| 要件        | 解決      |
| --------- | ------- |
| IAM分離     | Folder  |
| チーム分離     | Project |
| Billing分離 | Project |

---

## ACE判断

```
完全分離 → 新Project
```

---

# 17. Project Lien

Project削除防止。

| 機能                | 内容   |
| ----------------- | ---- |
| accidental delete | 削除防止 |

注意

```
IAM制御ではない
```

---

# 18. IAM設計ルール

| 原則        | 内容              |
| --------- | --------------- |
| 最小権限      | least privilege |
| Group管理   | 人直接付与しない        |
| SA分離      | アプリ単位           |
| Project分離 | 強い境界            |

---

# 19. IAM判断ツリー

```mermaid
flowchart TD
Q[IAM問題] --> A{主体}

A -->|人| Group
A -->|VM/App| ServiceAccount
A -->|GKE Pod| WorkloadIdentity
A -->|External| WorkloadIdentityFederation
```

---

# 20. ACE頻出パターン

| 問題         | 答え                           |
| ---------- | ---------------------------- |
| 人管理        | Group                        |
| VM → API   | Service Account              |
| Pod → API  | Workload Identity            |
| 外部Identity | Workload Identity Federation |
| Key回避      | SA Impersonation             |
| 組織制御       | Org Policy                   |
| 条件付き       | IAM Conditions               |
| VM限定アクセス   | 専用SA                         |
| Project分離  | 新Project                     |

---

# 21. IAM超短縮

```
人 → Group
VM → Service Account
Pod → Workload Identity

外部 → Workload Identity Federation

鍵回避 → Impersonation
組織制御 → Org Policy
条件付き → IAM Conditions

完全分離 → Project
```

---

# 22. 2026 IAMトレンド

| 技術                           | 状況   |
| ---------------------------- | ---- |
| Workload Identity            | 標準   |
| Workload Identity Federation | 急増   |
| SA Impersonation             | 推奨   |
| JSON Key                     | 最小化  |
| Org Policy                   | 企業必須 |
| IAM Conditions               | 普及   |

---

# 23. IAM最終構造

```mermaid
graph TD
Identity --> Binding
Binding --> Role
Role --> Resource

Identity --> User
Identity --> Group
Identity --> ServiceAccount
```

---

# 24. 用語集

| 用語                           | 定義                             | 説明                             |
| ---------------------------- | ------------------------------ | ------------------------------ |
| IAM                          | Identity and Access Management | GCPの権限管理システム                   |
| Identity                     | 主体                             | User / Group / Service Account |
| Role                         | 権限セット                          | Resourceへの操作権限                 |
| Binding                      | IAM紐付け                         | Identity + Role                |
| Service Account              | アプリ用ID                         | Compute / Run / Functions      |
| Workload Identity            | GKE認証                          | Pod→IAM                        |
| Workload Identity Federation | 外部ID連携                         | AWS / GitHub / OIDC            |
| Impersonation                | SA代理実行                         | Key不要認証                        |
| IAM Conditions               | 条件付きIAM                        | 時間 / IP                        |
| Org Policy                   | 組織制御                           | 制限ポリシー                         |
| Project                      | リソース境界                         | IAM / Billing                  |

---

