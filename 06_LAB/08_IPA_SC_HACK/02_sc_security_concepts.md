# SC Security Concepts (30)

SC試験および実務で重要なセキュリティ概念を整理。

---

# 1. セキュリティ概念の全体構造

SCはだいたいこの3層で理解すると楽。

```
           ┌──────────────────────┐
           │  セキュリティ原則    │
           │ CIA / ゼロトラスト   │
           │ 多層防御             │
           └──────────┬───────────┘
                      │
           ┌──────────▼───────────┐
           │  技術メカニズム      │
           │ PKI / TLS / VPN      │
           │ IDS / WAF / EDR      │
           └──────────┬───────────┘
                      │
           ┌──────────▼───────────┐
           │  運用管理            │
           │ SOC / CSIRT          │
           │ ログ / 監査          │
           └──────────────────────┘
```

---

# 2. SC重要概念一覧（30）

| No | 概念         | 英語                                       | 概要            |
| -- | ---------- | ---------------------------------------- | ------------- |
| 01 | CIAトライアド   | Confidentiality Integrity Availability   | 情報セキュリティの基本原則 |
| 02 | リスクマネジメント  | Risk Management                          | リスクの識別・評価・対応  |
| 03 | 多層防御       | Defense in Depth                         | 複数の防御層で攻撃を防ぐ  |
| 04 | ゼロトラスト     | Zero Trust                               | 内外問わず信頼しないモデル |
| 05 | 最小権限       | Least Privilege                          | 必要最小限の権限のみ付与  |
| 06 | 認証         | Authentication                           | 本人確認          |
| 07 | 認可         | Authorization                            | 権限の付与         |
| 08 | アカウンタビリティ  | Accountability                           | 操作の追跡可能性      |
| 09 | PKI        | Public Key Infrastructure                | 公開鍵基盤         |
| 10 | 電子証明書      | Digital Certificate                      | 公開鍵の証明        |
| 11 | TLS        | Transport Layer Security                 | 通信暗号化         |
| 12 | ハッシュ       | Hash Function                            | データ要約         |
| 13 | デジタル署名     | Digital Signature                        | 改ざん検知         |
| 14 | VPN        | Virtual Private Network                  | 安全な通信トンネル     |
| 15 | IDS        | Intrusion Detection System               | 侵入検知          |
| 16 | IPS        | Intrusion Prevention System              | 侵入防御          |
| 17 | WAF        | Web Application Firewall                 | Web攻撃防御       |
| 18 | EDR        | Endpoint Detection Response              | 端末監視          |
| 19 | SIEM       | Security Information Event Management    | ログ統合分析        |
| 20 | SOC        | Security Operation Center                | セキュリティ監視組織    |
| 21 | CSIRT      | Computer Security Incident Response Team | インシデント対応      |
| 22 | インシデント対応   | Incident Response                        | セキュリティ事故対応    |
| 23 | 脆弱性管理      | Vulnerability Management                 | 脆弱性の管理        |
| 24 | パッチ管理      | Patch Management                         | 更新管理          |
| 25 | セキュリティポリシー | Security Policy                          | セキュリティ方針      |
| 26 | ログ管理       | Log Management                           | 操作記録管理        |
| 27 | フォレンジック    | Digital Forensics                        | 証拠解析          |
| 28 | サプライチェーン攻撃 | Supply Chain Attack                      | 供給網攻撃         |
| 29 | 標的型攻撃      | Targeted Attack                          | 特定組織を狙う攻撃     |
| 30 | セキュリティ監査   | Security Audit                           | セキュリティ評価      |

---

# 3. SC試験の典型パターン

SCはこの構造で出題されることが多い。

```
攻撃
 ↓
防御技術
 ↓
運用対応
```

例

```
標的型攻撃
 ↓
EDR / IDS / WAF
 ↓
SOC / CSIRT
```

---

# 4. 実務との対応

| 分野     | 概念          |
| ------ | ----------- |
| ネットワーク | VPN IDS IPS |
| 認証     | PKI TLS IAM |
| 端末     | EDR         |
| Web    | WAF         |
| 監視     | SIEM SOC    |
| 運用     | CSIRT       |

---

# 5. SC理解のコア

SCは結局この3つ。

```
CIA
↓
防御技術
↓
運用プロセス
```

---

