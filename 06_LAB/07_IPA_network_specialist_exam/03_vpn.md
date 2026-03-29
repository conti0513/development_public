# VPN / IKE モードまとめ（ネスペ用）

目的  
VPN / IPsec / IKE の「モード」を整理する

---

# VPN全体構造

```

VPN
└ IPsec
└ IKE

```
```

IKE
↓
鍵交換

IPsec
↓
暗号通信

```

---

# IKEのモード

IKE Phase1には2種類ある

```

Main Mode
Aggressive Mode

```

---

# Main Mode

標準モード

```

Client               Gateway

1  ---- SA proposal ---->
2  <---- SA response ----
3  ---- Key exchange --->
4  <--- Key exchange ----
5  ---- Authentication -->
6  <--- Authentication --

```

特徴

```

6メッセージ
安全
IDが暗号化される

```

用途

```

通常はこちら

```

---

# Aggressive Mode

高速モード

```

Client            Gateway

1  --- proposal + key + ID --->
2  <--- response + key + ID ---
3  -------- authentication ---->

```

特徴

```

3メッセージ
高速
IDが平文

```

問題

```

セキュリティ弱い

```

試験ポイント

```

Main Modeより高速

```

---

# IKE Phaseまとめ

```

Phase1
IKE SA作成

Phase2
IPsec SA作成

```

図

```

Phase1
IKEトンネル

Client ===== secure channel ===== Gateway

Phase2
IPsec設定

Client ===== IPsec tunnel ===== Gateway

```

---

# IPsecモード

IPsecにもモードがある

```

Transport Mode
Tunnel Mode

```

---

# Transport Mode

IPヘッダはそのまま

```

Original

[IP][TCP][DATA]

↓

IPsec

[IP][ESP][TCP][DATA]

```

特徴

```

ホスト間通信

```

用途

```

端末同士

```

---

# Tunnel Mode

IPパケット全体を暗号化

```

Original

[IP][DATA]

↓

Tunnel

[NEW IP][ESP][IP][DATA]

```

図

```

Site A                       Site B

LAN ----- GW ===== VPN ===== GW ----- LAN

```

用途

```

Site-to-Site VPN

```

試験ポイント

```

拠点VPN

```

---

# IKEv1 / IKEv2

試験で出る

---

# IKEv1

古い方式

```

Main Mode
Aggressive Mode

```

がある

---

# IKEv2

新しい方式

特徴

```

通信回数が少ない
NATに強い
モバイル向き

```

図

```

Client --- IKEv2 handshake --- Gateway

```

---

# VPNモードまとめ

```

IKE

Main Mode
Aggressive Mode

IPsec

Transport Mode
Tunnel Mode

```

---

# 試験の最重要整理

```

IKE
鍵交換

IPsec
データ通信

```
```

Main Mode
安全

Aggressive Mode
高速

```
```

Transport
ホスト間

Tunnel
拠点間

```

---

# ネスペ最短理解

```

VPN
↓
IPsec
↓
IKE
↓
Main / Aggressive
↓
Tunnel / Transport

```

---

# 超重要まとめ

```

Main Mode
安全
6メッセージ

Aggressive Mode
高速
3メッセージ

Transport Mode
IPそのまま

Tunnel Mode
IPごと暗号化

```

---
いいところを突いています。
ネスペのVPNは **NAT / NAT-T / L2TP/IPsec**がかなり出ます。
AA図＋Markdownで整理します。
そのまま **MDファイル**として使えます。

---

```markdown
# NAT-T / L2TP/IPsec まとめ（ネスペ用）

VPNで頻出

- NAT-T
- L2TP/IPsec

目的  
NAT環境でもVPNを成立させる

---

# 1 NAT問題

IPsecはNATと相性が悪い。

理由

```

AH
ESP

```

ESPは

```

IPヘッダも含めて認証

```

される。

NATが起きると

```

IP変更
↓
整合性エラー

```

になる。

---

# NAT環境

```

Client            NAT Router           VPN Gateway

10.0.0.10
|
| private
|
|------ NAT -------> 203.0.113.5
|
|
Internet
|
|
VPN GW

```
```

IPが変わる
↓
IPsec破綻

```

---

# 2 NAT-T

NAT Traversal

NAT越えのための技術。

仕組み

```

IPsecパケット
↓
UDPでカプセル化

```

図

```

Original ESP

[IP][ESP][DATA]

↓

NAT-T

[IP][UDP][ESP][DATA]

```

UDPポート

```

4500

```

---

# NAT-T通信

```

Client              Internet              VPN Gateway

[UDP 4500]
ESP inside

```
```

Client ==== UDP4500 ==== Gateway

```

つまり

```

IPsec over UDP

```

---

# NAT-T検出

IKE Phase1で

```

NAT検出

```

する。

```

双方がNAT検出
↓
NAT-T使用

```

---

# まとめ

```

NAT環境
↓
ESP壊れる
↓
UDP4500で包む
↓
NAT-T

```

---

# 3 L2TP/IPsec

L2TP

Layer2 Tunneling Protocol

PPPをトンネルする。

特徴

```

暗号化なし

```

だから

```

IPsecと組み合わせる

```

---

# L2TP/IPsec構造

```

IPsec
↓
L2TP
↓
PPP

```

図

```

[IPsec]
|
[L2TP]
|
[PPP]
|
[DATA]

```

---

# 通信イメージ

```

Client              VPN Gateway

PPP
↓
L2TP tunnel
↓
IPsec encryption

```
```

Laptop === L2TP/IPsec === VPN GW

```

---

# ポート

試験重要

```

UDP 500
IKE

UDP 1701
L2TP

UDP 4500
NAT-T

```

---

# パケット構造

```

[IP]
[ESP]
[UDP]
[L2TP]
[PPP]
DATA

```

---

# L2TP/IPsec用途

リモートアクセスVPN

```

Laptop → 会社ネットワーク

```

---

# VPN方式比較

```

IPsec
拠点VPN

L2TP/IPsec
リモートアクセス

```

---

# 試験ポイント

```

NAT越え
↓
NAT-T

```
```

L2TP
↓
暗号なし
↓
IPsecと組む

```

---

# ネスペ最短理解

```

VPN
↓
IPsec
↓
IKE
↓
NAT問題
↓
NAT-T
↓
L2TP/IPsec

```

---

# 超重要暗記

```

UDP500
IKE

UDP4500
NAT-T

UDP1701
L2TP

```

---

```

---
では、**ネスペVPNを1枚で理解する図**を作ります。
これを頭に入れると VPN問題はかなり解きやすくなります。

そのまま **MDファイル用**です。

---

```markdown
# ネスペVPN構造まとめ（1枚理解）

VPNの全体構造

```

VPN
├ Site-to-Site VPN
└ Remote Access VPN

```

---

# 1 Site-to-Site VPN（拠点VPN）

企業拠点接続

```

LAN-A                  Internet                 LAN-B
192.168.1.0                                     192.168.2.0

+-------+                                       +-------+
|Router |======= IPsec Tunnel ===================|Router |
+-------+                                       +-------+

```

特徴

```

Gateway同士
IPsec Tunnel Mode

```

---

# 2 Remote Access VPN

テレワーク接続

```

Laptop -------- VPN -------- Corporate Network

+--------+                     +-------------+
| Laptop |===== L2TP/IPsec ===| VPN Gateway |
+--------+                     +-------------+

```

特徴

```

ユーザ接続
L2TP/IPsec

```

---

# 3 IPsec構造

VPNのコア

```

IKE
↓
IPsec

```
```

IKE
鍵交換

IPsec
データ通信

```

---

# 4 IKEフェーズ

```

Phase1
IKE SA

Phase2
IPsec SA

```

図

```

Client                   Gateway

|---- Phase1 ----------|
|  IKE SA              |

|---- Phase2 ----------|
|  IPsec SA            |

|==== encrypted =======|

```

---

# 5 IKEモード

```

Main Mode
Aggressive Mode

```

Main Mode

```

6メッセージ
安全

```

Aggressive Mode

```

3メッセージ
高速
IDが平文

```

---

# 6 IPsecモード

```

Transport Mode
Tunnel Mode

```

Transport

```

[IP][ESP][DATA]

```

Tunnel

```

[IP][ESP][IP][DATA]

```

用途

```

Transport
ホスト間

Tunnel
拠点VPN

```

---

# 7 NAT問題

IPsecはNATと相性悪い

```

Client ----- NAT Router ----- Internet ----- VPN GW

10.0.0.10        ↓
IP変換
203.0.113.5

```

問題

```

ESP認証失敗

```

---

# 8 NAT-T

解決方法

```

ESP
↓
UDPカプセル化

```
```

[IP][UDP][ESP][DATA]

```

ポート

```

UDP 4500

```

---

# 9 L2TP/IPsec

リモートVPN

```

PPP
↓
L2TP
↓
IPsec

```

パケット

```

[IPsec]
[UDP]
[L2TP]
[PPP]
DATA

```

ポート

```

UDP 500   IKE
UDP 1701  L2TP
UDP 4500  NAT-T

```

---

# 10 GRE + IPsec

ネスペで出る構成

```

GRE tunnel
↓
IPsec encryption

```
```

RouterA ===== GRE ===== RouterB
===== IPsec =====

```

用途

```

ルーティングプロトコル
マルチキャスト

```

---

# 11 VPN方式まとめ

```

IPsec
拠点VPN

L2TP/IPsec
リモートVPN

GRE + IPsec
ルーティング

```

---

# ネスペ最短理解

```

VPN
↓
IPsec
↓
IKE
↓
Phase1 / Phase2
↓
NAT問題
↓
NAT-T
↓
L2TP/IPsec

```

---

# 超重要暗記

```

UDP 500
IKE

UDP 4500
NAT-T

UDP 1701
L2TP

ESP
IPsec暗号

```

---
```

---

最後に一つだけ言います。
**ネスペVPNは実は3つだけ理解すれば解けます。**

```
IKE
NAT-T
Tunnel Mode
```

この3つ。

---
了解。
ネスペで点差がつく **BGP / OSPF / MPLS を1枚理解**でまとめます。
そのまま **Markdownファイル**で使える形です。

---

```markdown
# ネスペ NW核心プロトコルまとめ（BGP / OSPF / MPLS）

目的  
ネスペで出題率が高い3つを「構造」で理解する

---

# 全体位置

```

Internet Routing
|
+--- BGP
|
Enterprise Routing
|
+--- OSPF

Carrier Network
|
+--- MPLS

```

---

# 1 BGP（Border Gateway Protocol）

インターネットの経路制御

```

AS65001 ----------- AS65002 ----------- AS65003

RouterA           RouterB            RouterC
|                 |                 |
+---- BGP --------+---- BGP --------+

```

特徴

```

AS間ルーティング
パスベクタ
ポリシールーティング

```

重要概念

```

AS Path
Next Hop
Local Preference
MED

```

---

# BGP経路選択

試験で重要

```

1 Local Preference
2 AS Path
3 Origin
4 MED
5 eBGP > iBGP

```

---

# eBGP / iBGP

```

eBGP

AS65001 ----- AS65002

iBGP

AS65001
|      |
RouterA RouterB

```

ポイント

```

iBGPはフルメッシュ

```

---

# BGP特徴

```

スケーラブル
ポリシー制御
インターネット

```

---

# 2 OSPF

企業ネットワーク

```

```
    Area0 (Backbone)

     Router1
    /       \
 Router2   Router3
   |           |
 Area1       Area2
```

```

特徴

```

リンクステート
高速収束

```

---

# OSPFの仕組み

```

Hello
↓
Neighbor確立
↓
LSA交換
↓
SPF計算

```

---

# OSPFルータ種類

```

Internal Router
Area Border Router (ABR)
Autonomous System Boundary Router (ASBR)

```

図

```

Area1          Area0          Area2

R1 ---- ABR ---- Backbone ---- ABR ---- R2

```

---

# OSPFメトリック

```

Cost

```

計算

```

Cost = 100Mbps / 帯域

```

---

# 3 MPLS

キャリアネットワーク

```

Customer ---- PE ---- P ---- P ---- PE ---- Customer

```

PE

```

Provider Edge

```

P

```

Provider Router

```

---

# MPLS仕組み

IPではなく

```

Label

```

で転送

```

[Label][IP Packet]

```

---

# MPLS転送

```

Ingress Router
|
Label Push

Core Router
|
Label Swap

Egress Router
|
Label Pop

```

図

```

RouterA ---- RouterB ---- RouterC

Push        Swap         Pop

```

---

# MPLS用途

```

VPN
トラフィック制御
キャリアネットワーク

```

---

# MPLS VPN

```

CustomerA ---- PE ---- MPLS ---- PE ---- CustomerA

CustomerB ---- PE ---- MPLS ---- PE ---- CustomerB

```

VRFで分離

```

VRF = 仮想ルーティング

```

---

# ネスペ理解まとめ

```

Internet routing
↓
BGP

Enterprise routing
↓
OSPF

Carrier routing
↓
MPLS

```

---

# 試験最短理解

```

BGP
AS間

OSPF
企業内部

MPLS
キャリア網

```

---

# 超重要覚え方

```

BGP
= Internet

OSPF
= Enterprise

MPLS
= Carrier

```

---
