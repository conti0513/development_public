# FileMaker on AWS VPC Peering 疎通検証ガイド（Revised）

本ドキュメントは、
**2つの異なるVPCに配置された FileMaker Server と FileMaker Client を
VPC Peering で接続し、実アプリケーションを導入せずに
L4 レイヤー（TCP/5003）の疎通を完全に証明するための実践ガイド**である。

目的は以下の一点に集約される。

> **「インフラとOS設定が正しい」ことを、アプリ非依存で証明する**

---

## 1. 構成概要

VPCを完全に分離し、
インターネットを経由しない **VPC Peering（プライベートな土管）** で接続する。

```text
[ 管理用PC ] --- (HTTPS/RDP) --- [ AWS Console / SSM ]
                                          |
+-----------------------------------------|---------------------------+
| AWS Cloud (Tokyo Region)                |                           |
|                                         v                           |
|  [ VPC-A: Server Side ]          [ VPC-C: Client Side ]             |
|  CIDR: 10.1.0.0/16               CIDR: 10.3.0.0/16                  |
|  +-------------------+           +-------------------+              |
|  | [fm-server]       | <=======> | [fm-client]       |              |
|  | Windows 2022      |  Peering  | Windows 2022      |              |
|  | IP: 10.1.1.225    |  (pcx-xxx)| IP: 10.3.1.224    |              |
|  | IAM: SSM-Role     |           | IAM: SSM-Role     |              |
|  +-------------------+           +-------------------+              |
|           ^                                  ^                      |
|           | (SG: 3389, 5003, ICMP)           | (SG: 3389)           |
+-----------|----------------------------------|----------------------+
            |                                  |
            +------- (RDP over Internet) ------+

```

---

## 2. 設計・検証のポイント

### 2.1 キーペア不要の認証設計

* IAM Role（`AmazonSSMManagedInstanceCore`）を利用
* Fleet Manager 経由で Administrator パスワードを制御
* `.pem` ファイルは使用しない

※ **SSMロールに `kms:Decrypt` 権限がないとパスワード取得に失敗する点に注意**

---

### 2.2 フルプライベート通信の成立

* 通信は **Private IP のみ**（10.x.x.x）
* Internet Gateway / NAT Gateway を経由しない
* 疎通が成立すれば、ネットワーク設計は論理的に正しいと断定できる

---

### 2.3 トラブルの分離（3レイヤー）

| レイヤー | 対象                     | 典型トラブル   |
| ---- | ---------------------- | -------- |
| インフラ | Security Group / Route | 通らない     |
| OS   | Windows Firewall       | 拒否される    |
| 識別   | Network Profile        | ルールが効かない |

本ガイドは、この3層を**順番に突破**する構成になっている。

---

## 3. デプロイと初期設定

1. **Terraform デプロイ**

   ```bash
   terraform apply -auto-approve
   ```

2. **Administrator パスワードリセット**

   * AWS Console → Fleet Manager
   * 各ノードの Administrator パスワードをリセット

3. **RDP ログイン**

   * `fm-server`
   * `fm-client`

---

## 4. Windows OS レイヤーの壁を突破する

### 4.1 ネットワークプロファイル変更（重要）

Peering 経由の通信を信頼済みとして扱う。

**[両ノードで実行]**

```powershell
Get-NetConnectionProfile | Set-NetConnectionProfile -NetworkCategory Private
```

※ Public のままだと Firewall ルールが効かないケースがある。

---

### 4.2 Windows Firewall の明示的許可

**FileMaker が使用する主要データ通信ポート（TCP/5003）**と
診断用 ICMP を開放する。

**[fm-server 側で実行]**

```powershell
# FileMaker 通信用 (5003)
New-NetFirewallRule `
  -DisplayName "FileMaker Server (TCP-In)" `
  -Direction Inbound `
  -LocalPort 5003 `
  -Protocol TCP `
  -Action Allow

# ICMP (Ping)
New-NetFirewallRule `
  -DisplayName "Allow ICMPv4-In" `
  -Protocol ICMPv4 `
  -IcmpType 8 `
  -Action Allow
```

---

## 5. アプリ不要で完遂する「L4 疎通証明」

### 5.1 サーバ側：即席 5003 リスナー

**[fm-server 側]**

```powershell
$listener = [System.Net.Sockets.TcpListener]5003
$listener.Start()
Write-Host "5003番ポートで待機中..." -ForegroundColor Yellow
$client = $listener.AcceptTcpClient()
Write-Host "接続検知。L4疎通は正常。" -ForegroundColor Green
$client.Close()
$listener.Stop()
```

---

### 5.2 クライアント側：疎通確認

**[fm-client 側]**

```powershell
Test-NetConnection -ComputerName 10.1.1.225 -Port 5003
```

**期待結果**

* `PingSucceeded : True`（L3 OK）
* `TcpTestSucceeded : True`（L4 OK）

---

## 6. トラブルシューティング

| 事象           | 原因                       | 対処                |
| ------------ | ------------------------ | ----------------- |
| Ping Timeout | SGでICMP未許可               | 検証用途として一時的に許可     |
| 接続拒否         | Network Profile が Public | Private に変更       |
| パスワード取得失敗    | IAM権限不足                  | `kms:Decrypt` を追加 |

---

## 7. 撤収

検証完了後は速やかに削除する。

```bash
terraform destroy -auto-approve
```

---

## 8. まとめ

本手法により、

* インフラ設計
* ルーティング
* OS設定

が **FileMaker 非依存で正しい** ことを証明できる。

これは、

> 「繋がらない原因がどこにあるのか」

ではなく、

> **「どこに“ない”のか」**

を明確にするための検証である。

---

