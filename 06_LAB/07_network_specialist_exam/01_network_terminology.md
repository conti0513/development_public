# Network Terminology

| 用語             | 英語の言い換え                           | 解説                            |
| -------------- | --------------------------------- | ----------------------------- |
| MACアドレス        | MAC address                       | NICに割り当てられるL2の識別子。48bit。      |
| ARP            | Address Resolution Protocol       | IPアドレスからMACアドレスを解決するプロトコル。    |
| Gratuitous ARP | Gratuitous ARP                    | 自身のIPとMACを通知するARP。冗長構成で使用される。 |
| ブロードキャスト       | Broadcast                         | 同一ネットワーク内の全端末に送信する通信。         |
| ユニキャスト         | Unicast                           | 1対1の通信。                       |
| マルチキャスト        | Multicast                         | 特定グループ宛の通信。                   |
| VLAN           | Virtual LAN                       | L2ネットワークを論理的に分割する技術。          |
| Tagged VLAN    | VLAN tagging                      | フレームにVLAN IDを付与する方式。          |
| Untagged VLAN  | Access VLAN                       | VLANタグを付与しないポート通信。            |
| Accessポート      | Access port                       | 単一VLANに属するスイッチポート。            |
| Trunkポート       | Trunk port                        | 複数VLANを流すポート。                 |
| Native VLAN    | Native VLAN                       | trunkでタグなし通信が流れるVLAN。         |
| STP            | Spanning Tree Protocol            | L2ループを防ぐプロトコル。                |
| RSTP           | Rapid Spanning Tree               | STPの高速版。                      |
| MSTP           | Multiple STP                      | VLANごとにSTPを制御できる拡張。           |
| BPDU           | Bridge Protocol Data Unit         | STP制御フレーム。                    |
| LACP           | Link Aggregation Control Protocol | 複数リンクを束ねるプロトコル。               |
| EtherChannel   | Link aggregation                  | 複数リンクを1本として扱う技術。              |
| Port Channel   | Port channel                      | LACP等で束ねられた論理インターフェース。        |
| Loop防止         | Loop prevention                   | L2ネットワークでループを防ぐ設計。            |

---

# L3 基礎

| 用語          | 英語の言い換え                        | 解説                   |
| ----------- | ------------------------------ | -------------------- |
| IPアドレス      | IP address                     | L3ネットワーク識別子。         |
| IPv4        | IPv4                           | 32bitのIPアドレス方式。      |
| IPv6        | IPv6                           | 128bitのIPアドレス方式。     |
| サブネット       | Subnet                         | ネットワークを分割した単位。       |
| CIDR        | CIDR                           | クラスレスIP表記。           |
| デフォルトゲートウェイ | Default gateway                | 外部ネットワークへの出口ルータ。     |
| ICMP        | ICMP                           | pingなどで使用される制御プロトコル。 |
| TTL         | Time To Live                   | パケットの寿命。             |
| MTU         | Maximum Transmission Unit      | 一度に送れる最大フレームサイズ。     |
| フラグメント      | Fragmentation                  | MTUを超えたパケット分割。       |
| DHCP        | DHCP                           | IPアドレス自動配布プロトコル。     |
| DHCPリレー     | DHCP relay                     | DHCPを別ネットワークに転送。     |
| DNS         | Domain Name System             | 名前解決サービス。            |
| FQDN        | Fully Qualified Domain Name    | 完全修飾ドメイン名。           |
| NAT         | Network Address Translation    | IPアドレス変換技術。          |
| PAT         | Port Address Translation       | ポート番号でアドレス共有。        |
| SNAT        | Source NAT                     | 送信元IP変換。             |
| DNAT        | Destination NAT                | 宛先IP変換。              |
| VRF         | Virtual Routing and Forwarding | ルーティングテーブル分離。        |
| Anycast     | Anycast                        | 同一IPを複数拠点で共有。        |

---

# ルーティング

| 用語               | 英語の言い換え                  | 解説              |
| ---------------- | ------------------------ | --------------- |
| スタティックルート        | Static route             | 手動で設定するルート。     |
| デフォルトルート         | Default route            | 不明宛先の転送ルート。     |
| OSPF             | OSPF                     | リンクステート型ルーティング。 |
| OSPFエリア          | OSPF area                | OSPFの階層構造。      |
| DR / BDR         | Designated Router        | OSPFの代表ルータ。     |
| LSA              | Link State Advertisement | OSPF情報交換データ。    |
| BGP              | Border Gateway Protocol  | AS間ルーティング。      |
| AS番号             | Autonomous System Number | 自律システム識別番号。     |
| iBGP             | iBGP                     | 同一AS内BGP。       |
| eBGP             | eBGP                     | AS間BGP。         |
| BGPピア            | BGP peer                 | BGP接続ルータ。       |
| BGPルートリフレクタ      | Route Reflector          | iBGP拡張機能。       |
| BGP属性            | BGP attributes           | 経路選択パラメータ。      |
| MED              | Multi Exit Discriminator | BGP経路優先度。       |
| Local Preference | Local preference         | AS内ルート優先度。      |
| ECMP             | Equal Cost Multi Path    | 同コスト経路分散。       |
| ルートサマリ           | Route summarization      | 経路集約。           |
| ルート再配布           | Route redistribution     | ルーティング情報共有。     |
| ルートフィルタ          | Route filtering          | 経路制御。           |
| ブラックホールルート       | Blackhole route          | 破棄ルート。          |

---

# 冗長化

| 用語             | 英語の言い換え                            | 解説            |
| -------------- | ---------------------------------- | ------------- |
| VRRP           | Virtual Router Redundancy Protocol | ゲートウェイ冗長。     |
| HSRP           | Hot Standby Router Protocol        | Cisco冗長プロトコル。 |
| GLBP           | Gateway Load Balancing Protocol    | 負荷分散型冗長。      |
| Active-Standby | Active-Standby                     | 主待機構成。        |
| Active-Active  | Active-Active                      | 両系稼働構成。       |
| Gateway冗長      | Gateway redundancy                 | デフォルトGW冗長。    |
| Link冗長         | Link redundancy                    | 回線冗長。         |
| Dual Router    | Dual router                        | 2ルータ構成。       |
| Failover       | Failover                           | 障害時切替。        |
| Heartbeat      | Heartbeat                          | 生存監視通信。       |

---

# WAN / キャリア

| 用語                | 英語の言い換え                     | 解説                |
| ----------------- | --------------------------- | ----------------- |
| MPLS              | MPLS                        | ラベルスイッチング技術。      |
| MPLS-VPN          | MPLS VPN                    | MPLS上のVPN。        |
| IP-VPN            | IP VPN                      | キャリア提供閉域網。        |
| L3VPN             | Layer3 VPN                  | L3レベルVPN。         |
| L2VPN             | Layer2 VPN                  | L2レベルVPN。         |
| VPLS              | Virtual Private LAN Service | L2 VPN拡張。         |
| 専用線               | Dedicated line              | 物理専用回線。           |
| ベストエフォート          | Best effort                 | 品質保証なし通信。         |
| 帯域保証              | Guaranteed bandwidth        | QoS保証帯域。          |
| QoS               | Quality of Service          | 通信品質制御。           |
| CIR               | Committed Information Rate  | 保証帯域。             |
| PIR               | Peak Information Rate       | 最大帯域。             |
| バースト              | Burst traffic               | 短時間帯域増加。          |
| キャリアEther         | Carrier Ethernet            | 通信事業者Etherサービス。   |
| IX                | Internet Exchange           | ISP相互接続拠点。        |
| ISP               | Internet Service Provider   | インターネット提供事業者。     |
| トランジット            | Transit                     | 上位ISP接続。          |
| Peering           | Peering                     | ISP直接接続。          |
| Internet Breakout | Internet breakout           | 拠点から直接Internet接続。 |
| SD-WAN            | SD-WAN                      | ソフトウェア制御WAN。      |

---


# Security

| No | 用語             | 英語の言い換え                            | 解説                       |
| -- | -------------- | ---------------------------------- | ------------------------ |
| 1  | ファイアウォール       | Firewall                           | 通信をポリシーに基づき許可・拒否する装置。    |
| 2  | ステートフルインスペクション | Stateful inspection                | セッション状態を考慮して通信を制御するFW方式。 |
| 3  | パケットフィルタリング    | Packet filtering                   | IP/Portベースで通信制御する方式。     |
| 4  | IDS            | Intrusion Detection System         | 不正侵入を検知するシステム。           |
| 5  | IPS            | Intrusion Prevention System        | 不正侵入を検知し遮断するシステム。        |
| 6  | WAF            | Web Application Firewall           | Webアプリ攻撃を防御するFW。         |
| 7  | DMZ            | Demilitarized Zone                 | 外部公開サーバを置く隔離ネットワーク。      |
| 8  | ゼロトラスト         | Zero Trust                         | 全通信を信頼しない前提のセキュリティモデル。   |
| 9  | VPN            | Virtual Private Network            | 暗号化された仮想専用ネットワーク。        |
| 10 | IPsec          | IPsec                              | IP層で通信を暗号化するプロトコル。       |
| 11 | IKE            | Internet Key Exchange              | IPsec鍵交換プロトコル。           |
| 12 | SSL/TLS        | TLS                                | 通信暗号化プロトコル。              |
| 13 | HTTPS          | HTTPS                              | TLSを使用したHTTP通信。          |
| 14 | 公開鍵暗号          | Public Key Cryptography            | 公開鍵と秘密鍵を使う暗号方式。          |
| 15 | 共通鍵暗号          | Symmetric Encryption               | 同じ鍵を使う暗号方式。              |
| 16 | デジタル証明書        | Digital certificate                | 公開鍵の正当性を保証する証明書。         |
| 17 | PKI            | Public Key Infrastructure          | 公開鍵基盤。証明書管理システム。         |
| 18 | CA             | Certificate Authority              | 証明書発行機関。                 |
| 19 | CRL            | Certificate Revocation List        | 失効証明書リスト。                |
| 20 | OCSP           | Online Certificate Status Protocol | 証明書失効確認プロトコル。            |

---

# Security (Network Attack)

| No | 用語             | 英語の言い換え                       | 解説               |
| -- | -------------- | ----------------------------- | ---------------- |
| 1  | DoS            | Denial of Service             | サービス停止攻撃。        |
| 2  | DDoS           | Distributed Denial of Service | 分散型DoS攻撃。        |
| 3  | SYN Flood      | SYN Flood                     | TCP接続を悪用したDoS攻撃。 |
| 4  | ARPスプーフィング     | ARP spoofing                  | ARP偽装による通信盗聴。    |
| 5  | MITM           | Man in the Middle             | 中間者攻撃。           |
| 6  | DNSキャッシュポイズニング | DNS cache poisoning           | DNS応答偽装攻撃。       |
| 7  | セッションハイジャック    | Session hijacking             | セッション乗っ取り攻撃。     |
| 8  | リプレイ攻撃         | Replay attack                 | 通信の再送による攻撃。      |
| 9  | ポートスキャン        | Port scan                     | 開放ポート探索。         |
| 10 | ブルートフォース       | Brute force                   | 総当たり攻撃。          |

---

# Security (Enterprise)

| No | 用語   | 英語の言い換え                                   | 解説              |
| -- | ---- | ----------------------------------------- | --------------- |
| 1  | IAM  | Identity and Access Management            | IDとアクセス管理。      |
| 2  | MFA  | Multi Factor Authentication               | 多要素認証。          |
| 3  | SSO  | Single Sign-On                            | 一度の認証で複数サービス利用。 |
| 4  | RBAC | Role Based Access Control                 | 役割ベースアクセス制御。    |
| 5  | ABAC | Attribute Based Access Control            | 属性ベースアクセス制御。    |
| 6  | SIEM | Security Information and Event Management | セキュリティログ分析基盤。   |
| 7  | SOC  | Security Operation Center                 | セキュリティ監視組織。     |
| 8  | EDR  | Endpoint Detection and Response           | エンドポイント脅威検知。    |
| 9  | XDR  | Extended Detection and Response           | 統合型脅威検知。        |
| 10 | CASB | Cloud Access Security Broker              | クラウド利用制御。       |

---

# Enterprise Network Terms

| No | 用語           | 英語の言い換え           | 解説                         |
| -- | ------------ | ----------------- | -------------------------- |
| 1  | ローカルブレイクアウト  | Local breakout    | 拠点から直接インターネットに接続する方式。      |
| 2  | セントラルブレイクアウト | Central breakout  | 本社を経由してインターネット接続する方式。      |
| 3  | 閉域網          | Private network   | インターネットを経由しないキャリア専用ネットワーク。 |
| 4  | IP-VPN       | IP-VPN            | キャリア提供のL3閉域ネットワーク。         |
| 5  | L2VPN        | Layer2 VPN        | L2レベルのVPNサービス。             |
| 6  | MPLS網        | MPLS network      | MPLSベースのキャリアネットワーク。        |
| 7  | 拠点間VPN       | Site-to-site VPN  | 拠点間をVPNで接続する方式。            |
| 8  | リモートアクセスVPN  | Remote access VPN | 個人端末から社内接続するVPN。           |
| 9  | インターネットVPN   | Internet VPN      | インターネットを利用したVPN。           |
| 10 | SD-WAN       | SD-WAN            | ソフトウェア制御のWAN。              |

---

# Enterprise Network Architecture Terms

| No | 用語     | 英語の言い換え                     | 解説            |
| -- | ------ | --------------------------- | ------------- |
| 1  | EDI    | Electronic Data Interchange | 企業間データ交換システム。 |
| 2  | 基幹システム | Core system / ERP           | 企業の中核業務システム。  |
| 3  | 外部接続   | External connectivity       | 社外システム接続。     |
| 4  | B2B接続  | B2B integration             | 企業間システム連携。    |
| 5  | ゲートウェイ | Gateway                     | ネットワーク境界装置。   |
| 6  | DMZ配置  | DMZ deployment              | 公開サーバの隔離配置。   |
| 7  | NAT変換  | NAT translation             | IPアドレス変換。     |
| 8  | FWポリシー | Firewall policy             | FW通信制御ルール。    |
| 9  | 通信要件   | Network requirement         | システム通信仕様。     |
| 10 | 通信経路   | Network path                | システム通信ルート。    |

---

# キャリア・通信ベンダー用語

| No | 用語       | 英語の言い換え                 | 解説             |
| -- | -------- | ----------------------- | -------------- |
| 1  | 回線収容     | Circuit termination     | 回線をルータへ収容すること。 |
| 2  | 帯域設計     | Bandwidth design        | 必要通信帯域の設計。     |
| 3  | 回線冗長     | Line redundancy         | 回線の二重化。        |
| 4  | キャリア切替   | Carrier failover        | 回線障害時の切替。      |
| 5  | 帯域保証     | Guaranteed bandwidth    | QoS保証帯域。       |
| 6  | バースト     | Burst traffic           | 一時的帯域増加。       |
| 7  | トラフィック制御 | Traffic shaping         | 通信制御。          |
| 8  | QoS制御    | QoS control             | 通信優先制御。        |
| 9  | SLA      | Service Level Agreement | サービス品質保証。      |
| 10 | 保守窓      | Maintenance window      | メンテナンス時間。      |

---

# Enterprise Network Migration Terms

（あなたの案件にドンピシャ）

| No | 用語        | 英語の言い換え                      | 解説            |
| -- | --------- | ---------------------------- | ------------- |
| 1  | ネットワーク分離  | Network separation           | 企業分離時のNW分割。   |
| 2  | TSA       | Transition Service Agreement | 分離後の暫定IT提供契約。 |
| 3  | 経路分離      | Route separation             | 通信経路分離。       |
| 4  | IPアドレス再設計 | IP renumbering               | IPアドレス再割当。    |
| 5  | DNS分離     | DNS separation               | 名前解決基盤分離。     |
| 6  | AD分離      | Active Directory separation  | AD環境分離。       |
| 7  | FW境界      | Firewall boundary            | 組織境界FW。       |
| 8  | 接続点       | Interconnect point           | ネットワーク接続拠点。   |
| 9  | 接続制御      | Access control               | 接続制御設計。       |
| 10 | 暫定接続      | Temporary connectivity       | 移行期間接続。       |

---

