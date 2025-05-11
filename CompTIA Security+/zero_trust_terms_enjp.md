# 📘 Zero Trust & Security Architecture Glossary (EN/JP)

> This glossary serves as a bilingual knowledge base for Zero Trust and security architecture practices.
> Designed for continuous learning, team communication, and architecture alignment in remote-first environments.
> （ゼロトラストとセキュリティ設計の理解を深める、実務・学習・商談用の用語集です）

---

## 📌 Purpose / 目的

- Support consistent understanding of core security concepts in both English and Japanese
- Enable quick lookup and use in documentation, incident response, or architecture review
- Promote a reusable, structure-oriented vocabulary aligned with Zero Trust thinking
- **Quietなセキュリティ設計者**としてのナレッジ資産構築

---

## 🔐 Glossary (30 Terms, EN ⇔ JP)

| No. | Term (EN)                    | 用語（日本語）           | Summary / 概要説明 (JP)                 |
| --- | ---------------------------- | ----------------- | ----------------------------------- |
| 01  | Zero Trust Architecture      | ゼロトラスト・アーキテクチャ    | 信頼せず、常に検証する前提でシステムを設計するアプローチ        |
| 02  | Least Privilege              | 最小権限の原則           | 必要最小限の権限のみを付与し、誤用・誤操作リスクを抑制         |
| 03  | Microsegmentation            | マイクロセグメンテーション     | ネットワークや権限を細かく分離し、侵害時の影響を最小化         |
| 04  | Identity Provider (IdP)      | 認証基盤（IdP）         | ユーザーの認証を一元化するサービス（SSO, Federation等） |
| 05  | Policy Enforcement Point     | ポリシー適用ポイント        | セキュリティポリシーを技術的に実行するポイント（EDRなど）      |
| 06  | Secure Access Service Edge   | SASE（セキュアアクセスエッジ） | ネットワーク境界をクラウドで提供する新しいセキュリティ構成       |
| 07  | Device Posture               | デバイスの状態           | OS, アンチウイルス, 暗号化など端末のセキュリティ状態       |
| 08  | Network Access Control (NAC) | ネットワークアクセス制御      | 許可された端末のみネットワーク接続を可能にする技術           |
| 09  | Continuous Authentication    | 継続認証              | 一度ログインしてもユーザーの動きを継続的に検証する手法         |
| 10  | Risk-Based Access Control    | リスクベースアクセス制御      | リスクレベルに応じてアクセス許可・拒否を動的に判断する         |
| 11  | Security Posture             | セキュリティ体制          | 組織やシステムが現在持つ防御力の全体像                 |
| 12  | SIEM                         | セキュリティ情報イベント管理    | ログ収集と分析により脅威検知を行うプラットフォーム           |
| 13  | EDR                          | エンドポイント検知と応答      | 端末上の挙動を継続監視し、脅威を検知・対応する仕組み          |
| 14  | Multi-Factor Authentication  | 多要素認証             | パスワード＋別の要素（SMS, 認証アプリなど）で本人確認       |
| 15  | Data Classification          | データ分類             | 機密性やリスクに応じてデータを区分する                 |
| 16  | DLP                          | データ損失防止           | 機密情報の漏洩を防ぐ仕組み（コピー制限、送信検知など）         |
| 17  | PAM                          | 特権アクセス管理          | 管理者権限など特権アクセスを安全に制御する仕組み            |
| 18  | Secure Boot                  | セキュアブート           | OS起動時に正規のソフトウェアのみ起動させる仕組み           |
| 19  | Secure Baseline              | セキュアベースライン        | 安全な構成の初期テンプレートを定義すること               |
| 20  | Defense in Depth             | 多層防御              | 複数の防御手段を重ねることで侵入を困難にする              |
| 21  | Identity Federation          | IDフェデレーション        | 複数ドメイン間での認証連携（SSOなど）                |
| 22  | CASB                         | クラウドアクセス制御ブローカー   | クラウドサービス利用を安全に監視・制御する仕組み            |
| 23  | RBAC                         | ロールベースアクセス制御      | 役割ごとにアクセス権を定義し、最小権限化を促進             |
| 24  | ABAC                         | 属性ベースアクセス制御       | ユーザー属性や状況に応じたアクセス制御を行う              |
| 25  | Log Retention Policy         | ログ保持ポリシー          | どのログをどれだけ保持するかの基準                   |
| 26  | Audit Trail                  | 監査証跡              | アクティビティを記録・追跡し、後から検証できる状態           |
| 27  | Alert Fatigue                | アラート疲弊            | 不必要な通知が多く、重要な警告が見逃される状態             |
| 28  | Shadow IT                    | シャドーIT            | 情シス管理外で勝手に導入されたITツール                |
| 29  | Network Isolation            | ネットワーク分離          | システム間の通信を制限し、感染や侵害の拡大を防止            |
| 30  | Immutable Infrastructure     | 不変インフラ            | デプロイ後に変更せず、常に新しく構築する考え方             |

---


## 📘 Notes

- 用語は **実務と学習の両視点** から選定されています
- 各用語は `BOO’s Experience` カラムで後から追記しやすい構造
- 必要に応じて `glossary_enjp.md` や `zero_trust_terms_enjp.md` に統合可能

---

# 🛠️ BOO’s Experience

## 📌 PJTの時系列

| フェーズ       | 概要                                   |
| ---------- | ------------------------------------ |
| 💼 社員時代①   | M365プリセールス・アフターSEとして認証／導入支援・ドキュメント設計 |
| 💼 社員時代②   | 広告系事業会社で情シス主担当、構成設計・開発運用・SaaS統合を担当   |
| 🏥 フリーランス① | 医療系メガベンチャー：M365運用、DLP、認証再設計など        |
| 🏥 フリーランス② | 東証プライム上場メーカー：Entra ID / M365再構成支援    |
| 🏢 フリーランス③ | IPO準備中企業：GCP構成、Slack通知、監査対応設計支援      |

---

## 01. Zero Trust Architecture｜ゼロトラスト・アーキテクチャ

**実装と設計の両視点からゼロトラスト原則を反映した構成を複数経験。**
現場実装／運用負荷／可視性の3軸で「検証が前提」の構成思想を実践。

---

#### 💼 社員時代（広告系事業会社）

* Slack通知＋ログ連携により、**境界内外問わず"検知→通知→対応"を構造化**
* 再現可能な構成図／導入手順を整備し、属人性の排除を推進

---

#### 🏥 医療系メガベンチャー

* M365／SharePointを活用し、**DLP＋認証強化＋文化レベルでのゼロトラスト対応**を設計

---

#### 🏢 IPO準備中企業

* **Cloud Run + FTPS + 固定IP + GCP構成**にて、信頼しない外部通信を構築
* GAS制限や認証自動化など、**再現性と可視性を両立した構成へ移行**

---

#### 🔧 共通観点

* **構成図・IAM・通信経路・検知設計をコードレベルで管理**
* 属人性排除と非同期文化を意識し、**監査耐性のある構成管理**を実践

---

## 02. Least Privilege｜最小権限の原則

**IAM設計・アクセス制御を「簡潔かつ安全」に再設計した経験あり。**
「誰が／どこに／どの権限で」アクセスすべきかを明示し、運用可能なテンプレートへ落とし込み。

---

#### 💼 WEB系プロダクト企業（開発チームのIAM再構成）

* 従来：ジャンプサーバー共用で全アクセス可／手動鍵配布
* 新構成：**AWS Client VPN＋IAMロール分離＋自動化ドキュメント構成**

---

#### 実装内容

* 鍵生成・登録・アクセス範囲をマニュアル化
* IAM変更通知をSlack連携 → **即時検知＋監査記録を実現**
* 「運用に優しい最小権限設計」のテンプレート化を完了

---

> 「最小権限＝使いにくい」ではない。**設計と自動化があれば、両立できる。**

---

## 03. Microsegmentation｜マイクロセグメンテーション

**L2物理NWからL7クラウド構成まで、境界設計とトラフィック分離を実装経験。**

---

#### 🌏 台湾拠点NW設計

* 人流カメラと売上管理のネットワークをVLAN分離
* **QoS制御で業務系優先＋障害時の影響範囲を極小化**

---

#### ☁️ GCP構成（現行PJT）

* Cloud Run／Function間をIAM／通信経路で分離
* **アプリ単位のセグメント設計＋通知ログ整備**でマイクロ境界を実装

---

> 通信 × IAM × 可視性の3要素で、**静かに効くマイクロセグメントを実装中**

---

## 04. Identity Provider (IdP)｜認証基盤（IdP）

**SSO／MFA／認証設計における現場実装を複数経験。**
オンプレ・クラウド環境にまたがる\*\*“認可の起点”としてのIdP設計\*\*を推進。

---

#### 🏥 国策グループ系企業

* **Entra ID（旧Azure AD）による認証統合とMFA構成を支援**
* SaaSアカウント管理・ログ整備・役割分離もドキュメント化

---

#### 💼 広告系事業会社（WEBサービス・オンプレ環境）

* HENNGE＋Google WorkspaceでSSO構成
* SaaS（Backlog, Zoom 等）への統合と最小権限設計を構築

---

#### Redmine移行PJT（オンプレ→クラウド）

* Ruby / rbenv / MySQL / Apache環境を再構成
* **MFA対応＋再起動自動化スクリプトを含む可用性強化**

---

#### IPO準備中企業・医療系メガベンチャー

* 既存IdP設定の見直し、MFA／アカウント管理／手順整備を支援

---

#### 設計視点の共通要素

| 項目      | 内容                                   |
| ------- | ------------------------------------ |
| 可用性設計   | 再起動・障害対応を含む**スクリプト＋手順設計で冗長性を確保**     |
| 運用移管支援  | **鍵管理・アカウント登録を非エンジニア向けにマニュアル整備**     |
| システム整合性 | 認証とNW/IAMの整合を意識し、**構成図ベースでの統一構成を実現** |

---

> **IdPは「ログインの入口」ではなく、静かで再現可能な“認可の基盤”である。**

---




