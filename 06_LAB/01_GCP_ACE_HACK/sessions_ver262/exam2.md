# ■ Google Cloud ACE Session 2：完全デフラグ版 (Q1-Q50)

#### **Q1: ログの外部SaaS転送**

* **【元の文】**: NebulaArcade wants to stream application logs into a third-party SaaS tool with as little export latency as possible.
* **【論点抽出】**
* **主体**: Cloud Loggingのログ
* **目的**: 外部SaaS（Datadog等）での一元監視
* **制約**: **最小遅延（Low Latency）** / ストリーミング


* **【コンセプト】**: リアルタイム転送 ➔ **Pub/Sub**。蓄積用のGCSやBigQueryはバッチ処理になるため「毒」。
* **【結論】**: **Log Sink ➔ Pub/Sub**

---


#### **Q2: 課金データの詳細分析**

* **【元の文】**: Finance team needs itemized visibility into monthly cloud spending across multiple projects to run advanced SQL queries in BigQuery.
* **【論点抽出】**
* **主体**: 請求先アカウントの課金データ
* **目的**: 詳細なSQL分析 / ダッシュボード作成
* **制約**: **自動化** / 詳細項目（Itemized）


* **【コンセプト】**: 課金分析のデファクト ➔ **BigQuery Export**。手動抽出やAPI開発は運用負荷が高いため「毒」。
* **【結論】**: **Cloud Billing ➔ BigQuery Export有効化**


---


#### **Q3: Cloud Runの起動遅延対策**

* **【元の文】**: Deploy version 3.4. Guarantee at least two instances are already running and idle so requests experience no cold starts.
* **【論点抽出】**
* **主体**: Cloud Runの新リビジョン(v3.4)
* **目的**: **コールドスタート防止**
* **制約**: 最小2インスタンスを常時稼働 / 低運用負荷


* **【コンセプト】**: **リビジョン単位**の最小インスタンス設定。サービス全体設定（B）は新旧混在時に新版が動かないリスクがあるため「毒」。
* **【結論】**: **Revision-level autoscaling ➔ min-instances = 2**


---


*
#### **Q4: グローバルな動画配信最適化**

* **【元の文】**: PulsePanda’s audience grown across North America, Europe, and SE Asia. Keep video start times snappy worldwide and scale smoothly.
* **【論点抽出】**
* **主体**: 北米・欧州・東南アジアのユーザー
* **目的**: 低レイテンシ（Snappy）/ グローバルスケーリング
* **制約**: **複数リージョン配備** / Google推奨手法


* **【コンセプト】**: 世界規模の負荷分散 ➔ **Global ALB**。物理的な距離短縮 ➔ **マルチリージョン配備**。
* **【結論】**: **Multi-region VM deployment + Global Application Load Balancer**


---


*
#### **Q5: GKEでのステートフルワークロード**

* **【元の文】**: Move database to GKE. Protect from data loss while ensuring enough nodes available when traffic spikes.
* **【論点抽出】**
* **主体**: データベース（PostgreSQL等）
* **目的**: データ損失防止 / ノードの自動拡張
* **制約**: 手動操作の削減（自動化）


* **【コンセプト】**: 永続性が必要なDB ➔ **StatefulSet**。ノード不足解消 ➔ **Cluster Autoscaler**。
* **【結論】**: **StatefulSet + Cluster Autoscaler**


---


#### **Q6: プロジェクトを跨ぐイメージ共有**

* **【元の文】**: GKE cluster in Project B needs to pull container images from Artifact Registry in Project A.
* **【論点抽出】**
* **主体**: プロジェクトA（AR）とプロジェクトB（GKE）
* **目的**: イメージのプル権限付与
* **制約**: IAMの最小権限


* **【コンセプト】**: **GKEノードのSA**に権限付与。JSONキー（C）は管理負荷があるため「毒」。
* **【結論】**: **Artifact Registry Reader (assigned to GKE service account)**


---


#### **Q7: Windows VMの初回ログイン**

* **【元の文】**: Ensure that your team can log in to the Windows VM via Remote Desktop Protocol (RDP).
* **【論点抽出】**
* **主体**: Windows VM
* **目的**: RDPでのログイン
* **制約**: 最も直接的なアプローチ


* **【コンセプト】**: Windows用の標準パスワード管理 ➔ **reset-windows-password**。
* **【結論】**: **gcloud compute reset-windows-password**


---


#### **Q8: オブジェクトのライフサイクル最適化**

* **【元の文】**: Compliance requires 3-year retention. Frequent access for 7 months, then audit-only (cheapest).
* **【論点抽出】**
* **主体**: 大量のドキュメント（GCS）
* **目的**: 3年保持 / 7ヶ月後にコスト削減
* **制約**: **最安（Cheapest）** / 低運用負荷


* **【コンセプト】**: 自動クラス変更 ➔ **Lifecycle Management**。7ヶ月後に安い **Coldline**。
* **【結論】**: **GCS Lifecycle Policy ➔ 7 months ➔ Coldline**


---


#### **Q9: App Engineのトラフィック分割**

* **【元の文】**: Deploy the new version of TaskMaster on App Engine. You want to roll out the new version to just 1% of users initially.
* **【論点抽出】**
* **主体**: App Engine上の新バージョン
* **目的**: カナリアリリース（1%のみ）
* **制約**: パフォーマンス監視


* **【コンセプト】**: App Engineの標準機能 ➔ **Traffic Splitting**。GKEへの移行（A）などはオーバースペックで「毒」。
* **【結論】**: **App Engine ➔ Traffic Splitting (1% to new version)**


---


#### **Q10: グローバル規模の強整合性DB**

* **【元の文】**: ChatterNest needs a managed database that supports automatic scaling, multi-region, and consistently low latency.
* **【論点抽出】**
* **主体**: SNSデータ（リレーショナル）
* **目的**: グローバル展開 / 自動スケーリング
* **制約**: **強整合性** / 低レイテンシ


* **【コンセプト】**: グローバル強整合性 ➔ **Cloud Spanner**。Cloud SQL（C）はリージョン内サービスのため「毒」。
* **【結論】**: **Cloud Spanner**


---


#### **Q11: 部門別の予算管理**

* **【元の文】**: Multiple product teams need to track their own spend, get budget alerts, and build dashboards in BigQuery.
* **【論点抽出】**
* **主体**: 複数のプロダクトチーム
* **目的**: 予算アラート / BigQueryでのカスタム分析
* **制約**: 運用負荷最小（ノーコード優先）


* **【コンセプト】**: 標準アラート ➔ **Budget threshold alerts**。標準連携 ➔ **BigQuery Export**。
* **【結論】**: **Budget threshold alerts + Cloud Billing export to BigQuery**


---


#### **Q12: 有効化済みAPIの確認**

* **【元の文】**: Produce a list of all the enabled Google Cloud Platform APIs for their GCP project.
* **【論点抽出】**
* **主体**: GCPプロジェクト
* **目的**: 有効なAPIのリスト化
* **制約**: gcloudコマンドを使用


* **【コンセプト】**: サービス一覧 ➔ **services list**。`--available`（B）は有効化されていないものも含むため「毒」。
* **【結論】**: **gcloud services list**



---

#### **Q13: GCSの変更イベント通知**

* **【元の文】**: Regulatory requirement: notified whenever any file is created, updated, or deleted. Minimal management.
* **【論点抽出】**
* **主体**: Production bucket
* **目的**: 全オブジェクト操作の通知
* **制約**: **確実な通知** / 最小管理


* **【コンセプト】**: ストレージイベント ➔ **Pub/Sub連携**。手動ログチェック（A）は遅延と漏れがあるため「毒」。
* **【結論】**: **Cloud Storage ➔ Pub/Sub notifications**



---


*
#### **Q14: GKEアプリのHTTPS公開**

* **【元の文】**: Expose SnapChirp's frontend application to the public, using HTTPS on a public IP address.
* **【論点抽出】**
* **主体**: GKEフロントエンド
* **目的**: HTTPSでの公開
* **制約**: 公開IP利用


* **【コンセプト】**: 標準的なL7公開 ➔ **Ingress**。ClusterIP（B）は内部専用のため「毒」。
* **【結論】**: **Service (NodePort) ➔ Ingress (Load Balancer)**


---


#### **Q15: 読み取り専用の監査権限**

* **【元の文】**: Auditor needs access to review all aspects of the project but should not make changes.
* **【論点抽出】**
* **主体**: 監査ユーザー
* **目的**: 全リソースのレビュー
* **制約**: **変更不可（View-only）**


* **【コンセプト】**: 標準的な閲覧者権限 ➔ **Project Viewer**。カスタムロール（A）は管理が煩雑になるため「毒」。
* **【結論】**: **Built-in IAM project Viewer role**



---


*
#### **Q16: カスタムイメージによる複製**

* **【元の文】**: Already has a custom image available. Need to create and deploy copies to scale effectively.
* **【論点抽出】**
* **主体**: 既存のカスタムイメージ
* **目的**: 大量デプロイ / スケーリング
* **制約**: 迅速な展開


* **【コンセプト】**: 金型（イメージ）から製品（インスタンス）を作る。スナップショットからの直接作成（B）は非効率なため「毒」。
* **【結論】**: **Create instances from that image**


---


#### **Q17: ローカルログの収集設定**

* **【元の文】**: Application writes logs to local disk. Need to investigate cause of errors.
* **【論点抽出】**
* **主体**: Compute Engine上のアプリ
* **目的**: ローカルログの調査
* **制約**: Cloud Loggingでの閲覧


* **【コンセプト】**: ログの吸い上げ ➔ **Logging Agent**。インストールしないとCloud Loggingには反映されないため「毒」。
* **【結論】**: **Install Cloud Logging Agent**


---


#### **Q18: プロジェクト間ストレージアクセス**

* **【元の文】**: VM in project A needs to write reports to a bucket in project B automatically.
* **【論点抽出】**
* **主体**: VMのサービスアカウント
* **目的**: 別プロジェクトのバケットへの自動書き込み
* **制約**: 最小ステップ


* **【コンセプト】**: **ターゲット側のバケット**でSAに権限付与。プロジェクト移動（A）は不要なため「毒」。
* **【結論】**: **Grant Storage Object Creator on the bucket to the VM Service Account**


---


#### **Q19: プロジェクト間のネットワーク共有**

* **【元の文】**: Two applications in separate projects and VPCs need to communicate.
* **【論点抽出】**
* **主体**: 2つの異なるプロジェクト
* **目的**: VPC間のセキュアな通信
* **制約**: 同一組織内


* **【コンセプト】**: 組織内ネットワークハブ ➔ **Shared VPC**。全インスタンスの作り直し（A）は非現実的なため「毒」。
* **【結論】**: **Shared VPC (Host/Service project)**



---


*
#### **Q20: GKEストレージコストの見積もり**

* **【元の文】**: Logistics tracking system on GKE. Requires high IOPs and disk snapshots for backups.
* **【論点抽出】**
* **主体**: GKEワークロード
* **目的**: **高IOPs** / バックアップ
* **制約**: 料金計算ツールでの見積もり


* **【コンセプト】**: 高速ディスク ➔ **Local SSD**。バックアップ ➔ **Persistent Disk + Snapshot**。
* **【結論】**: **Local SSD + Persistent Disk storage + Snapshot storage**



---


*
#### **Q21: Pod異常状態の調査**

* **【元の文】**: One of the pods is stuck in a PENDING state. Troubleshoot the issue.
* **【論点抽出】**
* **主体**: PENDING状態のPod
* **目的**: 原因特定
* **制約**: 次のアクション


* **【コンセプト】**: 詳細情報・イベントの確認 ➔ **kubectl describe**。
* **【結論】**: **kubectl describe pod <name>**


---




*
#### **Q22: OS Loginによるアクセス管理**

* **【元の文】**: Configure secure SSH access to a single VM for developers in the dev1 team.
* **【論点抽出】**
* **主体**: 特定のCompute Engineインスタンス
* **目的**: 安全なSSHアクセス
* **制約**: 特定チームのみ


* **【コンセプト】**: 鍵配布からの脱却 ➔ **OS Login**。共通鍵の使い回し（D）はセキュリティ上「毒」。
* **【結論】**: **enable-oslogin=true + compute.osLogin役割**


---




*
#### **Q23: 新規プロジェクトへのリソース配置**

* **【元の文】**: Launch a new VM, but the project hasn't been set up yet.
* **【論点抽出】**
* **主体**: 新規システム
* **目的**: プロジェクト作成からVM起動まで
* **制約**: 正しい手順


* **【コンセプト】**: 容器（Project）➔ 機能（API有効化）➔ 具（VM）の順。
* **【結論】**: **Create project ➔ Enable Compute Engine API ➔ Create instance**


---



*
#### **Q24: 長時間バッチとコスト最適化**

* **【元の文】**: Task takes 40 hours. Must restart if interrupted. Lowest cost possible.
* **【論点抽出】**
* **主体**: 40時間バッチ
* **目的**: 確実な完走（リスタート負荷大）
* **制約**: **24時間で強制終了されるPreemptibleは使えない**


* **【コンセプト】**: 完走重視 ➔ **Standard VMをStart/Stop**。安さだけでPreemptible（A, B）を選ぶのは、40時間完走できないため「毒」。
* **【結論】**: **Standard VM ➔ Start and Stop as needed**


---


#### **Q25: IoT高頻度データストレージ**

* **【元の文】**: Thousands of events per hour. Consistent data based on timestamp, atomic updates.
* **【論点抽出】**
* **主体**: ドローンのセンサーデータ
* **目的**: 高頻度書き込み / タイムスタンプ検索
* **制約**: アトミックな更新


* **【コンセプト】**: 大規模時系列 ➔ **Cloud Bigtable**。ファイル保存（A, B）は検索性が悪いため「毒」。
* **【結論】**: **Cloud Bigtable (Row key based on timestamp)**


---


#### **Q26: バッチ処理の自動リトライ設定**

* **【元の文】**: Overnight reconciliation at 2:15 AM. Batch workload. Automatically retry if fails.
* **【論点抽出】**
* **主体**: 深夜バッチ
* **目的**: 定時実行 / 異常時の自動リトライ
* **制約**: 運用負荷最小


* **【コンセプト】**: バッチ専用 ➔ **Cloud Run Job**。HTTPサービスのCloud Run Service（B）はタイムアウト制限が強いためバッチには「毒」。
* **【結論】**: **Cloud Run Job + Cloud Scheduler**


---


#### **Q27: DockerイメージのGKE展開**

* **【元の文】**: Package app into a Docker image. Deploy this as a workload on GKE.
* **【論点抽出】**
* **主体**: Dockerイメージ
* **目的**: GKEへのデプロイ
* **制約**: 推奨手順


* **【コンセプト】**: 倉庫（Registry）へ置く。GCS（A, B）はコンテナリポジトリではないため「毒」。
* **【結論】**: **Container Registry ➔ Kubernetes Deployment**


---


*
#### **Q28: 組織内ポリシーの継承管理**

* **【元の文】**: Group resources with similar access settings together for easy management.
* **【論点抽出】**
* **主体**: 複数のプロジェクト
* **目的**: IAMの一括管理
* **制約**: 階層構造


* **【コンセプト】**: 共通設定の箱 ➔ **Folders**。ラベル（A）は「目印」にすぎないため「毒」。
* **【結論】**: **Folders**


---


#### **Q29: 公開IPなしでのSSH管理**

* **【元の文】**: Connect to Linux VMs securely via SSH without exposing public IP addresses.
* **【論点抽出】**
* **主体**: プライベートIPのみのVM群
* **目的**: 安全なSSH接続
* **制約**: 公開IP（Global IP）の禁止


* **【コンセプト】**: 踏み台不要のセキュアアクセス ➔ **IAP (Identity-Aware Proxy)**。
* **【結論】**: **IAP for TCP forwarding (SSH)**


---


*
#### **Q30: 複数プロジェクトの一元監視**

* **【元の文】**: Track metrics across three projects (Apollo, Luna, Nova) in a unified view.
* **【論点抽出】**
* **主体**: 3つのプロジェクト
* **目的**: CPU、メモリ、ディスク使用率の一元的な可視化
* **制約**: 最も効率的な設定


* **【コンセプト】**: 複数プロジェクト統合 ➔ **Monitoring Workspace**。
* **【結論】**: **Monitoring Workspace に他プロジェクトを追加**


---


*
#### **Q31: ワークロード別のノードプール最適化**

* **【元の文】**: Image processing (High CPU) vs Routine tasks. Keep costs down while maintaining performance.
* **【論点抽出】**
* **主体**: 異なるリソース要求を持つアプリ群
* **目的**: コスト最適化
* **制約**: 性能維持


* **【コンセプト】**: 適材適所 ➔ **Node Poolの分離**。高CPUにはCompute-optimized。
* **【結論】**: **Compute-optimized node pool + General-purpose node pool**


---


#### **Q32: 高可用性VPNの設定**

* **【元の文】**: Secure VPN between VPC and data center. Dynamic routing, no extra tunnels during failover.
* **【論点抽出】**
* **主体**: 新規VPCと外部データセンター間
* **目的**: 高可用性（HA）な接続
* **制約**: **動的ルーティング（BGP）** / 指定IPレンジ


* **【コンセプト】**: HA VPN ➔ **Cloud Router (BGP)**。
* **【結論】**: **Custom mode VPC + Cloud Router BGP routes + Active-passive routing**



---

*
#### **Q33: VM上のアプリ認証（Best Practice）**

* **【元の文】**: App on VM needs access to Google services. Minimal changes, Google-recommended.
* **【論点抽出】**
* **主体**: VM上のアプリ
* **目的**: Googleサービスへの認証
* **制約**: 鍵ファイルを置かない認証


* **【コンセプト】**: 権限の委譲 ➔ **VMのサービスアカウントに適切な権限を付与**。
* **【結論】**: **Assign appropriate access to the VM's service account**


---


#### **Q34: BigQueryデータ更新のデバッグ**

* **【元の文】**: Nightly summary table recalculation failed, charts not displaying. Investigate.
* **【論点抽出】**
* **主体**: 夜間のBigQueryジョブ
* **目的**: 失敗原因の特定
* **制約**: 直接的な調査


* **【コンセプト】**: ジョブ履歴の確認 ➔ **BigQuery UIでジョブ履歴を確認**。
* **【結論】**: **Use the BigQuery interface to review the nightly job**


---


#### **Q35: 世界規模のリレーショナルデータ管理**

* **【元の文】**: Global e-learning. Track progress. Consistent performance worldwide with simple management.
* **【論点抽出】**
* **主体**: グローバルユーザーの進捗データ
* **目的**: 世界規模で一定のパフォーマンス（Consistent）
* **制約**: リレーショナル（SQL）


* **【コンセプト】**: 世界規模×SQL×強整合性 ➔ **Cloud Spanner**。
* **【結論】**: **Cloud Spanner**


---


#### **Q36: gcloudプロキシ認証情報の保護**

* **【元の文】**: Prevent proxy credentials from being logged in CLI logs.
* **【論点抽出】**
* **主体**: gcloud CLI設定
* **目的**: 認証情報の秘匿
* **制約**: ログへの記録防止


* **【コンセプト】**: 設定ファイルに書かない ➔ **環境変数 (CLOUDSDK_PROXY_...) を使う**。
* **【結論】**: **Set CLOUDSDK_PROXY properties using environment variables**


---


#### **Q37: GKEのコスト・可用性ミックス**

* **【元の文】**: Recommendation engine (fault-tolerant) vs Order processing (must be available).
* **【論点抽出】**
* **主体**: 異なる重要度のGKEワークロード
* **目的**: コスト効率化
* **制約**: 可用性の確保


* **【コンセプト】**: ワークロードに応じたVM ➔ **注文用(Standard VM) と 推奨用(Spot VM) でノードプールを分ける**。
* **【結論】**: **Separate node pools for Spot and Standard VMs**


---


#### **Q38: サーバーレスでのカナリアテスト**

* **【元の文】**: Test new backend version with a small % of users before full rollout. Serverless.
* **【論点抽出】**
* **主体**: Cloud Runアプリ
* **目的**: トラフィックの一部転送（カナリア）
* **制約**: サーバーレス環境


* **【コンセプト】**: トラフィック制御 ➔ **Cloud Run ➔ Gradual rollouts (Traffic splitting)**。
* **【結論】**: **Cloud Run ➔ Traffic splitting**


---


*
#### **Q39: OS脆弱性のスキャン**

* **【元の文】**: Visibility into potential vulnerabilities and other OS metadata for an instance.
* **【論点抽出】**
* **主体**: Compute Engineインスタンス
* **目的**: 脆弱性情報の可視化
* **制約**: セキュリティポリシー準拠


* **【コンセプト】**: OS情報の収集 ➔ **OS Config agent をインストール + VulnerabilityReportViewer 権限**。
* **【結論】**: **OS Config agent + osconfig.vulnerabilityReportViewer role**


---


#### **Q40: Cloud Runのリスク低減デプロイ**

* **【元の文】**: Minimize customers affected by potential outages during new revision deployment.
* **【論点抽出】**
* **主体**: Cloud Runの新リビジョン
* **目的**: デプロイリスクの最小化
* **制約**: 推奨プラクティス


* **【コンセプト】**: 安全な展開 ➔ **Gradually roll out + Traffic splitting**。
* **【結論】**: **Gradually roll out and split traffic**


---


#### **Q41: 予測不能な成長に対応するDB**

* **【元の文】**: Fitness app. Unpredictable user base. Scale seamlessly without significant configuration updates.
* **【論点抽出】**
* **主体**: 予測不能なユーザー数
* **目的**: 無停止・シームレスなスケール
* **制約**: リレーショナルデータ


* **【コンセプト】**: 水平スケール最強 ➔ **Cloud Spanner**。
* **【結論】**: **Cloud Spanner**


---


*
#### **Q42: Google垢なし業者へのSSH提供**

* **【元の文】**: External contractor needs SSH access but does not have a Google account.
* **【論点抽出】**
* **主体**: 外部請負業者
* **目的**: インスタンスへのSSHメンテナンス
* **制約**: Googleアカウントなし


* **【コンセプト】**: 公開鍵の直接登録 ➔ **業者の公開鍵を受け取り、手動でVMメタデータに追加する**。
* **【結論】**: **Add contractor's public key to the instance metadata**


---


*
#### **Q43: ファイアウォール変更の監視**

* **【元の文】**: Monitor any unexpected changes to firewall rules and creation of new VMs. Straightforward.
* **【論点抽出】**
* **主体**: セキュリティ監査
* **目的**: FWやVM変更の即時把握
* **制約**: シンプルな構成


* **【コンセプト】**: ログからのアラート ➔ **Cloud Logging でログベースの指標を作成し、アラートを設定**。
* **【結論】**: **Log-based metrics + Monitoring alerts**



---

#### **Q44: L4でのIPアドレス保持**

* **【元の文】**: Application on port 389 needs to ensure original IP address of clients is preserved.
* **【論点抽出】**
* **主体**: 金融系TCPアプリ
* **目的**: **クライアントIPの保持（透過性）**
* **制約**: インターネット公開


* **【コンセプト】**: パススルー型（L4） ➔ **External Network Load Balancer**。Proxy型（L7）はIPを書き換えるため「毒」。
* **【結論】**: **External TCP Network Load Balancer**



---

#### **Q45: 最小権限でのBigQueryアクセス**

* **【元の文】**: VM in Project A needs access to BigQuery in Project B. Best practices.
* **【論点抽出】**
* **主体**: プロジェクトを跨ぐサービスアカウント
* **目的**: データセットへのアクセス
* **制約**: 最小権限の原則


* **【コンセプト】**: 必要な権限のみ付与 ➔ **Project Bで、SAに bigquery.dataViewer を付与**。
* **【結論】**: **Grant bigquery.dataViewer role in the destination project**


---


#### **Q46: サブネットのIP拡張**

* **【元の文】**: Subnetwork has no available private IP addresses. Add new VMs with minimum steps.
* **【論点抽出】**
* **主体**: IPが枯渇した既存サブネット
* **目的**: IPレンジの拡張
* **制約**: 最小ステップ


* **【コンセプト】**: 箱を広げる ➔ **Modify subnet range**。VPCピアリングなどは工数が多いため「毒」。
* **【結論】**: **Modify the existing subnet range**


---


#### **Q47: gcloudのデフォルトゾーン設定**

* **【元の文】**: Avoid manually specifying the zone every time you run a gcloud command.
* **【論点抽出】**
* **主体**: gcloud CLI
* **目的**: デフォルト値の固定
* **制約**: 効率化


* **【コンセプト】**: コンフィグ設定 ➔ **gcloud config set compute/zone**。
* **【結論】**: **gcloud config set compute/zone**


---


#### **Q48: Jenkinsの最速導入**

* **【元の文】**: Automate Jenkins installation as quickly and easily as possible.
* **【論点抽出】**
* **主体**: 開発用Jenkins
* **目的**: 迅速かつ簡単な導入
* **制約**: 自動化


* **【コンセプト】**: 出来合いのものを利用 ➔ **Google Cloud Marketplace**。
* **【結論】**: **Google Cloud Marketplace**


---


#### **Q49: 部門別請求の確実な分離**

* **【元の文】**: Ensure Marketing team is billed ONLY for their services for a new app.
* **【論点抽出】**
* **主体**: マーケティング部門
* **目的**: 請求の厳密な分離
* **制約**: 組織内管理


* **【コンセプト】**: 請求の箱（Account）を分ける ➔ **新プロジェクト作成 ➔ マーケティング専用の請求先アカウントに紐付け**。
* **【結論】**: **Link new project to a dedicated Marketing Billing Account**



---

#### **Q50: 大規模ライドシェアのDB**

* **【元の文】**: Ride-sharing app storing trip/fare data. High volume transactions worldwide. Analytics team needs SQL queries.
* **【論点抽出】**
* **主体**: 大規模・グローバルなトランザクションデータ
* **目的**: 高可用性 / 高頻度書き込み
* **制約**: **SQLクエリによる分析が必要**


* **【コンセプト】**: グローバル強整合性 ➔ **Cloud Spanner**。
* **【結論】**: **Multi-region Cloud Spanner**

---



