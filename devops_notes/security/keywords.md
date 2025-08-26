# Security Cheat Sheet

## 目次
1. Identity & Access
2. SaaSセキュリティ
3. IDライフサイクル管理
4. Zero Trust / ネットワーク境界
5. 監視・運用基盤
6. データ保護
7. 端末セキュリティ
8. クラウドネイティブセキュリティ

---

## 1. Identity & Access

- **IAM**: *Identity and Access Management*（権限管理の基本）
- **RBAC**: *Role-Based Access Control*（役割ベースでのアクセス制御）
- **SSO**: *Single Sign-On*（複数サービスを1つの認証で利用）
- **MFA**: *Multi-Factor Authentication*（多要素認証）
- **JIT Access**: *Just-In-Time Access*（一時的な権限付与）
- **PAM**: *Privileged Access Management*（特権アカウント管理）

---

## 2. SaaSセキュリティ

- **Google Workspace / Microsoft 365 / HENNGE**
  - SSO・アクセス制御・条件付きアクセス
  - **HENNGE**: 国内SaaSセキュリティ基盤（SSO・アクセス制御に強み）

---

## 3. IDライフサイクル管理

- 入退社・異動に伴う **アカウント作成／削除／権限変更の自動化**
- **SCIM**: *System for Cross-domain Identity Management*（標準プロビジョニング仕様）

---

## 4. Zero Trust / ネットワーク境界

- **Zero Trust**: *Zero Trust Architecture*（信用せず都度検証）
- **VPC Service Controls**: *Virtual Private Cloud Service Controls*（GCPリソース境界でのデータ流出防止）

---

## 5. 監視・運用基盤

- **SIEM**: *Security Information and Event Management*（ログ収集・相関分析）
- **Cloud Logging**（GCP）, **Azure Sentinel**（Microsoft）
- **SOC**: *Security Operations Center*（セキュリティ監視組織）
- **CSIRT**: *Computer Security Incident Response Team*（インシデント対応チーム）
- **SOAR**: *Security Orchestration, Automation and Response*（対応自動化基盤）

---

## 6. データ保護

- **CASB**: *Cloud Access Security Broker*（クラウド利用の可視化・制御）
- **DLP**: *Data Loss Prevention*（機密データ漏洩防止）
- **KMS**: *Key Management Service*（暗号鍵管理）
- **BYOK**: *Bring Your Own Key*（顧客側で鍵を持ち込み暗号化）
- **Audit Logs**: *Audit Logging*（監査証跡の保持）

---

## 7. 端末セキュリティ

- **EDR**: *Endpoint Detection and Response*（端末の脅威検知・対応）
- **MDM**: *Mobile Device Management*（端末管理、ポリシー配布）
- **ESET / Intune / Malion**: 実務経験あり

---

## 8. クラウドネイティブセキュリティ

- **CSPM**: *Cloud Security Posture Management*（クラウド構成のベストプラクティス準拠チェック）
- **CNAPP**: *Cloud-Native Application Protection Platform*（クラウド〜コンテナ〜アプリ全体の保護）

---

# 詳細

## 1. Identity & Access

### IAM
- **IAM**: *Identity and Access Management*（権限管理の基本）
- **経験**: AWS / GCP / Microsoft 365 / Google Workspace / HENNGE にて管理者経験。入退社に伴うアカウント発行・削除、権限付与の運用改善。
- **実務適用例**: マルチクラウド・マルチSaaS環境のIAMを一元管理し、IPO準備に向けた監査ログや内部統制強化に関与。
- **規模感**: 100〜500名規模の従業員管理。Microsoft Entra ID では10万人超のグローバルユーザーを対象。
- **関連規格**: ISO/IEC 27001（アクセス制御）、CIS Control v8（IAM管理）
- **経験レベル**: 導入・運用・改善フェーズを担当。

---

### RBAC
- **RBAC**: *Role-Based Access Control*（役割ベースでのアクセス制御）
- **経験**: Google Workspace, Microsoft 365, HENNGE, AWSにてロール設計・権限割当を運用。
- **実務適用例**: 部門・職種ごとの権限スコープを整理し、属人的管理を排除。
- **規模感**: 主に100〜500名規模の組織に適用。
- **関連規格**: ISO/IEC 27001 A.9.2（ユーザーアクセス権の管理）
- **経験レベル**: 運用改善フェーズを中心に実務経験。

---

### SSO
- **SSO**: *Single Sign-On*（複数サービスを1つの認証で利用）
- **経験**: HENNGEを介したGoogle Workspace連携、Microsoft Entra IDを用いたSaaS連携の導入・運用を経験。
- **実務適用例**: SSO基盤を導入し、利便性とセキュリティを両立。複数プロジェクトにて定着化を支援。
- **規模感**: 100〜500名規模の組織での導入。Entra IDでは10万人以上のグローバルユーザーを対象。
- **関連規格**: NIST 800-63（デジタルアイデンティティ指針）
- **経験レベル**: 導入〜運用定着まで対応。

---

### MFA
- **MFA**: *Multi-Factor Authentication*（多要素認証）
- **経験**: 各種SaaSでMFA導入・運用を実施。RedMine環境ではMFA機能を開発・実装。
- **実務適用例**: フィッシング対策としてMFAを標準化し、海外拠点を含むユーザーに展開。
- **規模感**: 100〜500名規模の社内導入、Entra IDでは10万人規模＋グローバルユーザー対応を経験。
- **関連規格**: NIST 800-63B（MFA推奨）
- **経験レベル**: 運用フェーズ＋一部開発寄りの実装経験。

---

### JIT Access
- **JIT Access**: *Just-In-Time Access*（一時的な権限付与）
- **経験**: MalionにてUSB・カメラ権限の一時付与・回収を実装。
- **実務適用例**: 小売現場における柔軟な権限付与を仕組化し、業務効率とセキュリティを両立。
- **規模感**: 100〜500名規模の組織に適用。
- **関連規格**: NIST Zero Trust Architecture（動的アクセス制御）
- **経験レベル**: 運用改善の実務経験。

---

### PAM
- **PAM**: *Privileged Access Management*（特権アカウント管理）
- **経験**: GWS, M365, AWSでRoot発行・管理アカウント利用・監査ログ対応を実施。
- **実務適用例**: 特権アカウント利用を制御し、監査証跡を保持。監査法人対応や内部統制監査に貢献。
- **規模感**: 100〜500名規模の組織管理。
- **関連規格**: ISO/IEC 27001 A.9.4（システム・アプリケーションアクセス制御）
- **経験レベル**: 運用＋監査対応フェーズでの経験。
---

## 2. SaaSセキュリティ

- **Google Workspace / Microsoft 365 / HENNGE**

### SaaSセキュリティ（Google Workspace / Microsoft 365 / HENNGE）

- **概要**: SaaSに対する認証基盤・アクセス制御の運用管理  
- **経験**: Google Workspace / Microsoft 365 / HENNGE にて、SSO連携、条件付きアクセス、端末制御を設計・運用。HENNGE導入経験あり。  
- **実務適用例**: HENNGEを利用したSSOでGoogle Workspaceと複数SaaSを統合。M365では条件付きアクセスで社外アクセスを制御し、業務効率とセキュリティを両立。  
- **規模感**: 主に100〜500名規模の組織。Entra ID 経由で10万人規模のユーザー管理も経験。  
- **関連規格**: ISO/IEC 27001 A.9.2（ユーザーアクセス権の管理）、NIST SP 800-63（デジタルアイデンティティ指針）  
- **経験レベル**: 導入フェーズから運用改善まで一通り経験。  
- **エピソード**: 2019年、リモートワーク黎明期にHENNGE導入をサポート。M365と併せて導入し、SaaS管理の簡素化・セキュリティ強化・リモートフレンドリーな環境を整備。経営層にも「事業継続性の観点」で説明し、スムーズに全社展開を実現。



## 3. IDライフサイクル管理

- 入退社・異動に伴う **アカウント作成／削除／権限変更の自動化**
- **SCIM**: *System for Cross-domain Identity Management*（標準プロビジョニング仕様）

### IDライフサイクル管理
- **概要**: 入退社・異動に伴うアカウント作成／削除／権限変更を自動化  
- **経験**: HENNGEを利用したSCIMベースのアカウント発番、Azureワークフロー連携による自動化を経験。M365ではPowerShellによる発番処理を担当。  
- **実務適用例**: グループ会社全体でHENNGEによる発番スキームを構築。担当した1社ではM365と連携し、発番メールアドレスを自動で同期。入退社・異動に伴う人的工数を削減。  
- **規模感**: グループ全体数千名規模、担当範囲は500ユーザー程度。  
- **関連規格**: ISO/IEC 27001 A.9.2（ユーザーアクセス権の管理）、SCIM標準仕様  
- **経験レベル**: 自動化フェーズを中心に運用改善を担当。  
- **エピソード**: メディカルテック企業のグループ会社で導入時、Azureのワークフローで発番されたIDをM365へ自動連携する仕組みをPowerShellで整備。リモートワーク環境での人的負荷を大幅に軽減し、監査対応の効率化にも貢献。


## 4. Zero Trust / ネットワーク境界

### Zero Trust

- **Zero Trust**: *Zero Trust Architecture*（信用せず都度検証）  
- **経験**: 現行PJTにてVPN依存を排除した社内ネットワーク運用を経験。社内NWはVPNレスで運用しつつ、監査対応でFW導入をベンダーと検討。並行してNW刷新PJTのPMOも兼任。  
- **実務適用例**: 「常に検証するアクセス制御」の方針に基づき、VPNレス構成とFW検討を組み合わせ、ゼロトラストに近い状態を実現。  
- **規模感**: 数百ユーザー規模のリテール系PJ。  
- **関連規格**: NIST Zero Trust Architecture、CIS Control v8（ネットワークセグメンテーション）  
- **経験レベル**: 運用・改善フェーズに加え、監査対応やベンダー調整も含めたPMO経験。  
- **エピソード**: リモートフレンドリーな業務環境を前提にVPNレス運用を実施。監査法人からの要請を受けFW導入を検討し、NW刷新PJTのPMOとして設計・調整をリード。  

---

### VPC Service Controls

- **VPCSC**: *Virtual Private Cloud Service Controls*（GCPリソース境界でのデータ流出防止）  
- **経験**: AWS環境にてVPCサーバーを介した開発環境を構築。開発者が直接VPCサーバー経由で接続していたが、可用性・BCPに課題が発生。これを受けてAWSマネージドサービス（例: VPCエンドポイント／PrivateLink 等）を設計・導入。  
- **実務適用例**: ロールレベルの権限付与を徹底し、監査対応しやすい構成を実現。データ流出リスクを最小化。  
- **規模感**: 数十名の開発チーム、数百ユーザーが利用するAWS環境。  
- **関連規格**: ISO/IEC 27001 A.13（ネットワークセキュリティ）、CIS AWS Foundations Benchmark  
- **経験レベル**: 設計・実装・運用まで一通り経験。  
- **エピソード**: VPCサーバー依存により「サーバーダウン＝開発停止」というリスクが顕在化。これを解消するためAWSマネージドVPC機能を活用し、監査対応も考慮したセキュリティ境界を設計・実装。
