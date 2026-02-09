# README.md (mail-auth)

## 📁 概要

本ディレクトリは、BIMI（Brand Indicators for Message Identification）導入に伴う、メール認証基盤（SPF/DKIM/DMARC）の健全性検証およびデプロイ計画を管理する。

特に、既存のロストテクノロジー化したメール基盤において、**RFC 7208（SPF 10-Lookup制限）**を突破し、受信側サーバーで `PermError` が発生することを防ぐための「防御的エンジニアリング」を実践する。

---

## 🚀 主要資産

* **[QA・デプロイ計画書](https://github.com/conti0513/development_public/blob/main/devops_notes/mail-auth/01_mail_auth_master.md)**: BIMI導入に向けた全工程のロードマップ。
* **[verify-spf-rfc7208.sh](https://github.com/conti0513/development_public/blob/main/devops_notes/mail-auth/verify-spf-rfc7208.sh)**: 受信側サーバー（M365/Gmail等）の挙動をシミュレートする完全再帰型SPFバリデーター。

---

## ⚖️ SPF判定の「審判」と「通信」の解像度

SPFの成否を決めるのは送信側ではなく、**受信側のメールサーバー（M365, Gmail等）**である。

### DNS参照フローの可視化

```text
[ 送信側：あなたのインフラ ]                    [ 受信側：相手(M365)のインフラ ]
(Google Cloud DNS で管理)                      (Exchange Online 審判)
+------------------------+                    +----------------------------+
|  Cloud DNS (起点)      |                    |  M365 受信ゲートウェイ       |
|  (example.com)         |                    |  (SPF認証モジュール)         |
+-----------+------------+                    +------------+---------------+
            ^                                              |
            |           (1) DNS Lookup #1                  |
            +<---------------------------------------------+
            |  example.com の SPF を取得                   | [累計: 1]
            |  "v=spf1 include:_spf.google.com ..."        |
            |                                              |
+-----------+------------+                    +------------+---------------+
|  Google Workspace DNS  |                    |  M365 受信ゲートウェイ       |
|  (_spf.google.com)     |                    |                            |
+-----------+------------+                    +------------+---------------+
            ^                                              |
            |           (2) DNS Lookup #2                  |
            +<---------------------------------------------+
            |  include 先をさらに再帰                      | [累計: 2]
            |                                              |

```

---

## 🧪 単体試験エビデンス (Unit Test)

自作のバリデーターを用いて、複雑化したSPFレコードが「受信サーバー視点」で何回のルックアップを消費するかを検証した。

### 実行例（境界値テスト）

あえて主要なSaaS（Google, Yahoo, Salesforce, Outlook）を並べた「盛り盛りSPF」を検証した結果、見た目上の項目数（6項目）に反し、内部再帰によって **17回** のルックアップが発生することを検知した。

```bash
$ ./verify-spf-rfc7208.sh
> v=spf1 include:_spf.google.com include:spf.mail.yahoo.co.jp include:_spf.salesforce.com include:spf.protection.outlook.com mx a ~all

解析中...
--------------------------------------------------
結果: 合計 17 DNSルックアップ
[FAIL] RFC 7208 Compliance: NG (10超え！)
解説: 受信サーバーで PermError となり、メールが不達になるリスクが高いです。
--------------------------------------------------

```

### 設計者としての指摘

この検証により、**単なる include の追記は「不達」に直結する**ことが証明された。
BIMI導入にあたっては、以下の対策を講じる必要がある。

1. **サブドメイン化**: メルマガ専用ドメインへの分離。
2. **フラットニング**: 再帰先をIPアドレス（ip4/ip6）に展開し、ルックアップ数を物理的に削減。

---

## 🛠️ 使い方

バリデーターを起動し、DNS反映前のSPF文字列を入力して検証を行う。

```bash
chmod +x verify-spf-rfc7208.sh
./verify-spf-rfc7208.sh

```

---

## 📋 免責事項

本ディレクトリのドキュメントおよびスクリプトは、RFC 7208に準拠した検証を目的としており、最終的な到達性は受信側プロバイダーの独自ポリシーに依存する。

---

