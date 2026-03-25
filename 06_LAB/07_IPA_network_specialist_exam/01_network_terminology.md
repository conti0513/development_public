# NW & Security Exam Terminology (Complete)

---

QUIZ結果

| No | 分野       | 問題数 | 1回目 | 2回目 | 3回目 | 4回目 | 5回目 |
| -- | -------- | --- | --- | --- | --- | --- | --- |
| 1  | L2       | 60  |     |     |     |     |     |
| 2  | L3       | 60  |     |     |     |     |     |
| 3  | Routing  | 60  |     |     |     |     |     |
| 4  | 冗長化      | 80  |     |     |     |     |     |
| 5  | WAN      |     |     |     |     |     |     |
| 6  | Security |     |     |     |     |     |     |
| 7  | 暗号 / PKI |     |     |     |     |     |     |
| 8  | VPN      |     |     |     |     |     |     |
| 9  | DNS      |     |     |     |     |     |     |
| 10 | 負荷分散     |     |     |     |     |     |     |
| 11 | クラウドNW   |     |     |     |     |     |     |
| 12 | 監視 / 運用  |     |     |     |     |     |     |
　
---

# 1. L2 (Data Link Layer)

| No | 用語             | 英語                                | 解説                     |
| -- | -------------- | --------------------------------- | ---------------------- |
| 1  | MACアドレス        | MAC address                       | NICに割り当てられる48bitのL2識別子 |
| 2  | ARP            | Address Resolution Protocol       | 同一ネットワークでIPからMACを解決    |
| 3  | Gratuitous ARP | Gratuitous ARP                    | 自身のIPとMAC対応を通知するARP    |
| 4  | Broadcast      | Broadcast                         | 同一セグメントの全端末へ送信         |
| 5  | Unicast        | Unicast                           | 1対1の通信方式               |
| 6  | Multicast      | Multicast                         | 特定グループ宛の通信             |
| 7  | VLAN           | Virtual LAN                       | L2ネットワークを論理分割          |
| 8  | VLAN Tag       | VLAN tagging                      | 802.1QでVLAN IDを付与      |
| 9  | Access Port    | Access port                       | 単一VLANに属するポート          |
| 10 | Trunk Port     | Trunk port                        | 複数VLANを流すポート           |
| 11 | Native VLAN    | Native VLAN                       | Trunkでタグなし通信のVLAN      |
| 12 | STP            | Spanning Tree Protocol            | L2ループを防止するプロトコル        |
| 13 | RSTP           | Rapid STP                         | STPの高速収束版              |
| 14 | MSTP           | Multiple STP                      | VLAN毎にSTP制御            |
| 15 | BPDU           | Bridge Protocol Data Unit         | STP制御用フレーム             |
| 16 | LACP           | Link Aggregation Control Protocol | リンク集約制御プロトコル           |
| 17 | EtherChannel   | EtherChannel                      | 複数リンクを1本として扱う          |
| 18 | PortChannel    | Port Channel                      | リンク集約の論理IF             |
| 19 | Loop Guard     | Loop Guard                        | STP誤動作によるループ防止         |
| 20 | BPDU Guard     | BPDU Guard                        | BPDU受信時にポート停止          |

---

# 2. L3 基礎

| No | 用語                 | 英語                             | 解説               |
| -- | ------------------ | ------------------------------ | ---------------- |
| 1  | IPv4               | IPv4                           | 32bitのIPアドレス方式   |
| 2  | IPv6               | IPv6                           | 128bitの次世代IPアドレス |
| 3  | Subnet             | Subnet                         | IPネットワークの分割単位    |
| 4  | CIDR               | CIDR                           | クラスレスIP表記方式      |
| 5  | Default Gateway    | Default gateway                | 外部ネットワークへの出口     |
| 6  | ICMP               | ICMP                           | ネットワーク制御やエラー通知   |
| 7  | TTL                | Time To Live                   | パケットが通過できる最大ホップ数 |
| 8  | MTU                | Maximum Transmission Unit      | 1回送信可能な最大サイズ     |
| 9  | Fragmentation      | Fragmentation                  | MTU超過時のパケット分割    |
| 10 | Path MTU Discovery | PMTUD                          | 経路の最小MTUを検出      |
| 11 | DHCP               | DHCP                           | IPアドレス自動割当       |
| 12 | DHCP Relay         | DHCP relay                     | DHCPを別ネットワークへ中継  |
| 13 | DNS                | DNS                            | ドメイン名をIPへ変換      |
| 14 | FQDN               | Fully Qualified Domain Name    | 完全修飾ドメイン名        |
| 15 | NAT                | Network Address Translation    | IPアドレス変換技術       |
| 16 | PAT                | Port Address Translation       | ポート番号でアドレス共有     |
| 17 | SNAT               | Source NAT                     | 送信元IPアドレス変換      |
| 18 | DNAT               | Destination NAT                | 宛先IPアドレス変換       |
| 19 | VRF                | Virtual Routing and Forwarding | ルーティングテーブル分離     |
| 20 | Anycast            | Anycast                        | 同一IPを複数拠点で共有     |

---

# 3. Routing

| No | 用語                   | 英語                       | 解説          |
| -- | -------------------- | ------------------------ | ----------- |
| 1  | Static Route         | Static route             | 手動設定のルート    |
| 2  | Default Route        | Default route            | 未知宛先の転送経路   |
| 3  | OSPF                 | OSPF                     | リンクステート型IGP |
| 4  | OSPF Area            | OSPF area                | OSPFの階層構造   |
| 5  | DR                   | Designated Router        | OSPF代表ルータ   |
| 6  | LSA                  | Link State Advertisement | OSPF経路情報    |
| 7  | BGP                  | Border Gateway Protocol  | AS間ルーティング   |
| 8  | AS                   | Autonomous System        | ネットワーク管理単位  |
| 9  | iBGP                 | iBGP                     | 同一AS内BGP    |
| 10 | eBGP                 | eBGP                     | AS間BGP      |
| 11 | BGP Peer             | BGP peer                 | BGP接続相手     |
| 12 | Route Reflector      | Route Reflector          | iBGP経路拡張機能  |
| 13 | MED                  | Multi Exit Discriminator | BGP経路優先度    |
| 14 | Local Preference     | Local preference         | AS内優先度      |
| 15 | ECMP                 | Equal Cost Multi Path    | 同コスト経路分散    |
| 16 | Route Summarization  | Route summarization      | 経路集約        |
| 17 | Route Redistribution | Route redistribution     | ルート再配布      |
| 18 | Route Filtering      | Route filtering          | 経路制御        |
| 19 | Blackhole Route      | Blackhole route          | 破棄用ルート      |
| 20 | Policy Routing       | Policy routing           | 条件に基づく転送    |

---

# 4. 冗長化

| No | 用語                 | 英語                                 | 解説          |
| -- | ------------------ | ---------------------------------- | ----------- |
| 1  | VRRP               | Virtual Router Redundancy Protocol | デフォルトGW冗長   |
| 2  | HSRP               | Hot Standby Router Protocol        | Cisco独自GW冗長 |
| 3  | GLBP               | Gateway Load Balancing Protocol    | GW負荷分散      |
| 4  | Active-Standby     | Active-Standby                     | 主待機構成       |
| 5  | Active-Active      | Active-Active                      | 両系稼働構成      |
| 6  | Gateway Redundancy | Gateway redundancy                 | ゲートウェイ冗長    |
| 7  | Link Redundancy    | Link redundancy                    | 回線冗長        |
| 8  | Dual Router        | Dual router                        | 2台ルータ構成     |
| 9  | Failover           | Failover                           | 障害時自動切替     |
| 10 | Heartbeat          | Heartbeat                          | 生存監視通信      |

---

# 5. WAN

| No | 用語                | 英語                          | 解説               |
| -- | ----------------- | --------------------------- | ---------------- |
| 1  | MPLS              | MPLS                        | ラベル転送方式          |
| 2  | MPLS VPN          | MPLS VPN                    | MPLS上の閉域VPN      |
| 3  | IP-VPN            | IP VPN                      | キャリア閉域網          |
| 4  | L3VPN             | Layer3 VPN                  | L3レベルVPN         |
| 5  | L2VPN             | Layer2 VPN                  | L2レベルVPN         |
| 6  | VPLS              | Virtual Private LAN Service | L2拠点接続           |
| 7  | Dedicated Line    | Dedicated line              | 専用回線             |
| 8  | Best Effort       | Best effort                 | 品質保証なし通信         |
| 9  | QoS               | Quality of Service          | 通信品質制御           |
| 10 | CIR               | Committed Information Rate  | 保証帯域             |
| 11 | PIR               | Peak Information Rate       | 最大帯域             |
| 12 | Burst             | Burst traffic               | 短時間帯域増加          |
| 13 | Carrier Ethernet  | Carrier Ethernet            | 事業者Etherサービス     |
| 14 | IX                | Internet Exchange           | ISP接続拠点          |
| 15 | ISP               | Internet Service Provider   | インターネット事業者       |
| 16 | Transit           | Transit                     | 上位ISP接続          |
| 17 | Peering           | Peering                     | ISP相互接続          |
| 18 | Internet Breakout | Internet breakout           | 拠点から直接Internet接続 |
| 19 | SD-WAN            | SD-WAN                      | ソフト制御WAN         |
| 20 | LTE Backup        | LTE backup                  | モバイル回線冗長         |

---

# 6. Network Security

| No | 用語                  | 英語                  | 解説               |
| -- | ------------------- | ------------------- | ---------------- |
| 1  | DNS Cache Poisoning | DNS cache poisoning | DNSキャッシュを書き換える攻撃 |
| 2  | DNSSEC              | DNSSEC              | DNS応答の電子署名       |
| 3  | DoS                 | Denial of Service   | サービス停止攻撃         |
| 4  | DDoS                | Distributed DoS     | 複数端末からDoS        |
| 5  | SYN Flood           | SYN flood attack    | TCP接続枯渇攻撃        |
| 6  | MITM                | Man in the Middle   | 通信盗聴攻撃           |
| 7  | ARP Spoofing        | ARP spoofing        | ARP偽装攻撃          |
| 8  | IP Spoofing         | IP spoofing         | 送信元IP偽装          |
| 9  | Session Hijacking   | Session hijacking   | 通信セッション乗っ取り      |
| 10 | Replay Attack       | Replay attack       | 通信再送攻撃           |

---

# 7. PKI / 暗号

| No | 用語              | 英語                                 | 解説       |
| -- | --------------- | ---------------------------------- | -------- |
| 1  | PKI             | Public Key Infrastructure          | 公開鍵基盤    |
| 2  | Public Key      | Public key                         | 公開される暗号鍵 |
| 3  | Private Key     | Private key                        | 秘密鍵      |
| 4  | Certificate     | Digital certificate                | 公開鍵の身分証  |
| 5  | CSR             | Certificate Signing Request        | 証明書発行申請  |
| 6  | CA              | Certificate Authority              | 認証局      |
| 7  | Root CA         | Root CA                            | 最上位認証局   |
| 8  | Intermediate CA | Intermediate CA                    | 中間認証局    |
| 9  | CRL             | Certificate Revocation List        | 失効証明書リスト |
| 10 | OCSP            | Online Certificate Status Protocol | 証明書失効確認  |

---

# 8. VPN

| No | 用語            | 英語                             | 解説          |
| -- | ------------- | ------------------------------ | ----------- |
| 1  | VPN           | Virtual Private Network        | 暗号化仮想回線     |
| 2  | IPsec         | IPsec                          | IPレベル暗号通信   |
| 3  | ESP           | Encapsulating Security Payload | IPsec暗号化方式  |
| 4  | AH            | Authentication Header          | IPsec認証方式   |
| 5  | IKE           | Internet Key Exchange          | 鍵交換プロトコル    |
| 6  | IKEv2         | IKEv2                          | 改良IKE       |
| 7  | Site-to-Site  | Site-to-Site VPN               | 拠点間VPN      |
| 8  | Remote Access | Remote access VPN              | リモートVPN     |
| 9  | SSL VPN       | SSL VPN                        | HTTPSベースVPN |
| 10 | Split Tunnel  | Split tunnel                   | VPN通信分離     |

---

# 9. DNS

| No | 用語                   | 英語                   | 解説        |
| -- | -------------------- | -------------------- | --------- |
| 1  | Recursive Resolver   | Recursive resolver   | 再帰DNSサーバ  |
| 2  | Authoritative Server | Authoritative server | 権威DNS     |
| 3  | Root Server          | Root server          | DNSルートサーバ |
| 4  | TLD Server           | TLD server           | トップレベルDNS |
| 5  | DNS Cache            | DNS cache            | 名前解決結果保存  |
| 6  | DNSSEC               | DNSSEC               | DNS署名検証   |
| 7  | Zone                 | Zone                 | DNS管理単位   |
| 8  | Zone Transfer        | Zone transfer        | DNSゾーン同期  |
| 9  | Forwarder            | Forwarder            | DNS転送サーバ  |
| 10 | TTL                  | Time To Live         | キャッシュ有効時間 |

---

# 10. Load Balancing

| No | 用語               | 英語                        | 解説        |
| -- | ---------------- | ------------------------- | --------- |
| 1  | Load Balancer    | Load balancer             | サーバ負荷分散   |
| 2  | L4 LB            | Layer4 Load Balancer      | TCPレベル分散  |
| 3  | L7 LB            | Layer7 Load Balancer      | HTTP分散    |
| 4  | Round Robin      | Round robin               | 順番分散      |
| 5  | Least Connection | Least connection          | 最少接続分散    |
| 6  | Health Check     | Health check              | 死活監視      |
| 7  | Sticky Session   | Sticky session            | 同一セッション維持 |
| 8  | Reverse Proxy    | Reverse proxy             | サーバ代理     |
| 9  | Failback         | Failback                  | 障害復旧後復帰   |
| 10 | HA Cluster       | High Availability cluster | 高可用構成     |

---

# 11. Cloud Networking

| No | 用語               | 英語                    | 解説            |
| -- | ---------------- | --------------------- | ------------- |
| 1  | VPC              | Virtual Private Cloud | クラウド仮想NW      |
| 2  | Subnet           | Subnet                | VPC内NW分割      |
| 3  | Route Table      | Route table           | 通信経路定義        |
| 4  | Internet Gateway | Internet Gateway      | Internet接続    |
| 5  | NAT Gateway      | NAT Gateway           | PrivateNW外部通信 |
| 6  | Private Subnet   | Private subnet        | Internet非公開NW |
| 7  | Security Group   | Security group        | 仮想FW          |
| 8  | NACL             | Network ACL           | サブネットFW       |
| 9  | VPC Peering      | VPC Peering           | VPC接続         |
| 10 | Transit Gateway  | Transit Gateway       | VPC集約ルータ      |

---

# 12. 監視 / 運用

| No | 用語                | 英語                                 | 解説      |
| -- | ----------------- | ---------------------------------- | ------- |
| 1  | SNMP              | Simple Network Management Protocol | NW監視    |
| 2  | Syslog            | Syslog                             | ログ収集    |
| 3  | NetFlow           | NetFlow                            | 通信フロー分析 |
| 4  | sFlow             | sFlow                              | 軽量フロー監視 |
| 5  | Packet Capture    | Packet capture                     | パケット解析  |
| 6  | Port Mirroring    | Port mirroring                     | 監視コピー   |
| 7  | NTP               | Network Time Protocol              | 時刻同期    |
| 8  | SLA               | Service Level Agreement            | サービス品質  |
| 9  | KPI               | Key Performance Indicator          | 運用指標    |
| 10 | Capacity Planning | Capacity planning                  | 容量計画    |

---
