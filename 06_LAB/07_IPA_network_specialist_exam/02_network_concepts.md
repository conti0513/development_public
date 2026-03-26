# NW Network Concepts (30)

ネスペ試験および実務で重要なネットワーク概念を整理。

---

# 1. ネットワーク概念の全体構造

ネスペはだいたいこの3層で理解すると楽。

```
           ┌──────────────────────┐
           │  ネットワーク原則    │
           │ OSI / TCP-IP         │
           │ アドレッシング       │
           └──────────┬───────────┘
                      │
           ┌──────────▼───────────┐
           │  技術メカニズム      │
           │ ルーティング / VPN   │
           │ 冗長化 / QoS         │
           └──────────┬───────────┘
                      │
           ┌──────────▼───────────┐
           │  運用管理            │
           │ 監視 / トラブルシュート│
           │ セキュリティ設計     │
           └──────────────────────┘
```

---

# 2. ネスペ重要概念一覧（30）

| No | 概念 | 英語 | 概要 |
| -- | ---- | ---- | ---- |
| 01 | OSI参照モデル | OSI Reference Model | 7層のネットワーク標準モデル |
| 02 | TCP/IP | TCP/IP Protocol Suite | インターネットの基本プロトコル群 |
| 03 | IPアドレッシング | IP Addressing | IPv4/IPv6のアドレス設計 |
| 04 | サブネッティング | Subnetting | ネットワークの分割設計 |
| 05 | ルーティング | Routing | パケットの経路制御 |
| 06 | OSPF | Open Shortest Path First | リンクステート型ルーティングプロトコル |
| 07 | BGP | Border Gateway Protocol | AS間ルーティングプロトコル |
| 08 | VLAN | Virtual LAN | L2の論理ネットワーク分割 |
| 09 | スパニングツリー | Spanning Tree Protocol | L2ループ防止プロトコル |
| 10 | VRRP | Virtual Router Redundancy Protocol | デフォルトGWの冗長化 |
| 11 | スタック構成 | Switch Stacking | 複数スイッチの論理1台化 |
| 12 | リンクアグリゲーション | Link Aggregation | 複数回線の束ね・冗長化 |
| 13 | NAT / NAPT | Network Address Translation | アドレス変換 |
| 14 | DNS | Domain Name System | 名前解決 |
| 15 | DHCP | Dynamic Host Configuration Protocol | IPアドレス自動配布 |
| 16 | VPN | Virtual Private Network | 安全な通信トンネル |
| 17 | IPsec | IP Security | L3レベルの暗号化通信 |
| 18 | SSL-VPN | SSL VPN | L4-7レベルのリモートアクセスVPN |
| 19 | QoS | Quality of Service | 通信品質の優先制御 |
| 20 | ファイアウォール | Firewall | パケットフィルタリング・アクセス制御 |
| 21 | IDS / IPS | Intrusion Detection/Prevention | 侵入検知・防御 |
| 22 | プロキシ | Proxy Server | 中継・キャッシュ・フィルタリング |
| 23 | 負荷分散 | Load Balancing | トラフィックの分散処理 |
| 24 | WAN回線 | WAN Circuit | 広域ネットワーク接続方式 |
| 25 | MPLS | Multi-Protocol Label Switching | ラベルによる高速経路制御 |
| 26 | SDN | Software Defined Networking | ソフトウェアによるNW制御 |
| 27 | ネットワーク監視 | Network Monitoring | SNMP / syslog による状態監視 |
| 28 | トラブルシュート | Troubleshooting | ping / traceroute / パケットキャプチャ |
| 29 | ネットワーク設計 | Network Design | 可用性・拡張性・セキュリティの設計原則 |
| 30 | キャパシティ管理 | Capacity Management | 帯域・性能の計画的管理 |

---

# 3. ネスペ試験の典型パターン

ネスペはこの構造で出題されることが多い。

```
要件
 ↓
設計
 ↓
障害対応
```

例

```
拠点間通信の要件
 ↓
VPN / ルーティング設計
 ↓
冗長化 / フェイルオーバー
```

---

# 4. 実務との対応

| 分野 | 概念 |
| ---- | ---- |
| LAN設計 | VLAN STP リンクアグリゲーション |
| ルーティング | OSPF BGP スタティック |
| 冗長化 | VRRP スタック リンクアグリゲーション |
| WAN | MPLS IPsec VPN 専用線 |
| セキュリティ | FW IDS/IPS プロキシ |
| 運用 | SNMP syslog トラブルシュート |

---

# 5. ネスペ理解のコア

ネスペは結局この3つ。

```
アドレッシング（IPの設計）
↓
ルーティング（経路の制御）
↓
冗長化（障害への備え）
```

---