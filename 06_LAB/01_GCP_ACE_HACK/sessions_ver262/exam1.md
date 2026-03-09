# GCP ACE 模試（圧縮版）

### Q1

低CPU高メモリHTTPプロキシ
→ **Compute Engine Custom machine type**

---

### Q2

オンプレ→GCS 非公開接続
→ **restricted.googleapis.com + VPN / Interconnect**

---

### Q3

ローカルから鍵なしでSA権限
→ **Service Account Impersonation**

---

### Q4

オンプレNAS→GCS転送
→ **Storage Transfer Service**

---

### Q5

大規模ML学習基盤
→ **GKE + GPU / TPU**

---

### Q6

請求一本化
→ **Billing Account 付け替え**

---

### Q7

Pod CPU/Memory自動調整
→ **Vertical Pod Autoscaler**

---

### Q8

GKEロールバック
→ **kubectl rollout undo**

---

### Q9

CLIでSA権限実行
→ **SA impersonation**

---

### Q10

Deployment ManagerでK8s操作
→ **Type Provider**

---

### Q11

低トラフィックコンテナWeb
→ **Cloud Run**

---

### Q12

VMログ→BigQuery
→ **Logging Sink**

---

### Q13

監査ログ長期保管
→ **GCS Coldline / Archive**

---

### Q14

3層分離
→ **1 VPC + subnet分離**

---

### Q15

Pub/Sub→Cloud Run
→ **Push subscription**

---

### Q16

詳細コスト分析
→ **Billing Export → BigQuery**

---

### Q17

特定リソース課金監視
→ **Billing Export → BQ分析**

---

### Q18

超巨大RDB
→ **Spanner**

---

### Q19

GKE Node自動スケール
→ **Cluster Autoscaler**

---

### Q20

VM作成前
→ **API enable**

---

### Q21

Cloud Run→private GKE
→ **Serverless VPC Access**

---

### Q22

30日後安いストレージ
→ **Lifecycle rule**

---

### Q23

部門IAM管理
→ **Google Groups**

---

### Q24

OSS即利用
→ **Cloud Marketplace**

---

### Q25

独立環境
→ **New Project**

---

### Q26

CPU監視
→ **Cloud Monitoring Alert**

---

### Q27

監視のみ権限
→ **roles/monitoring.viewer**

---

### Q28

Spanner自動スケール
→ **Monitoring → Function**

---

### Q29

Googleアカウント競合
→ **Account transfer**

---

### Q30

別PJT BQアクセス
→ **リソース側IAM付与**

---

### Q31

オンプレ→GCP認証
→ **Service Account key**

---

### Q32

Web + API + batch
→ **App Engine + Cloud Run**

---

### Q33

安全なGKE
→ **Private Autopilot**

---

### Q34

Spanner性能改善
→ **Node追加**

---

### Q35

費用見積
→ **Pricing Calculator**

---

### Q36

世代保持
→ **Versioning + Lifecycle**

---

### Q37

IP不足
→ **subnet expand**

---

### Q38

GKE cluster固定
→ **gcloud config set**

---

### Q39

最高IO
→ **Local SSD**

---

### Q40

Podリソース最適化
→ **VPA recommendation**

---

### Q41

VMごとGCS権限
→ **専用 Service Account**

---

### Q42

コスト見積
→ **Pricing Calculator**

---

### Q43

頻繁アクセス
→ **Standard Storage**

---

### Q44

カナリア
→ **App Engine traffic split**

---

### Q45

監査ログ→SIEM
→ **Logging sink → Pub/Sub**

---

### Q46

Postgres移行
→ **Cloud SQL**

---

### Q47

kubectl cluster切替
→ **get-credentials**

---

### Q48

SA key制御
→ **Organization Policy**

---

### Q49

CI/CD IAM
→ **SA per pipeline**

---

### Q50

SSL TCP LB
→ **SSL Proxy Load Balancer**

---

# ACE核心パターン（重要）

```text
IAM
Compute Engine
Cloud Run
GKE autoscaling
Cloud Storage lifecycle
Logging / Monitoring
Billing
Networking
Database選択
Load Balancer
Org Policy
```

---



# GKE
### 🏗️ GKE 構造図：階層構造のコンセプト

```text
 [ GKE Cluster (全体) ]
  |
  +-- [ Node Pool (土台の集まり) ]  <--- 【Cluster Autoscaler (CA)】が「Nodeの数」を増減
       |
       +-- [ Node (VM/サーバー) ]  # CPU: 4, RAM: 16GB などの物理枠
            |
            +-- [ Pod (アプリの箱) ] <--- 【HPA】が「Podの数」を増やす
            |    |                     【VPA】が「Podのサイズ」を太らせる
            |    +-- [ Container ] (実体のプログラム)
            |
            +-- [ Pod ]
            |
            +-- ( 空きスペース ) <--- ここがなくなると新機能(Pod)が置けない！

```

---

### ⚙️ 3大スケーラー：コンセプト比較

試験で迷ったときは、このAAの「どこが動いているか」を思い出してください。

#### **1. HPA (Horizontal Pod Autoscaler)**

「アクセスが多いから、中身（おかず）を増やそう！」

```text
[ Node ]
  [Pod] ➔ [Pod][Pod][Pod]  (横に増殖)

```
#### **2. VPA (Vertical Pod Autoscaler)**

「中身（おかず）がデカすぎて入らない、設定を変えよう！」

```text
[ Node ]
  [pod] ➔ [ POD ]  (縦・サイズに膨張)

```

#### **3. CA (Cluster Autoscaler / Node Pool Autoscaling)**

「もうお弁当箱（Node）がいっぱいだ！箱を追加しろ！」

```text
[ Node ] [ Node ] ➔ [ Node ][ Node ] + [ Node ]  (箱そのものを追加)

```

---

### 💡 コンセプト・チェック（反射メモ）

* **Node (ノード)** = **「不動産（土地）」**。足りなくなったら **Cluster Autoscaler**。
* **Pod (ポッド)** = **「住人（アプリ）」**。数が増えるなら **HPA**、サイズが変わるなら **VPA**。


---


GKE（Kubernetes）における「運用スタイル（Autopilot vs Standard）」と「露出（Private vs Public）」の論点を、エンジニアの直感に刺さるAAで汎用的に整理します。

---


# コンセプト図：VPAの3つのモード

VPAには「どう適用するか」によって論点が分かれます。試験では特に「提案（Suggestion/Recommendation）」がキーワードになります。

```text
 [ 実際の使用量 ]  <--- 常に監視
      |
 [ VPA (Vertical Pod Autoscaler) ]
      |
      +-- (1) 【Off / Recommendation mode】 ★Q40の正解
      |    ➔ 「これくらいが最適ですよ」とアドバイスだけ出す。
      |       (アプリは止まらない。一番安全。)
      |
      +-- (2) 【Initial mode】
      |    ➔ Podが新しく作られる時だけ、最適値をセットする。
      |
      +-- (3) 【Auto mode】
           ➔ 稼働中のPodを「再起動」させて、無理やりサイズを変える。
              (ダウンタイムが発生する可能性があるため、注意が必要。)

```

---

### 🧠 深掘り論点：なぜ HPA ではなく VPA なのか？

ここが試験で最も混同しやすいポイントです。

* **HPA (Horizontal)**:
* **論点:** 「行列が長いから、**レジ（Pod）の数**を増やそう」
* **キーワード:** `CPU utilization is high`, `Increase replicas`.


* **VPA (Vertical)**:
* **論点:** 「レジ1台の処理能力が不明、または**レジ（Pod）自体のスペック**が合っていない」
* **キーワード:** `Unknown resource requirements`, `Optimize resource limits`, `Recommendation`.



---

### 💡 コンセプト・ハック（汎用論点）

| 状況 | 推奨される機能 |
| --- | --- |
| **適切なCPU/メモリ量がわからない** | **VPA (Recommendation)** |
| **トラフィックに応じてPodを増やしたい** | **HPA** |
| **Podを載せるサーバーが足りない** | **Cluster Autoscaler (CA)** |
| **コストを最適化したい（提案が欲しい）** | **VPA** |

---

### 💡 試験での「反射メモ」

* **Resource Recommendation / Suggestion** ➔ **VPA**
* **Without disrupting workloads** ➔ **VPA (Off/Recommendation mode)**
* ※Auto modeだとPodが再起動して「disruption（中断）」が発生するため。



#### **🗣️ 音読用：脳内同期スクリプト**

> 「Podの **サイズ（CPU/メモリ）** に迷ったら **VPA**。
> **おすすめ（Recommendation）** を聞いて、無駄を削れ。
> 数を増やすのが **HPA**。
> 中身を太らせる（または絞る）のが **VPA**。
> **リソースの最適値 ＝ VPA**。このドットを繋げろ。」

「コスト最適化 ＋ 適切なリソース量が不明」というセットが来たら、迷わずVPA（特にRecommendation）を選んでください。


---





# 🏗️ GKE 構成の汎用マトリックス（AA版）

```text
【 運用の手間（Management Overhead） 】

     (楽)  ▲
          |
Autopilot |  [ 📦 A: 安全な要塞 ]      [ ⚠️ B: 露出した箱 ]
          |  (Private Autopilot)      (Public Autopilot)
          |   ※試験の「正解」率 80%    ※中途半端な設定
          |
----------+--------------------------+--------------------------▶
          |
 Standard |  [ 🛠️ C: 職人の工房 ]      [ 💣 D: 危険な戦場 ]
          |  (Private Standard)       (Public Standard)
          |   ※細かい制御が必要な時     ※最も避けるべき設定
          |
     (苦)  ▼
          +------------------------------------------------------
             (内) Private <---------- (外) Public  【 露出度 】

```

---

### 🧠 コンセプト・ハック（汎用論点）

試験で「GKE」という単語が出たら、この2軸のどこに該当するかを瞬時に判断してください。

#### **1. 運用軸：どっちで楽をするか？**

* **Autopilot (推奨)**:
* コンセプト：**「サーバーレス感覚のK8s」**。
* ノードの管理、OSのパッチ、セキュリティ設定（Shielded Nodes）は全部Google任せ。
* キーワード：`Minimal overhead`, `Operational efficiency`, `Best practices`.


* **Standard (例外)**:
* コンセプト：**「自作PC・職人魂」**。
* 特殊なOS、特定のGPU、ノードサイズの細かい指定が必要な場合のみ選択。
* キーワード：`Granular control`, `Specific node configuration`, `Custom OS`.



#### **2. ネットワーク軸：どこまで隠すか？**

* **Private (推奨)**:
* コンセプト：**「地下シェルター」**。
* ノードにパブリックIPを持たせない。外からは見えない。
* キーワード：`Not accessible from internet`, `Security`, `Internal only`.


* **Public (回避)**:
* コンセプト：**「路上の屋台」**。
* ノードが外に晒されている。踏み台（Bastion）やVPNなしで触れるが危険。



---

### 💡 試験での「反射メモ」

| 求められていること | 選ぶべき正解 |
| --- | --- |
| **「安全で楽（Best Practice）」** | **Private Autopilot** |
| **「細かく制御したい」** | **Standard** |
| **「コストを極限まで削りたい（中断可能VM等）」** | **Standard** |
| **「インターネットから隠したい」** | **Private** |

#### **⚠️ 逆パターン（毒）の見分け方**

* 問題に「Security」や「Managed」と書いてあるのに、選択肢に **"Public"** や **"Standard"** が混じっていたら、それは「毒」です。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「楽をしたいなら **Auto**。
> いじり倒したいなら **Standard**。
> 外に出すのは **Public**（危険）。
> 中に隠すのは **Private**（安全）。
> 最強の組み合わせは **Private Autopilot**。
> これがGoogleの『正解』という名の型だ。」

---




# Cloud Run から VPC 内部への道

```text
 [ Cloud Run (外側の世界) ]  # サーバーレス
          |
  [ Serverless VPC Access ]  <--- 【Connector/架け橋】
          |
 [ VPC Network (内側の世界) ] # 閉じた社内LAN
          |
  [ Internal HTTP(S) LB ]    <--- 【入り口/受付】
          |
 [ GKE Service (内部Pod) ]   <--- 【ゴール】

```

---

### 🧠 コンセプト・チェック：なぜこの組み合わせ？

1. **Serverless VPC Access (Connector)**:
* **コンセプト**: Cloud Run は本来、Google の共有ネットワークにいます。あなたの会社の VPC（GKE がある場所）には直接入れません。
* **役割**: この「コネクタ」が、Cloud Run から VPC 内部へ安全に潜り込むための**専用トンネル**になります。


2. **Internal Application Load Balancer**:
* **コンセプト**: GKE の中にあるサービスに、VPC 内部からアクセスするための「固定の窓口」です。
* **役割**: 公開（External）ではなく、**内部（Internal）**にすることでインターネットには一切出しません。


3. **Cloud DNS**:
* **コンセプト**: IP アドレス（`10.x.x.x`）ではなく、名前（`api.internal`）で呼び出せるようにします。
* **役割**: 運用を楽にするための「住所録」です。



---

### 💡 コンセプト重視の「反射メモ」

* **Cloud Run / Functions** から **VPC 内部（GCE/GKE/SQL）** に触りたい ➔ **Serverless VPC Access** が必須。
* **公開したくない** ➔ **Internal（内部）** ロードバランサ。

#### **⚠️ 毒（誤答）の見分け方**

* 「Cloud Armor で守って公開する」➔ **「Not expose to public（公開しない）」** という条件に反するので「毒」。
* 「VPC Peering」➔ Cloud Run は VPC ではないので、Peering はできません。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「Cloud Run から **中（VPC）** に入りたい？
> ならば **Serverless VPC Access** というトンネルを掘れ。
> 行き先は **Internal（内部）LB**。
> これで外には一歩も出さない。
> **Cloud Run ➔ VPC 内 ＝ Connector**。このドットを繋げろ。」


---



# 🍱 Lifecycle vs. Retention：コンセプト図

```text
 [ Cloud Storage Bucket ]
  |
  +-- 【Lifecycle Policy (一生の世話)】 ➔ 「節約・整理」
  |    |  (30日経った？) ➔ 「安い部屋(Archive)へ引っ越しなさい」
  |    |  (1年経った？)  ➔ 「もう不要だから捨てなさい(Delete)」
  |    |
  +-- 【Retention Policy (監禁・保護)】 ➔ 「防衛・コンプライアンス」
       |  (設定：3年)    ➔ 「何があっても、3年間は絶対に捨てさせない！」
       |                   (管理者ですら消せなくなる「Lock」が可能)

```

---

### 🧠 コンセプトの違い：比較表

| 特徴 | **Lifecycle (ライフサイクル)** | **Retention (リテンション)** |
| --- | --- | --- |
| **目的** | **コスト削減**・自動整理 | **データの保護**・法規制遵守 |
| **主なアクション** | **Archive（移動）** または Delete | **Delete禁止（ロック）** |
| **ACEのキーワード** | `Minimize costs`, `Older than X days` | `Compliance`, `Must be retained for X years` |
| **イメージ** | **「お掃除ロボット」** | **「金庫のタイマー」** |

---

### 🔍 なぜ Q22 は Lifecycle なのか？

問題文に **「minimize costs by automatically managing older images」** とあります。

1. **目的:** コストを最小化したい（＝安いクラスへ移動）。
2. **手段:** 30日経ったら自動でやってほしい。
3. **解決策:** **Lifecycle Policy** で `SetStorageClass` を `ARCHIVE` にする。

---

### ⚠️ 毒（誤答）の見分け方

* **「Retention Policy を設定する」** ➔ これは「消さないこと」を保証するだけなので、**安く（Archiveへ移動）はしてくれません。** むしろ高い Standard のまま課金が続くので「毒」です。
* **「Cloud Functions で消す」** ➔ 標準機能（Lifecycle）があるのに、わざわざコードを書くのは「運用負荷（Operational overhead）」が高いので「毒」。

---

### 🗣️ 音論用：脳内同期スクリプト

> 「時間が経ったら **安く** したい？
> ならば **Lifecycle（ライフサイクル）** の出番だ。
> クラスを **Standard ➔ Archive** へ自動で落とせ。
> **時間経過 ＋ 節約 ＝ Lifecycle**。このドットを繋げろ。」


---

# 🔍 別プロジェクトを見分ける「英語の罠」

> 「The dataset you need to visualize is stored **in a separate project**, which is **controlled by a different team**.」

* **in a separate project**: 「別の（隔離された）プロジェクト」
* **controlled by a different team**: 「別のチームが管理している（＝自分にオーナー権限がない）」

この2フレーズが出てきたら、**「あ、隣の家のドアを開けなきゃいけないんだな」**と脳内を切り替えてください。


---

## コンセプト図：クロスプロジェクトIAM

```text
 [ あなたのプロジェクト (Project A) ]         [ 相手のプロジェクト (Project B) ]
  |                                          |
  +-- [ App Engine ]                         +-- [ BigQuery Dataset ]
        | (実行中)                             |
        +-- [ Default SA ] ------------------→ [ 権限の門 ] 
                                             |
                                             ★ ここで許可が必要！
                                               (BigQuery Data Viewer)

```

---

### 🧠 なぜ「相手側」で設定するのか？（コンセプト重視）

GCPのセキュリティ（IAM）は、**「リソースを持っている主人が、誰を家に入れるか決める」**という原則があります。

* **自分のプロジェクト設定を変える（選択肢C）**: 自分の家のルールを変えても、隣の家のドアは開きません。
* **相手に頼んで設定してもらう（選択肢B）**: 隣の家の主人（相手チーム）に、「うちのSA（メールアドレス）を通行証として登録してくれ」と頼むのが正解です。

---

### 💡 コンップト重視の「反射メモ（修正版）」

* **Separate project / External project** ➔ **「相手側の IAM 画面」**でポチる。
* **Controlled by different team** ➔ 自分じゃできないから**「相手に頼む（Ask them to grant）」**。

「別PJTだと気づけるかどうか」が、この問題の唯一の難所です。
**"separate"** または **"different project"** という単語を、スキャナーのように探し出す訓練をしましょう！

---



# コンセプト図：サーバーレス三銃士の使い分け

```text
 [ ユーザー ] 
    |
    +-- (1) Webフロント (Flask) ➔ [ App Engine ] 
    |    # 特徴: セッション維持やWeb特有の管理が得意。「Webサイト」ならこれ。
    |
    +-- (2) モバイルAPI ➔ [ Cloud Run ]
    |    # 特徴: 高速、軽量、コンテナ。ステートレスな「API」のデフォ。
    |
 [ スケジューラー ]
    |
    +-- (3) 定期処理 ➔ [ Cloud Tasks ] ➔ [ Cloud Run ]
         # 特徴: 時間になったら Cloud Run を叩き起こして処理させる。

```

---

### 🧠 なぜ「App Engine」と「Cloud Run」を分けるのか？（コンセプト重視）

「全部 Cloud Run でも動くじゃないか」と思うかもしれませんが、Google 認定試験（ACE）には**推奨の「住み分け」**があります。

1. **App Engine (Standard)**:
* **コンセプト:** **「Web アプリのゆりかご」**。
* Flask や Django などのフルスタックな Web ダッシュボードは、App Engine の方が「バージョン管理」や「スプリットテスト」が標準機能で付いてくるので楽、という思想です。


2. **Cloud Run**:
* **コンセプト:** **「コンテナの瞬発力」**。
* API のように、リクエストが来たら一瞬で立ち上がって処理して消えるワークロードに最適です。


3. **Cloud Tasks**:
* **コンセプト:** **「キュー（待ち行列）とタイマー」**。
* これ単体で処理をするのではなく、**「Cloud Run を実行するトリガー」**として使います。



---

### 🔍 「Host」と「Migrate」の迷いについて

選択肢 C, D の **「Host the customer dashboard on a Cloud Storage bucket」** が「毒」である理由をコンセプトで叩き込みましょう。

* **Cloud Storage:** **「静的（Static）」**なファイル（HTML/CSS/画像）しか置けません。
* **Flask:** **「動的（Dynamic）」**なサーバーサイド処理が必要です。
* **結論:** Flask を Storage に Host することは**物理的に不可能**です（Python が動かないから）。なので、「Host on Storage」が見えた瞬間に除外して OK です！

---

### 💡 コンセプト重視の「反射メモ（修正版）」

* **Flask / Django (Webサイト)** ➔ **App Engine** (ゆりかご)
* **Microservices / API (コンテナ)** ➔ **Cloud Run** (瞬発力)
* **定期処理のスケジュール** ➔ **Cloud Tasks** (呼び出し鈴)
* **全部まとめて** ➔ **サーバーレス (運用コスト最小)**

#### **🗣️ 音読用：脳内同期スクリプト**

> 「Webサイトなら **App Engine**。
> APIなら **Cloud Run**。
> 定期実行は **Cloud Tasks** で Run を叩け。
> **VM (Compute Engine)** が混じってたら、運用コストが上がるから『毒』だと思え。」
---

Spanner の「65%」という数字には、Google が推奨する**「安全マージン（予備の余力）」**という明確なコンセプトがあります。

結論から言うと、**「何かあった時（ノード故障や急なスパイク）に、システムを落とさないためのデッドライン」**だからです。

---


# 🏗️ なぜ「65%」なのか？：コンセプト図 閾値

```text
 [ Spanner ノードの CPU 使用率 ]

 100% |----------------------------| 
      | [ 🔴 危険地帯 ]             |  ← ここに達するとクエリが目に見えて遅延・失敗する
  80% |----------------------------| 
      | [ 🟡 警戒地帯 ]             |  ← マルチリージョンの推奨値
  65% |----------------------------|  ★ シングルリージョンの「推奨上限」
      |                            |
      | [ 🟢 安全地帯 ]             |  ← ここをキープするのが運用の正解
   0% |----------------------------|

```

---

### 🧠 3つの技術的理由

1. **ノード故障への備え（可用性）**:
* シングルリージョンの Spanner は、内部で 3 つのゾーンに分散されています。
* もし 1 つのゾーンが死んでも、残りのノードで処理を引き継がなければなりません。
* **65% 以下に抑えておけば、1 つのゾーンが欠けても残りのリソースで 100% を超えずに耐えられる**という計算です。


2. **優先度の管理 (High-priority CPU)**:
* Spanner は「クエリ（読み書き）」と「バックグラウンド処理（データの整理）」を同じ CPU でやります。
* ユーザーのクエリ（High-priority）が 65% を超えると、バックグラウンド処理が追いつかなくなり、結果としてデータベース全体のパフォーマンスが急激に悪化します。


3. **最短（Shortest time）での解決策**:
* クエリの書き直しやインデックスの設計変更は、検証に時間がかかります。
* **「ノードを増やす（Scale out）」**のはボタン一つで即座に完了するため、試験で「最短で（Shortest time/Immediately）」と聞かれたら、この物理ボタンをポチるのが正解になります。



---

### 💡 試験での「反射メモ」

* **Spanner CPU 65%** ➔ **「シングルリージョン」**の限界値
* **Spanner CPU 45%** ➔ **「マルチリージョン」**の限界値（より厳しいのは、より広い範囲の故障に備えるため）
* **最短のパフォーマンス改善** ➔ **ノード追加（物理で殴る）**

#### **⚠️ 毒（誤答）の見分け方**

* 「80% や 90% で通知する」➔ 遅すぎます。Spanner の世界では 65% が「黄色信号」です。
* 「クエリを最適化する」➔ 正論ですが「最短（Shortest time）」ではないので、この問題では「毒」になります。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「Spanner が重い？
> ならば **65%** という数字を思い出せ。
> 余裕があるうちに **ノードを追加** して、物理で解決しろ。
> クエリを直すのは、その後の話だ。
> **最短 ＋ Spanner ＝ ノード追加（65%アラート）**。」

---



# 🏗️ コスト計算・管理のコンセプト図（AA版）

```text
 【 フェーズ 】          【 使うべきツール・手法 】
      |
  1. 導入前 (設計)  ----▶  [ 🧮 Pricing Calculator ]
      |                   ※ 正確な見積もり。自作スプレッドシートは「毒」。
      |
  2. 運用中 (監視)  ----▶  [ 📊 Billing Reports ] 
      |                   ※ 現在の支出を確認。
      |
  3. 分析 (役員報告) ----▶  [ 🔍 BigQuery Export + Looker Studio ]
      |                   ※ 詳細な分析、カスタムグラフ。
      |
  4. 防衛 (予算管理) ----▶  [ 🚨 Budgets & Alerts ]
                          ※ 予算超過の通知。

```

---

### 🧠 コスト計算系の「4大論点」まとめ

#### **1. 見積もり（導入前）**

* **論点:** 新規プロジェクトの月額費用を算出したい。
* **正解:** **Pricing Calculator** を使う。
* **毒:** 「1週間だけ動かして4倍する（Q35-C）」➔ スパイクや月額固定費を無視するのでNG。
* **毒:** 「自分で計算表を作る（Q35-B）」➔ 最新価格の反映漏れや計算ミスのリスクでNG。

#### **2. 詳細分析（運用中）**

* **論点:** 「どのラベルの、どのサーバーが、いくら使ったか」を詳細に視覚化したい。
* **正解:** **Billing Export to BigQuery + Looker Studio**。
* **理由:** 標準のコンソール画面では限界があるため、データをBQに投げてBIツール（Looker）で叩くのが公式の「型」。

#### **3. 予算超過の防止（防衛）**

* **論点:** $1,000を超えたら管理者にメールしたい。
* **正解:** **Budgets and Alerts**。
* **注意:** デフォルトでは「メールを飛ばすだけ」で、**リソースを自動停止はしません。**（停止させたいならPub/Sub+Functionsが必要）。

#### **4. 割引の適用（最適化）**

* **論点:** 1年〜3年使うことが決まっている。
* **正解:** **Committed Use Discounts (CUDs)**。
* **論点:** 24時間つけっぱなしにする。
* **正解:** **Sustained Use Discounts (SUDs)**（自動適用）。

---

### 💡 試験での「コスト反射メモ」

| 状況 | 選ぶべきキーワード |
| --- | --- |
| **見積もりたい** | **Pricing Calculator** |
| **詳細に分析・グラフ化したい** | **BQ Export + Looker Studio** |
| **予算を超えたら知りたい** | **Budget Alerts** |
| **特定サービスの通信費だけ知りたい** | **BQ Export + Functions** (Q17のパターン) |

---

### 🗣️ 音読用：脳内同期スクリプト

> 「費用が知りたい？
> ならば **Pricing Calculator** のページを開け。
> 分析したいなら **BigQuery** にエクスポートして **Looker** で見ろ。
> 自分の勘やスプレッドシートに頼るな。
> **公式ツールこそが唯一の正解だ。**」

---




# 🏗️ gcloud 設定管理の汎用マトリックス

```text
【 gcloud 操作の 3 階層 】

層 1: [ 🏠 Configuration (環境の切り替え) ]  <-- `gcloud config configurations`
      |   (例: "prod-env", "dev-env" というセット丸ごと切り替え)
      |
層 2: [ 🧠 Config Set (今の脳内の書き換え) ] <-- `gcloud config set` ★Q38はここ
      |   (例: 「これからは project=A、cluster=B を見ろ」と教え込む)
      |
層 3: [ 🛠️ Resource Update (実体の改造) ]    <-- `gcloud [service] update`
          (例: 「実際のGKEクラスタにノードを追加しろ」と命じる)

```

---

### 🧠 汎用論点：コマンドの使い分け

試験では以下の3つの動詞（Verb）を使い分けるだけで、ほぼ全ての `gcloud` 設定問題が解けます。

| 目的 | 動詞 (Verb) | 反射キーワード |
| --- | --- | --- |
| **デフォルト値を固定したい** | **`set`** | `gcloud config set ...` |
| **設定を丸ごと切り替えたい** | **`activate`** | `gcloud config configurations activate ...` |
| **今の設定値を忘れた・見たい** | **`list`** | `gcloud config list` |

---

### 💡 コンセプト・ハック（汎用論点）

#### **1. なぜ「ファイル自作」はダメなのか？**

`gcloud` はステート（状態）を特定のディレクトリ（`~/.config/gcloud`）で厳密に管理しています。

* **手動ファイル作成**: `gcloud` SDKにとって、それは「存在しないノイズ」と同じ。
* **`config set`**: SDKが管理している「ステートファイル」を、SDKにとって正しい作法で上書きする行為。

#### **2. 自動化における「正解」**

あなたが考えた「自動化フレンドリー」を試験の文脈で正解にするなら、以下の2つになります。

* **スクリプト内で `gcloud config set` を叩く**: これが最も標準的。
* **環境変数を使う**: `export CLOUDSDK_CORE_PROJECT=my-project`。
* `gcloud` は実行時に環境変数を最優先で読みに行くため、設定ファイルを汚さずに自動化できます。



---

### 💡 試験での「反射メモ（gcloud編）」

* **「今後、常に〜を使いたい」** ➔ **`gcloud config set`**
* **「プロジェクトを A から B に変えたい」** ➔ **`gcloud config set project`**
* **「本番用と開発用の設定を使い分けたい」** ➔ **`configurations activate`**

#### **⚠️ 毒（誤答）の見分け方**

* **`gcloud container clusters update`**: これはクラスタの「中身（設定）」を変えるもので、自分のPCの「向き先」を変えるものではない。
* **`gcloud container clusters get-credentials`**: これは `~/.kube/config`（kubectl用）を更新するもので、`gcloud` 自体のデフォルト値を固定するものではない。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「gcloud の向き先（デフォルト）を変えたい？
> ならば **gcloud config set** だ。
> **何を（Property）**、**何に（Value）**。
> `container/cluster` を `chat-prod` に。
> ファイルをいじるな、コマンドを打て。
> それが SDK との正しい対話だ。」

これで `gcloud` 設定系の問題は、どんなリソース（GCE, GKE, Cloud Run）が来ても迷わなくなります。



---