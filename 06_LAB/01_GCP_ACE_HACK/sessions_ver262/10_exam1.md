# GCP ACE 模試 Session1

## 間違えた問題の論点整理


### Q13: ログの長期保存

* **【元の文】**: Your organization runs a social media platform that needs to store user activity log files for 3 years. Your platform manages hundreds of Google Cloud projects. You need to implement a cost-effective solution for retaining these log files.
* **【論点抽出】**
* **主体**: 数百プロジェクトのログ
* **目的**: 3年間の長期保持
* **制約**: **Cost-effective（最安）** / 低頻度アクセス


* **【コンセプト】**: 分析不要の長期保存 ➔ GCSの安いクラス。BigQueryは保存コスト高で「毒」。
* **【結論】**: **Log Sink ➔ GCS Coldline**

---

### Q15: Cloud Run と Pub/Sub 連携

* **【元の文】**: You are managing a new microservices-based application... SnapWave... audio clips... processes user activity messages from a Cloud Pub/Sub topic... follow Google's recommended best practices...
* **【論点抽出】**
* **主体**: Pub/Sub ➔ Cloud Run
* **目的**: メッセージ処理
* **制約**: **Best Practices（サーバーレスの作法）**


* **【コンセプト】**: Cloud Runは受動的な「Push」が正義。認証は「合言葉（SA + Invoker）」を添える。
* **【結論】**: **Push Subscription ＋ SA ＋ Invoker Role**


---


### Q17: 特定リソースの費用監視

* **【元の文】**: ...Apache web server that runs on a Compute Engine instance... Apache web server is just one of many applications... want to receive an email notification when the egress network costs for the Apache server exceed $100 for the current month...
* **【論点抽出】**
* **主体**: 特定の VM（Apache）
* **目的**: **Egress（送信）通信費**が $100 超えたら通知
* **制約**: 標準の予算アラート（プロジェクト単位）では粒度が足りない。


* **【コンセプト】**: 「特定の何か」を細かく集計するなら、生データを BigQuery に投げて SQL で叩く。
* **【結論】**: **BQ Export ＋ Cloud Function ＋ Scheduler**


---



### Q25: プロジェクトの完全分離

* **【元の文】**: The content management team has a project named Content Analytics Hub... You need to set up similar Google Cloud resources for the design team, but their resources must be organized independently of the content management team.
* **【論点抽出】**
* **主体**: コンテンツチーム と デザインチーム
* **目的**: リソースのセットアップ
* **制約**: **Organized independently（完全に独立・分離）**


* **【コンセプト】**: 独立＝壁。GCP最大の壁はプロジェクト。同じIDは二度と使えない。
* **【結論】**: **Create Another Project (Unique ID)**


---



### Q40: GKEリソースの最適化

* **【元の文】**: ...deploy a new workload... uncertain about the workload's exact resource needs because they may vary based on different usage patterns... implement a solution that offers cost-effective suggestions for CPU and memory...
* **【論点抽出】**
* **主体**: GKE Workload
* **目的**: CPU/メモリの最適化
* **制約**: **Uncertain about exact needs（需要不明）** / Cost-effective


* **【コンセプト】**: 数（HPA）とサイズ（VPA）の使い分け。需要不明なら VPA の「提案」を聞く。
* **【結論】**: **HPA（可用性） ＋ VPA（サイズ提案）**


---



### Q41: 特定VMへの権限絞り込み

* **【元の文】**: ...manage a third-party photo editing application... other Compute Engine instances... are using default configurations... ensure that the new instance can access these installation files without allowing other virtual machines (VMs) in PixelPro's network to access them.
* **【論点抽出】**
* **主体**: 特定の 1 台の VM
* **目的**: GCS バケットへのアクセス
* **制約**: **Without allowing other VMs（他のVMには絶対見せない）**


* **【コンセプト】**: 合鍵（Default SA）はダメ。専用の身分証（New SA）を作って渡す。
* **【結論】**: **New Service Account ＋ Bucket 権限**


---



### Q43: 頻繁アクセスのストレージ

* **【元の文】**: ...setting up the most cost-efficient storage solution... processes large datasets continuously for critical analytics tasks... accessed regularly by teams based in Boston... ensure minimal storage costs while maintaining optimal access speeds...
* **【論点抽出】**
* **主体**: ボストンのチーム
* **目的**: データセットの継続的分析
* **制約**: **Minimal costs（最安）** / **Optimal access speed（速度）** / 頻繁アクセス


* **【コンセプト】**: ボストン限定なら Regional。毎日使うなら Standard（Nearlineは取り出し料が高い）。
* **【結論】**: **Regional ＋ Standard**


---



### Q46: DBのクラウド移行

* **【元の文】**: ...handles order processing for a single warehouse facility... app runs on PostgreSQL, and you are looking to migrate it to the cloud with minimal changes to the existing codebase.
* **【論点抽出】**
* **主体**: PostgreSQL アプリ
* **目的**: クラウド移行
* **制約**: **Minimal changes to codebase（コード修正なし）** / ACID（整合性）


* **【コンセプト】**: 最短ルートは「同じもの」を選ぶ。PostgreSQL ➔ Cloud SQL (PostgreSQL)。
* **【結論】**: **Cloud SQL (PostgreSQL)**

---



# 🔍 論点スキャンの「3ステップ・メソッド」

問題文を読んでいる時、脳内で以下の3つだけを抽出してください。

```text
 ① 誰が？ (Subject)    ➔ 人間？ プログラム(SA)？ 外部組織？
 ② 何をしたい？ (Goal)  ➔ 移行？ 分析？ セキュリティ強化？ 
 ③ 制約は？ (Constraint) ➔ ★ここが最重要！
                          「最小変更」「最小コスト」「ダウンタイムなし」
                          「特定の場所から」「公開せずに」

```

---

### 🧠 「論点スイッチ」の変換テーブル（例）

これが脳内にインストールされていると、スキャンの速度が劇的に上がります。

| 問題文のキーワード（トリガー） | 反射的にONになる「論点スイッチ」 |
| --- | --- |
| **"Minimal operational overhead"** | **Managed Service（サーバーレス）を選べ** |
| **"Minimal changes to code"** | **Cloud SQL / 同種のエンジンを選べ** |
| **"Least privilege"** | **専用SA（カスタムSA）を選べ** |
| **"Without public IP"** | **Private Google Access / Cloud NAT を探せ** |
| **"Recommend resources"** | **VPA (Vertical Pod Autoscaler) を探せ** |
| **"Analyze petabytes of data"** | **BigQuery または Bigtable を探せ** |

---

### 🏗️ Session 2 で狙われる「論点の壁」

Session 2（ネットワーク）では、論点が少し複雑になりますが、構造は同じです。

```text
 [ 要件：オンプレと繋ぎたい ]
          |
    +-----+-----+
    |           |
 [ 安く、早く ] [ 高速、安定 ]
    |           |
  ( VPN )    ( Interconnect )

```

---



# 📝 論点抽出トレーニングの「型」例（Q15の場合）
【元の文】
You are managing a new microservices-based application... SnapWave... audio clips... processes user activity messages from a Cloud Pub/Sub topic... follow Google's recommended best practices...

【論点抽出（贅肉なし）】
誰が（主体）: Pub/Sub ➔ Cloud Run

何を（目的）: メッセージ処理（Push型連携）

制約（重要）: Best Practices（セキュリティ ＋ 運用効率）

【正解を導くコンセプト】
Push 連携: Cloud RunはHTTPで叩かれるのを待つ「Push」が標準（Pullは常駐が必要で非効率）。

認証: Pub/Subに「Invoker権限」を持つ専用SAを添えて叩かせるのが鉄則。

結論: Push ＋ SA ＋ Invoker Role が三種の神器。

---













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



# Cloud Run と Pub/Sub の配送ルート

```text
 [ Cloud Pub/Sub (送信元) ] 
          |
    【 配送方式の選択 】
    1. Pull (受取人が取りに来る) ➔ Cloud Runには不向き（常に待機が必要でCFが痛い）
    2. Push (配送員が届ける) ➔ ★正解。HTTPリクエストとして届く
          |
    【 セキュリティの門番 】
    [ Service Account ] ➔ 【Invoker (呼び出し) 権限】
          |
 [ Cloud Run (受取人) ] ➔ メッセージを受け取って起動！ (Scale to 1)

```

---

### 🧠 コンセプト・チェック：なぜこの組み合わせ？

1. **Push Subscription**:
* **コンセプト**: Cloud Runは「リクエストが来た時だけ動く」のが本質。
* **役割**: Pub/Sub側から「URL」を叩いてもらうことで、メッセージが来た瞬間だけCloud Runを叩き起こします。


2. **Service Account & Invoker Role**:
* **コンセプト**: Cloud Runを「誰でも叩ける（Allow unauthenticated）」状態にするのはセキュリティ事故。
* **役割**: Pub/Subに「このサービスアカウントのフリをして叩け」と命じ、Cloud Run側で「そのSAなら許可」とする**専用の合言葉**です。



---

### 💡 コンセプト重視の「反射メモ」

* **Cloud Run / Functions × Pub/Sub** ➔ **Push型**一択。
* **認証が必要** ➔ **Cloud Run Invoker** 権限を **Pub/Sub用のSA** に付与。

#### **⚠️ 毒（誤答）の見分け方**

* **「Pull Subscription」** ➔ Cloud Runは常駐サーバーではないので「毒」。
* **「Cloud Functionを中継する」** ➔ 直接Pushできるのに中継するのは「運用負荷（無駄な工程）」なので「毒」。
* **「Subscriber 権限」** ➔ これだけでは「叩く（Invoke）」ことができないので不十分。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「Cloud Run で Pub/Sub を処理したい？
> ならば **Push（押し込み）** で届けさせろ。
> 勝手に叩かれないよう、専用の **SA** を作って、
> **Invoker（呼び出し人）** というバッジを持たせろ。
> **Cloud Run ＋ Pub/Sub ＝ Push ＋ Invoker**。
> この配送ルートを脳に刻め。」

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


# プロジェクトの独立と隔離ハック

```text
 [ Existing Project (A) ]        [ Another Project (B) ]
 (zephyr-analytics-hub)         (zephyr-design-hub)
          |                               |
  +-------+-------+               +-------+-------+
  | Content Team  |               |  Design Team  |
  +---------------+               +---------------+
          |                               |
    [ 隔離の壁 ] <----------------------- [ 隔離の壁 ]

```

---

### 🧠 コンセプト・チェック：なぜ Another/New なのか？

1. **Another (もう一つの) / New (新しい)**:
* **コンセプト**: GCPにおいて、最も強固なセキュリティ境界（境界線）は「プロジェクト」です。
* **役割**: 「独立して（independently）」「他チームの影響を受けずに」というキーワードが出たら、既存のプロジェクトの中で頑張るのではなく、**外側にもう一つの箱を作る**のがGoogleの正解です。


2. **Project ID の一意性**:
* **ひっかけ**: 選択肢Dの「既存と同じIDで新しい名前のプロジェクトを作る」は、**物理的に不可能**（IDは全世界で唯一無二）なので即座に「毒」として捨てます。



---

### 💡 コンセプト重視の「反射メモ」

* **リソースを独立させたい / チームごとに分けたい** ➔ **Create Another Project** (新しい箱を作る)。
* **権限(IAM)でなんとかする** ➔ 同じ箱（プロジェクト）を使うことになるので、独立性が低く「毒」。

#### **⚠️ 毒（誤答）の見分け方**

* **「Project Editor権限を付与する」** ➔ 独立せず、既存プロジェクトを「共有」してしまうので「毒」。
* **「Project Lien (削除保護) を設定する」** ➔ 削除は防げるが、独立性（整理のしやすさ）とは無関係なので「毒」。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「チーム間でリソースを分けたい？
> ならば **Another Project（別プロジェクト）** を立ち上げろ。
> ID を新しく振れば、そこは完全な **独立国家**。
> IAM も請求も、隣のチームに邪魔されない。
> **独立 ＝ 別プロジェクト作成**。
> 箱の中で仕切るな、新しい箱を用意しろ。」

---

### 🔍 Another と New の使い分け（試験対策）

* **New Project**: 単に「新しく作る」という動作に注目。
* **Another Project**: 既存のものとは別に「もう一つの独立した単位」を作るという、**アーキテクチャ上の隔離**に注目。


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

# 特定リソースの通信費（Egress）監視ハック

```text
 [ Google Cloud 請求元データ ]  <--- 【膨大な生データ】
          |
  [ Billing Export ]           <--- 【流し込み】
          |
 [ BigQuery (データ倉庫) ]      <--- 【分析基盤】
          |
  [ Cloud Function ]           <--- 【SQLで特定条件を抽出】
    # 「Apacheサーバー」かつ「Egress費」だけを足算
          |
 [ Cloud Scheduler ]           <--- 【定期実行タイマー】
          |
 [ Email / Slack (通知) ]      <--- 【100ドル超えたら通報】

```

---

### 🧠 コンセプト・チェック：なぜこの組み合わせ？

1. **Billing Export to BigQuery**:
* **コンセプト**: Google Cloud の標準画面（Billing Console）は、プロジェクト全体の合計は見れますが、「特定のVMの特定の通信費」といった細かいフィルタリングはできません。
* **役割**: 全ての「明細データ」を BigQuery に吐き出すことで、自由自在に集計できるようにします。


2. **Cloud Function (集計ロジック)**:
* **コンセプト**: 明細データの中から「ApacheサーバーのEgress費」という行だけを抜き出すには、SQLクエリを投げる必要があります。
* **役割**: BigQuery に対して `SUM(cost) WHERE service = 'Compute' AND resource = 'Apache' AND unit = 'Egress'` と命令し、結果を判定します。


3. **Cloud Scheduler**:
* **コンセプト**: 誰かが手動で SQL を叩くのは「運用負荷」が高いです。
* **役割**: 「1時間に1回、自動でチェックしろ」という目覚まし時計の役割をします。



---

### 💡 コンセプト重視の「反射メモ」

* **プロジェクト全体の予算監視** ➔ **Budgets & Alerts** (標準機能)
* **特定リソース・特定項目（Egress等）の監視** ➔ **BigQuery Export + Cloud Function** (カスタム集計)

#### **⚠️ 毒（誤答）の見分け方**

* **「Project Budget Alert」** ➔ プロジェクト全体の合計額でしかアラートが出ないため、Apache以外の費用が混じってしまい「毒」。
* **「Logging Agent から HTTP レスポンスサイズを計算」** ➔ ログから通信費を算出するのは複雑すぎて正確性に欠けるため「毒」。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「特定のサーバーの通信費だけを知りたい？
> ならば **BigQuery** に請求データを流し込め。
> **Cloud Function** という小遣い帳係に、
> 特定の行（Apacheの通信費）だけを計算させろ。
> **特定項目の予算 ＝ Billing Export ＋ BigQuery**。
> 標準機能で無理なら、SQLで殴れ。」

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



Q41の論点は一見地味ですが、実は**「セキュリティの境界線（アイソレーション）」**と**「最小権限（Least Privilege）」**の超重要ルールを問うています。

エンジニア的にこの問題を解剖（ハック）しましょう！

---


# インスタンス固有の「専用アクセス権」ハック

```text
 [ あなたのプロジェクト ]
          |
  +-------+-----------------------------+
  |                                     |
 [ ターゲットVM ]                  [ 他の一般VM ]
 (編集アプリ用)                    (デフォルト設定)
          |                             |
  ★【専用の鍵(SA)】付与            ☆【共通の鍵】のまま
          |                             |
          |                             |
  [ Cloud Storage (Bucket) ]            |
  (インストールファイル)                  |
          |                             |
    [ ⭕️ アクセス許可 ] <------------- [ ❌ アクセス拒否 ]

```

---

### 🧠 コンセプト・チェック：なぜ「New Service Account」なのか？

1. **Default Service Account は「合鍵」**:
* **コンセプト**: Compute Engine を作ると自動で付いてくる「デフォルトSA」は、プロジェクト内の多くのVMで共有されています。
* **役割**: デフォルトSAに権限をあげてしまうと、**「その鍵を持っている他のVM」までバケットの中身が見えてしまいます。** これは「他のVMには見せたくない」という要件に違反します。


2. **New Service Account は「指名された人のみの通行証」**:
* **コンセプト**: 特定のインスタンスだけに**専用のアイデンティティ（名前）**を与えます。
* **役割**: 「このバケットは、このSA（専用SA）だけが見ていいよ」とIAMで設定することで、物理的な隔離が完成します。



---

### 💡 コンセプト重視の「反射メモ」

* **特定のVMだけに権限を絞りたい** ➔ **専用の Service Account** を作成してアタッチする。
* **Default SA を使う** ➔ 権限が広がりすぎるので、試験ではほぼ **「毒（誤答）」**。

#### **⚠️ 毒（誤答）の見分け方**

* **「Metadata を使ってアクセス制御する」** ➔ メタデータは単なる「ラベル」や「メモ」です。**鍵（権限）の代わりにはならない**ので、これが出てきたら100%「毒」です。
* **「Network 設定で制限する」** ➔ Cloud Storage は VPC の外（Google ネットワーク）にあるので、ファイアウォール等のネットワーク設定だけでは権限管理ができません。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「特定の VM だけにファイルを触らせたい？
> ならば **専用の Service Account（専用の鍵）** を作れ。
> デフォルトの鍵を使い回すな。
> それはマンションの全住人に合鍵を配るのと同じだ。
> **特定のリソース制限 ＝ 新規 SA 作成**。
> アイデンティティを分けて、権限を絞り込め。」

---

### 🔍 Q41の「読み解き」ポイント

問題文の **「without allowing other virtual machines (VMs) ... to access them」** という一文。これが **「Default SA（共通の鍵）は使うなよ！」** という強烈なサインです。

これに気づければ、選択肢 A（Default）を消して、C（New SA）を即決できるようになります！

---

# 🏗️ サービスアカウント（SA）運用：完全攻略マトリックス

#### **① インスタンスへの権限付与（基本作法）**

「鍵（JSON）を持ち歩かない」のがクラウドの流儀です。

```text
  [ 安全な型：アタッチ ]                [ 危険な型：鍵の持ち歩き ]
   (Best Practice)                      (Anti-Pattern)

   [ Compute Engine ]                   [ Compute Engine ]
          |                                    |
   (身分証の紐付け)                      (物理キーを配置) 
   Identity: SA_A                        /home/user/key.json ❌
          |                                    |
   [ Metadata Server ]                  (盗まれるリスク大)
          |
    (自動でトークン発行)
          |
   [ 各種 GCP サービス ]

```

* **反射メモ:** GCP内部なら「JSONキー不要」。インスタンスに**SAを直接アタッチ**してメタデータ経由で認証。

---

#### **② 権限の借用（Service Account User）**

「強い権限を人に渡さず、役割（SA）を貸し出す」高度な管理術です。

```text
  [ 開発者 (人間) ]
          |
     (権限：SA User)  <--- 「その名札を使っていいよ」という許可
          |
   [ 強い権限を持つ SA ]
          |
     (権限：Project Editor 等)
          |
   [ リソース作成タスク ]

```

* **論点:** 開発者自身に強い権限を与えずに、**「強いSAを名乗ってVMを作る権利」**だけを与える（最小権限の原則）。

---

#### **③ プロジェクトを跨ぐ（Cross-Project）アクセス**

「家主が誰を家に入れるか決める」の原則。

```text
 [ プロジェクト A (自分) ]            [ プロジェクト B (相手) ]
          |                                    |
  [ App Engine SA ] -------------------→ [ BigQuery Dataset ]
          |                                    |
          |                             ★【相手側のIAM】で設定
          |                             "SA_A@proj-A を
          |                              Viewerとして許可"

```

* **論点:** 別プロジェクトのリソースを触るなら、**「リソースがある側」のIAM**でSAを招待する。

---

### 💡 コンセプト重視の「反射メモ（SA発展編）」

| シナリオ | 解決策（キーワード） |
| --- | --- |
| **デフォルト設定を避けたい** | **カスタムSA** を新規作成（Defaultは無効化推奨） |
| **GCPの外からアクセスしたい** | **JSON Key** を発行しダウンロード（最終手段） |
| **誰がSAを使ったか知りたい** | **Service Account Usage** 監査ログを確認 |
| **一時的に権限を渡したい** | **Service Account Token Creator** で短期間トークン発行 |

#### **⚠️ 「非推奨」なキーワード（毒の見分け方）**

* **「Default Compute Service Account に権限追加」** ➔ 影響範囲が広すぎるため、**カスタムSA**を作るのが正解。
* **「全エンジニアに Service Account Admin 権限」** ➔ 鍵の作成・削除が自由にできてしまうため、**最小権限（SA User等）**に絞るのが正解。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「プログラムに権限を与えるなら、**専用のカスタムSA** を用意しろ。
> デフォルト設定は卒業だ。
> 人に権限を貸すときは **SA User** ロール。
> 別のプロジェクトに手を伸ばすなら、**相手側の門番（IAM）** に名前を記せ。
> **SA ＝ 最小化されたプログラムの身分証**。
> これを整えることが、セキュアなインフラの絶対条件だ。」

---


# Storage クラスとロケーションの「コスト・速度」ハック

```text
 【 地理的範囲 】          【 費用感 】        【 特徴 】
 
 ① Regional (単一)  --->   1.0x (基準)  --->  ★正解。特定地域（ボストン）から
                                             のみアクセスなら、これが最安。
                                            
 ② Dual-Regional   --->   約 2.0x      --->  2つのリージョンに複製。
                                             片方が死んでもOKだが、保存料が高い。
                                            
 ③ Multi-Regional  --->   約 2.0x+     --->  大陸全土に複製。
                                             世界中から見るなら良いが、高い。

```

---

### 🧠 なぜ Dual-Regional ではないのか？（3つの理由）

1. **要件が「ボストン（米国東部）」に特化している**:
* チームがボストンに限定されているなら、その近く（例：`us-east1`）の **Regional** に置くのが最も低レイテンシかつ低コストです。Dual にしてわざわざ遠く（例：アイオワなど）にコピーを持っておく必要性が、今回の「コスト最小化」という命題にはありません。


2. **「可用性」よりも「コスト」が優先**:
* もちろん Dual-Regional の方が「リージョン障害」に強いですが、その分**ストレージ料金がほぼ倍**になります。問題文に「最高レベルの可用性が必要」とは書かれておらず、代わりに「minimal costs」と強調されているため、Regional が正解となります。


3. **Standard クラスとの組み合わせ**:
* 「継続的にアクセス（processes datasets continuously）」する場合、Standard クラスを選ぶ必要があります。**「Standard × Regional」** が、頻繁なアクセスにおける GCP の最安構成です。



---

### 💡 コンセプト重視の「反射メモ」

* **特定の場所から頻繁にアクセス** ➔ **Regional + Standard** (最速・最安)。
* **「minimal costs」がキーワード** ➔ 複製コストがかかる **Dual / Multi は「毒」**。
* **リージョンを跨ぐデータ転送料金** ➔ Dual/Multi は内部で複製を作るため、その分のコストも隠れて発生します。

#### **⚠️ 毒（誤答）の見分け方**

* **「Dual-Regional + Nearline」** ➔ Dual で保存料を上げつつ、Nearline で取り出し料も上げるという「コスト的に最悪の組み合わせ」なので、迷わず捨てて OK です。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「ボストンのチームが毎日使うデータ？
> ならば **Regional（近場）** に **Standard（標準）** で置け。
> **Dual-Regional** は保険料（保存料）が高い。
> 『コスト最小』と言われたら、余計なコピーは作るな。
> **特定地域の頻繁なアクセス ＝ Regional ＋ Standard**。
> これがクラウドの『持たない経営』だ。」

---

# 🏗️ Storage Class 決定マトリックス（AA版）

```text
 【 クラス名 】      【 アクセス頻度 】     【 最低保持期間 】   【 コスト構造 】
 
 1. Standard        毎日・常に          なし              保存料：高 / 取出料：無料
 
 2. Nearline        月1回以下           30日              保存料：中 / 取出料：安
 
 3. Coldline        年1回以下           90日              保存料：安 / 取出料：高
 
 4. Archive         数年に1回           365日             保存料：激安 / 取出料：激高

```

---

### 🧠 試験に出る 3つの重要論点（型）

#### **① ライフサイクル管理 (Lifecycle Management)**

* **論点:** 「30日経ったら Nearline へ、90日経ったら削除したい」
* **ハック:** 手動やスクリプトではなく、**Lifecycle Management ポリシー**を設定するのが正解。
* **反射メモ:** 期間によるクラス変更 ＝ **Lifecycle Management**。

#### **② 取り出しコストの罠 (Retrieval Cost)**

* **論点:** 「費用を抑えるために、毎日分析するデータを Coldline に入れた」
* **ハック:** これは**間違い（毒）**。
* **理由:** 保存料は安くても、頻繁に「取り出し（Retrieval）」を行うと、Standard よりもトータルの請求額が高くなります。
* **反射メモ:** **頻繁なアクセス ＝ Standard**（トータルで最安）。

#### **③ オブジェクトのバージョニング (Versioning)**

* **論点:** 「誤って上書き・削除しても復元できるようにしたい」
* **ハック:** **Object Versioning** を有効にする。
* **注意:** バージョンが増えるごとに保存料も増えるため、これも Lifecycle で「古いバージョンは10日で消す」などの組み合わせが出ます。

---

### 💡 コンセプト重視の「反射メモ（Storage編）」

| キーワード | 選ぶべきクラス / 機能 |
| --- | --- |
| **コンプライアンス（5年保存）** | **Archive** クラス |
| **バックアップ（月1確認）** | **Nearline** クラス |
| **データの自動移動** | **Lifecycle Management** |
| **間違えて消すのが怖い** | **Object Versioning** |

#### **⚠️ 毒（誤答）の見分け方**

* **「数TBのログを Standard で永久保存」** ➔ コスト高のため「毒」。Archive へ移動させるのが正解。
* **「毎日更新される DB バックアップを Archive に保存」** ➔ 365日以内の削除・更新は「365日分の保存料」をフルで取られるため、Archive は「毒」。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「データの置き場所（クラス）に迷ったら、
> **『いつ、何回、そのデータを見るか？』** を考えろ。
> 毎日見るなら **Standard**。
> たまに見るなら **Nearline/Coldline**。
> 忘れた頃に見るなら **Archive** だ。
> クラスの移動は **Lifecycle** で自動化。
> **期間 ＋ 頻度 ＝ クラス選定**。
> これがコスト最適化の黄金比だ。」

---


# 🏗️ DB移行の決定マトリックス（AA版）

移行先の選定は、以下のフローチャート（脳内パス）で決定します。

```text
 【 今のDB 】              【 移行の目的 】                【 移行先 (正解) 】
      |
  RDB (SQL) --------+----▶ 互換性重視 (そのまま) -------▶ [ Cloud SQL ]
 (PostgreSQL/MySQL/ |      ※小〜中規模。
  SQL Server)       |
                    +----▶ 限界突破 (グローバル/巨額) ---▶ [ Cloud Spanner ]
                           ※水平スケーリングが必要。
      |
  NoSQL -----------+----▶ ドキュメント型 (柔軟性) ------▶ [ Firestore ]
 (MongoDB/Datastore)|      ※旧 Datastore。
                    |
                    +----▶ 低レイテンシ (巨大Key-Value) -▶ [ Cloud Bigtable ]
                           ※分析・IoT・広告配信。
      |
  データ分析 -------+----▶ ウェアハウス (SQL分析) ------▶ [ BigQuery ]
                           ※トランザクション(ACID)は捨てる。

```

---

### 🧠 試験に出る 4つの移行論点（ハック）

#### **① Cloud SQL vs Cloud Spanner**

* **論点:** どちらもリレーショナルDB(SQL)だが、どう使い分ける？
* **ハック:** * **Cloud SQL:** 「今のコードを変えたくない」「単一リージョンで十分」ならこれ。
* **Cloud Spanner:** 「世界中からアクセス」「ダウンタイムなしの拡張」「強整合性」ならこれ。



#### **② 移行の手間 (Minimal Changes)**

* **論点:** 既存の PostgreSQL / MySQL アプリを移行する。
* **ハック:** **Cloud SQL** 一択。
* **毒:** Spanner や BigQuery は独自の作法があるため、アプリの書き換え（コード変更）が発生するので「毒」。

#### **③ 分析用途への移行**

* **論点:** 「大量のログデータを高速に検索・集計したい」
* **ハック:** **BigQuery**。
* **注意:** 「トランザクション（銀行振込のような処理）」という言葉があったら、BigQueryは「毒」になります。

#### **④ 大規模NoSQL (Bigtable)**

* **論点:** 「数ミリ秒のレスポンス」「ペタバイト級」「時系列データ」
* **ハック:** **Cloud Bigtable**。
* **注意:** Bigtableは「SQL」が使えません。

---

### 💡 コンセプト重視の「反射メモ（DB移行編）」

| 移行元のキーワード | 移行先の決定打 |
| --- | --- |
| **PostgreSQL / MySQL / ACID** | **Cloud SQL** |
| **Global / Horizontal Scaling** | **Cloud Spanner** |
| **Analytical / Data Warehouse** | **BigQuery** |
| **Minimal Changes（最小変更）** | **Cloud SQL** (同種エンジン) |

#### **⚠️ 毒（誤答）の見分け方**

* **「オンプレMySQLを BigQuery に移行してアプリを動かす」** ➔ アプリはSQLのトランザクションを期待しているので、BigQueryでは動かず「毒」。
* **「小規模な社内ツールに Cloud Spanner を使う」** ➔ コスト高かつオーバースペックなので、試験的には「毒」。Cloud SQLが正解。

---

### 🗣️ 音読用：脳内同期スクリプト

> 「DB をクラウドへ持っていきたい？
> ならば **『今のエンジンと同じものがあるか』** を探せ。
> PostgreSQL なら **Cloud SQL**。
> そのまま移せば、コードを直す手間はいらない。
> もし世界最強を目指すなら **Spanner**、
> データを分析し尽くすなら **BigQuery** だ。
> **移行 ＋ 最小変更 ＝ Cloud SQL**。
> 楽をして、確実に動かせ。」

---
