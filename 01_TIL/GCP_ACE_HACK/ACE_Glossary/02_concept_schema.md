# GCP ACE 用語集（概念スキーマ版：最終・圧縮完全）

## 0. 共通土台（まずここで全部解ける）

* API Enable（API有効化）

  * 定義：プロジェクトで対象APIをON
  * 一言：土俵づくり
  * ひっかけ：権限/コードの前にAPI無効で即死

* Region / Zone

  * 定義：Region=地理エリア、Zone=DC区画
  * 一言：県 / 市
  * ひっかけ：ゾーン冗長（複数Zone）、リージョン固定（Regional選択）

* Quota（クォータ）

  * 定義：利用上限（CPU/IP/API回数など）
  * 一言：上限ブレーカー
  * ひっかけ：作れない/増やせない→まずQuota

* Label / Tag

  * 定義：メタデータ（課金/管理）
  * 一言：経費の部門コード
  * ひっかけ：課金分析はラベル運用が最短

---

## 1. Resource Hierarchy（権限継承と境界）

* Organization

  * 一言：会社
  * ひっかけ：Org Policy/IAM一括の起点

* Folder

  * 一言：事業部
  * ひっかけ：部門ごと統制（ポリシー/ログ/課金）＝Folder

* Project

  * 一言：信頼境界（テナント）
  * ひっかけ：課金・IAM・API・Quotaの最小単位 / App Engineリージョン固定もここ

* Resource（VM/Bucket等）

  * 一言：現場の資産
  * ひっかけ：「どの階層で付与？」＝継承が本質

---

## 2. IAM（ACEの本丸：横断PJTの考え方）

### 2-1. 3点セット

* Principal（User/Group/SA）＝権限の受け手
* Role（Primitive/Predefined/Custom）＝権限セット
* Binding（どこに付けるか）＝Resource階層

一言：誰が × 何できる × どこで

### 2-2. Roleの使い分け

* Primitive（Owner/Editor/Viewer）

  * 一言：広すぎて毒
* Predefined（例：Storage Admin）

  * 一言：職務ロール
* Custom Role

  * 一言：最小権限の完成形
  * ひっかけ：「将来の権限拡大を防ぐ」→Custom

### 2-3. Service Account（SA）

* 定義：ロボ用の実行主体（VM/アプリ）
* 一言：ロボアカ
* ひっかけ：SAキー(JSON)配布は毒（漏洩リスク）

### 2-4. actAs（Service Account User）

* roles/iam.serviceAccountUser
* 一言：このロボを操縦していい許可
* ひっかけ：SAに権限があるのに実行できない → actAs不足

### 2-5. 横断プロジェクト（超重要）

原則：権限は「操作される側（リソース側）」で付与

例：PJT-AのSAでPJT-Bのリソース操作
→ PJT-Bで、PJT-AのSAに必要ロールを付与

### 2-6. 統制系

* IAM Conditions

  * 一言：条件付きドアロック（時間/IPなど）
* Org Policy

  * 一言：会社ルールで物理的に禁止（IAMより強い）
* Google Groups / Cloud Identity

  * 一言：付与は人ではなくグループ（ACE鉄則）

---

## 3. Billing / Cost（コスト問題の解像度）

* Billing Account

  * 一言：支払い口座
  * ひっかけ：作成/リンクに権限が要る

* Budget & Alert

  * 一言：使いすぎアラーム
  * ひっかけ：PJT別に管理したい→BudgetもPJT別に作る

* BigQueryコストの感覚

  * 量課金（スキャン） or 予約（flat-rate）
  * ひっかけ：爆増→クォータ/予約/クエリ設計へ誘導される

---

## 4. Network（LB / NAT / Peering / Shared VPCを完全固定）

### 4-1. 基本部品

* VPC（GCPはGlobal）

  * 一言：社内LANの仮想版

* Subnet（リージョン単位）

  * 一言：住所区画
  * ひっかけ：IP枯渇→/20→/18（拡張）

* Routes / Firewall

  * Route：道案内
  * FW：門番（ingress/egress、priority）
  * ひっかけ：最小ポート → deny all（低優先）＋必要だけallow（高優先）

### 4-2. Cloud NAT（受信できない）

* 定義：外部IPなしVMの外向き出口
* 一言：代表出口
* ひっかけ：受信公開は不可（LBと混同するな）

### 4-3. VPN / Interconnect

* VPN：仮想専用線（暗号トンネル）
* Interconnect：物理専用線（低遅延/大容量）
* 一言：仮想 / 物理

### 4-4. VPC Peering（VPC同士）

* 定義：VPC-AとVPC-Bをプライベート接続
* 一言：VPC直結
* ひっかけ：Transitive不可（A-B, B-CでもA-C不可）

### 4-5. Shared VPC（組織統制の答え）

* Host PJTでVPC集中管理し、Service PJTへ貸す
* 一言：ネットワーク本部制
* ひっかけ：複数PJTでNW共通化/統制 → Shared VPCが薬

---

## 5. Load Balancer 完全整理（L7/L4/内部/SSL終端）

### 5-1. 大原則

* L7 = HTTP/HTTPS
* L4 = TCP/UDP

### 5-2. HTTP(S) Load Balancer（Webの正解）

* 用途：Web / SSL終端 / URLルーティング / Cloud Armor / CDN
* 一言：Webならこれ
* ひっかけ：「SSL終端＋Web」→HTTP(S) LB

### 5-3. TCP Proxy / SSL Proxy（非HTTP）

* 用途：TCPアプリ / 非HTTP / SSL終端だけ欲しい
* 一言：Web以外

### 5-4. Internal LB（内部のみ）

* 用途：VPC内部のアプリ
* 一言：社内ロードバランサ

### 5-5. 混同防止の最短表

* Web + SSL終端 → HTTP(S) LB
* 内部だけ → Internal LB
* 外へ出るだけ → NAT（LBではない）

---

## 6. Compute（VM/MIG/スナップショット）

* Compute Engine（VM）

  * 一言：自由度最大（運用は自分）
  * ひっかけ：中断不可バッチ（26h）→VMが安全

* Instance Template

  * 一言：型紙
  * ひっかけ：MIGの前提

* MIG

  * 一言：VM群れ管理（自動増減/自己修復）
  * ひっかけ：ステートレス＋オートスケール＝MIG

* Spot / Preemptible

  * 一言：安いが消える
  * ひっかけ：やり直し不可/長時間 → 選ぶと死

* Snapshot / Scheduled snapshots

  * 一言：ディスクの写真
  * ひっかけ：毎日7日保持 → Scheduled snapshots

* Delete protection

  * 一言：削除ボタン無効化

---

## 7. Serverless（Run/Functions/Scheduler/Tasks）

* Cloud Run

  * 一言：コンテナのサーバーレス
  * ひっかけ：初回遅い→min-instances / 増えすぎ→max-instances

* Cloud Functions

  * 一言：接着剤（イベント駆動）
  * ひっかけ：GCSに置かれたら即 → Functions（または2nd genはEventarc）

* Cloud Scheduler

  * 一言：目覚まし（cron）
  * ひっかけ：イベント即時ではない

* Cloud Tasks

  * 一言：あとでやる箱（確実実行/リトライ/遅延）
  * ひっかけ：3秒制限回避/非同期化/確実再試行

* App Engine

  * 一言：PaaS（リージョン固定）
  * ひっかけ：リージョン変更不可→新PJT

---

## 8. Event（Pub/Sub / Eventarc：混乱ゾーンを固定）

### 8-1. まず結論

* Pub/Sub = キュー（メッセージバス）
* Eventarc = イベント配線（ルーティングして届ける）

### 8-2. 試験の判断軸

* 大量データ・保持・再試行・バッファ → Pub/Sub
* GCPサービスのイベントでRun/Functionsを起動 → Eventarc

### 8-3. 混乱ポイント（これだけ覚える）

* Functions 1st gen：GCS →（内部的に）Pub/Sub系の流れ
* Functions 2nd gen / Cloud Run：Eventarc経由が基本

---

## 9. GKE / コンテナ（差がつく中核）

* Cluster / Node pool

  * 一言：司令塔 / 同型ノード群
  * ひっかけ：安定版維持 → Node Auto-Upgrades

* Pod / Deployment / Service

  * 一言：実体 / 管理 / 入口
  * ひっかけ：Podは死ぬ前提、入口固定はService

* Pending / Running

  * 一言：席がないとPending
  * ひっかけ：主因はCPU/メモリ不足（スケジュール不可）

* HPA / VPA / Cluster Autoscaler

  * HPA：Pod数（数）
  * VPA：Podサイズ（体格）
  * CA：Node数（席数）
  * 一言：数 / サイズ / 物理席

* DaemonSet / StatefulSet

  * 一言：全員配布 / 個体管理
  * ひっかけ：監視→DaemonSet、DB→StatefulSet

* Namespace

  * 一言：クラスタ内の部署（論理区画）
  * ひっかけ：RBAC/分離の文脈で出る（完全隔離ではない）

* gVisor

  * 一言：怪しいコード隔離（最大隔離）
  * ひっかけ：「最大レベルの隔離」→gVisor

---

## 10. Storage & DB（選定問題の核）

* GCS Storage Class（Standard / Nearline / Coldline / Archive）

  * 一言：アクセス頻度で選ぶ
  * ひっかけ：最初頻繁→Standard、年1→Coldline、数年→Archive

* Lifecycle policy

  * 一言：自動お片付け（移行/削除）

* Signed URL

  * 一言：期限付き鍵（30分だけ）

* Persistent Disk

  * 一言：VMに刺すHDD（スナップショット対象）

* Cloud SQL

  * 一言：RDBを運用軽く
  * ひっかけ：最小変更で移行 → Cloud SQL

* Spanner

  * 一言：強整合×水平スケールRDB
  * ひっかけ：単調増加キーNG（ホットスポット）

* BigQuery

  * 一言：分析はBQ
  * ひっかけ：ログをSQL分析→Log Analytics/BQ

* Bigtable / Firestore

  * Bigtable：巨大・低遅延NoSQL（時系列/キー値）
  * Firestore：アプリ向けドキュメントDB

---

## 11. Ops（監視と監査）

* Cloud Monitoring

  * 一言：健康診断（ダッシュボード/アラート）
  * ひっかけ：複数PJT統合→Workspace（Monitoring account）

* Cloud Logging

  * 一言：記録係
  * ひっかけ：IAM変更履歴→Admin Activity logs

* Data Access audit logs

  * 一言：読む操作の監査（明示的にON必要）
  * ひっかけ：法令で「全読み取りログ」→これ

* Log Sink

  * 一言：ログ輸出（GCS/BQ/PubSub）

* Ops Agent

  * 一言：VM体内計測器（詳細メトリクス/ログ）

---

# 最短の試験判断フロー（これだけで8割拾う）

* Web公開 + SSL終端 → HTTP(S) LB
* 内部だけ → Internal LB / PSC（要件次第）
* 外へ出るだけ → NAT
* 別PJT操作 → リソース側でIAM付与（鍵配布は毒）
* 大量データ → Pub/Sub
* GCPイベントでRun起動 → Eventarc
* Pending → 席不足（CPU/メモリ/Node不足）

---

## 追加メモ（運用方針）

この「圧縮版」を基準にして、解像度が低い用語が出たら、その用語だけ別紙で深掘りして増築するのが一番強い（ファイルが太らない）。

---

