# ⚡️ Exam 5: ハックリスト (Q1-Q50)

### 🌐 ネットワーク・データ転送 (Q1-Q10)

**Q1：35GBの巨大ファイルを1Gbps回線で「最速」アップロード**

* **キーワード：** `35 GB file`, `1 Gbps connection`, `maximize upload speed`.
* **正解：** **`gsutil`** で **Parallel composite uploads** を有効にする。
* **ハック：** コンソール(A)は並列処理ができないため遅い。巨大ファイルを分割して並列で投げる `composite uploads` が最速。

**Q2：オートスケーリングで「インスタンスが増えすぎる」のを防ぎたい**

* **キーワード：** `adds more instances than necessary`, `VM takes two minutes to ready`.
* **正解：** **Health Check の Initial Delay** を（2分＝200秒に）増やす。
* **ハック：** 起動に時間がかかるVMを「死んでいる」と誤認して次々追加されるのを防ぐため、待機時間(Initial Delay)を伸ばすのが薬。

**Q3：2時間の夜間バッチ処理を最低コストで。**

* **キーワード：** `nightly batch-processing`, `2 hours to complete`, `reduce cost`.
* **正解：** **Compute Engine Preemptible VM**。
* **ハック：** 24時間以内に終わるバッチなら、最大91%オフの Preemptible が最強。GKE(A, B)は管理コストがかさむ。

**Q4：メンテナンス中も停止させず、クラッシュ時は自動復旧させたい**

* **キーワード：** `available during maintenance`, `crash... automatically restart`.
* **正解：** **Automatic Restart: ON** ＋ **On-host maintenance: Migrate**.
* **ハック：** メンテ時は「別の箱へ引越し(Migrate)」させ、死んだら「勝手に再起動」させる設定のセット。

**Q5：Prod(本番)とTest(検証)のサブネット。同一VPCで内部通信。**

* **キーワード：** `different subnets`, `communicate using Internal IPs`, `no additional routing`.
* **正解：** **単一の Custom VPC** 内に **2つの Subnet** を作成。
* **ハック：** VPCが同じなら、サブネットを跨いでもデフォルトで「内部IP」で会話できる。追加設定は不要。

**Q6：共有プロジェクトで、他チームによる「うっかり削除」を防止**

* **キーワード：** `unintentionally bring offline`, `shared with multiple departments`.
* **正解：** **Deletion protection** (削除保護) を有効にする。
* **ハック：** Exam 4のQ24と同じ。物理的に「削除ボタン」を無効化するのが確実。

**Q7：ローカル（Ubuntu）で Cloud Datastore をシミュレートしてテスト**

* **キーワード：** `Ubuntu`, `simulate Cloud Datastore locally`.
* **正解：** **`apt-get install`** で **`google-cloud-sdk-datastore-emulator`** を導入。
* **ハック：** OSのパッケージ管理(apt)を使っているなら、エミュレータも `apt` で入れるのが一貫性。

**Q8：K8s：YAMLにDBパスワードが平文で書いてある。修正案は？**

* **キーワード：** `DB_PASSWORD value: "securePass123"`, `security best practices`.
* **正解：** **Secret オブジェクト** に保存し、YAMLから参照する。
* **ハック：** 「パスワード」➔「Secret」。ConfigMap(C)は機密でない設定用。イメージ内(A)に埋めるのは論外。

**Q9：組織階層（フォルダ・PJT）の「全体図」だけを特定グループに見せたい**

* **キーワード：** `view the full organizational structure`, `minimal permissions`.
* **正解：** Google Group に対して **`roles/browser`** ロールを付与。
* **ハック：** 組織を眺める（閲覧する）ための専用ロール ＝ `browser`。

**Q10：デプロイ先（プロジェクト）を間違えた。原因を調査したい。**

* **キーワード：** `didn't happen on the correct project`, `investigate`.
* **正解：** **`gcloud config list`** で現在の設定（Active Project）を確認。
* **ハック：** コマンドラインでの操作ミスは、自分の「今の設定」を確認するのが基本。

---

### 💻 認証・インフラ管理 (Q11-Q20)

**Q11：既存の Active Directory SSO を Google でも使いたい**

* **キーワード：** `existing SSO provider`, `authenticate using AcmeSolutions' SSO`.
* **正解：** **Third-party IDP (AD)** ＋ **Google as Service Provider**.
* **ハック：** 「自分たちのADでログインさせ、Googleを使わせる」なら、ADが親(IDP)、Googleが子(Service Provider)。

**Q12：App Engine：バグがある新版を「即座に」旧版へ戻したい**

* **キーワード：** `critical bug`, `quickly revert to previous stable version`.
* **正解：** **Versions ページ** で **100% のトラフィックを旧版へ向ける**。
* **ハック：** デプロイし直すのではなく、トラフィックの蛇口（Split）をひねって戻すのが最速。

**Q13：財務データ：四半期に1回（3ヶ月ごと）アクセス。コスト最小。**

* **キーワード：** `archived datasets`, `once every quarter`, `cost efficiency`.
* **正解：** **Coldline Storage**。
* **ハック：** 罠：Archive(A)は年1回未満。月1回ならNearline。その中間（3ヶ月）なら **Coldline** が薬。

**Q14：GKE：AIモデル（中断不可）の実行に GPU が必要。コスト最小。**

* **キーワード：** `AI models`, `non-restartable tasks`, `GPUs`, `cost-efficient`.
* **正解：** **Node auto-provisioning** (NAP) を有効にする。
* **ハック：** 「必要な時だけGPUノードを自動で作り、終わったら消す」のが NAP。Preemptible(C)は中断されるのでNG。

**Q15：本番(Prod)と開発(Dev)を「絶対に」ネットワーク分離したい。Google推奨。**

* **キーワード：** `no network routes between environments`, `best practices`.
* **正解：** **環境ごとにプロジェクトを分ける**。
* **ハック：** GCPでの「絶対分離」＝ プロジェクト分離。VPCを分ける(B, C)より確実。

**Q16：社内ツール：営業時間外はコストを「ゼロ」にしたい。コンテナ。**

* **キーワード：** `business hours only`, `no charges when not in use`.
* **正解：** **Cloud Run (fully managed)** ＋ **Min instances: 0**。
* **ハック：** 誰もいない時にインスタンスが消えて0円になるのは Cloud Run だけの特技。

**Q17：個人カード払いのPJTを、会社の請求アカウントへ「正式に」移したい**

* **キーワード：** `personal credit card`, `ensure charged to corporate billing account`.
* **正解：** プロジェクトの **Billing Account を変更** する。
* **ハック：** PJTの設定画面で、支払い紐付け先をポチッと変えるだけ。

**Q18：GCS上のPDFリンク：ダウンロードされずに「ブラウザで開く」ようにしたい**

* **キーワード：** `open directly in browser`, `without triggering download prompt`.
* **正解：** メタデータの **Content-Type** を **`application/pdf`** に設定。
* **ハック：** ブラウザに「これはPDFだよ」と教えれば、最近のブラウザは勝手に開いてくれる。

**Q19：分析者：BQのクエリはさせたいが、「削除」はさせたくない。Google推奨。**

* **キーワード：** `query datasets`, `prevent accidentally deleting`, `best practices`.
* **正解：** **Custom Role** (削除権限抜き) を作成 ➔ **Group** に付与。
* **ハック：** `dataEditor` (B) は削除もできる。必要な「閲覧＋クエリ」だけのカスタムロール ＋ グループ管理が最強。

**Q20：社内 AD のユーザーを Google Cloud へ自動同期したい**

* **キーワード：** `Active Directory as primary source of truth`, `complete control`.
* **正解：** **Google Cloud Directory Sync (GCDS)**。
* **ハック：** AD ➔ GCP の同期ツールといえば GCDS。覚えゲー。

---

### 📦 運用・高度な設定 (Q21-Q30)

**Q21：VM：2 vCPU / 4GB を「メモリだけ 8GB」に上げたい。**

* **キーワード：** `out of memory`, `upgrade to 8 GB`, `best approach`.
* **正解：** **VMを停止 ➔ メモリを 8GB に変更 ➔ 起動**。
* **ハック：** スペック変更には一度「停止」が必要。Live migration(A)はメンテ用でスペック変更はできない。

**Q22：パートナー企業(LearnAI)に、こちらのBQデータを読ませたい。**

* **キーワード：** `Partner company requires access to your BQ dataset`.
* **正解：** **相手側のSA** を作成してもらい、こちらのデータセットに **アクセス権** を付与。
* **ハック：** 「鍵を渡す(A)」のではなく「相手を招待する」のが正しい共有。

**Q23：PJT横断で「SAの作成・管理」をする人への最小権限。**

* **キーワード：** `creating and managing all service accounts`, `minimum necessary`.
* **正解：** **`roles/iam.serviceAccountAdmin`**。
* **ハック：** 職務名そのままのロール。`serviceAccountUser` (C) は「使う」権限であり「作成」はできない。

**Q24：オンプレDBへの接続。IPが変わってもアプリを直したくない。**

* **キーワード：** `avoid reconfiguring every time database IP changes`.
* **正解：** **Cloud DNS Private Zone** で DNS名(db.localなど)を使う。
* **ハック：** アプリには名前で呼ばせ、IPが変わったらDNSの設定だけを直す。

**Q25：誰が「機密データ」を見る権限を持っているか特定したい。**

* **キーワード：** `identify who has permission to view sensitive data`.
* **正解：** **IAM 権限のレビュー**。
* **ハック：** ログ(A)は「誰が見たか」の結果。権限設定そのものを見るのが薬。

**Q26：Cloud Run (Anthos)：一部のユーザーで新版をテスト（カナリア展開）。**

* **キーワード：** `Cloud Run for Anthos`, `canary deployment`, `percentage of users`.
* **正解：** **新しい Revision** を作成 ➔ **Traffic Splitting**。
* **ハック：** 新サービス(A)にする必要はない。同じサービス内の「新旧リビジョン」で分ける。

**Q27：リアルタイム・クイズアプリ。大量の UDP パケットを処理。外部公開。**

* **キーワード：** `send UDP packets`, `real time`, `single IP address`, `Internet`.
* **正解：** **External Network Load Balancer**.
* **ハック：** UDP 対応 ＋ 外部公開 ➔ Network LB (L4)。HTTP LB(C)は UDP 非対応。

**Q28：外部監査人に「誰がGCSに触ったか」のログを見せたい。**

* **キーワード：** `who accessed the stored images`, `access logs`.
* **正解：** **Data Access Logs** を有効化 ➔ **ログビューア** でフィルタ。
* **ハック：** 罠：デフォルトでこのログは出ない。明示的に「Data Access」をONにする必要がある。

**Q29：MIG内の1台が応答不能。サービスを止めずに交換したい。**

* **キーワード：** `process no longer responding`, `replace this unresponsive VM`.
* **正解：** **`recreate-instances`** コマンド。
* **ハック：** 死にかけの個体だけを「作り直す」ピンポイントの外科手術。

**Q30：Workspace 管理下の組織が10倍に増える。スケーラブルな認証。**

* **キーワード：** `handle tenfold growth`, `Google Workspace`, `smoothly`.
* **正解：** **Cloud Identity と Workspace の連携（Federation）**。
* **ハック：** 既に使っている Workspace を親にして Identity を束ねるのが一番自然。

---

### 💡 このセクションのポイント

「 **Google推奨（Best Practices）** 」では、**「自作（スクリプト・手動）」よりも「マネージド機能（Lifecycle, Auto-scaling, IAM Predefined）」** を選ぶのが王道です。
