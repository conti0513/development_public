// --- [Topic 1: Array Object / show interface brief --json] ---
// 配列(Array)の中にオブジェクト({})を格納。NW機器1台 = 1つの { }
// NOTE: ES5/ES6 比較教材のため、意図的に var / function を使用する（ES6版は後半で併記）

// NW2
var deviceData2 = [
    { id: 'RT-02', type: 'Router',   Status: 'UP',   ip: '192.168.2.1' },
    { id: 'SW-03', type: 'Switch',   Status: 'Down', ip: '192.168.2.10' },
    { id: 'SW-04', type: 'Switch',   Status: 'UP',   ip: '192.168.2.11' },
    { id: 'FW-02', type: 'Firewall', Status: 'Down', ip: '10.1.0.1' }
];

// 配列全体をコンソールに表示
console.log('\n[Topic1]\n--- [arr deviceData2] ---');
console.log(deviceData2);


// --- [Topic 2: .filter() / ACL: permit status down] ---
// 条件(return)に合う要素だけを抽出して新バッファ(downDevices)に格納（非破壊）
var downDevices = deviceData2.filter(function (device) {
    return device.Status === 'Down';
});

console.log('\n[Topic2]\n--- [警報] 以下のデバイスが Down しています ---');
downDevices.forEach(function (device) {
    console.log('ALERT: ' + device.id + ' (' + device.ip + ')');
});


// --- [Topic 3: .forEach() / Logging Loop] ---
// リストを上から1行ずつなめる。文字列結合(+)でログを整形（ES5）
console.log('\n[Topic3]\n--- [System Log: Scan Started] ---');
downDevices.forEach(function (device) {
    var message = 'ALERT: ' + device.id + ' is ' + device.Status;
    console.log(message);
});

// --- [Topic 3-ES6: Arrow Function + Template Literal] ---
// function を消して => でつなぐ。テンプレート文字列でログを読みやすくする
downDevices.forEach(function (device) {
    // ES5版も残しつつ、ES6の書き方を併記するためコメントで比較する
});
downDevices.forEach((device) => {
    console.log(`ALERT: ${device.id} is ${device.Status}`);
});


// --- [Topic 4: String Method / Prefix Match (indexOf)] ---
// indexOf === 0 は、IPのプレフィックス(10.)が「先頭」にあるかの判定（ES5でよく見る）
console.log('\n[Topic4]\n--- [CRITICAL] External segment prefix check ---');
downDevices.forEach(function (device) {
    if (device.ip.indexOf('10.') === 0) {
        console.warn('CRITICAL: External segment error on ' + device.id);
    }
});

// --- [Topic 4-ES6: startsWith()] ---
// ES6なら startsWith が読みやすい（indexOf比較の教材として残す）
downDevices.forEach(function (device) {
    if (device.ip.startsWith && device.ip.startsWith('10.')) {
        console.warn('CRITICAL(ES6): External segment error on ' + device.id);
    }
});


// --- [Topic 5: データ存在チェック] ---
// 0件は異常（DB/取得処理の失敗を疑う）
if (deviceData2.length === 0) {
    console.error('\n[Topic5]\nERROR: Device list is empty!');
} else {
    console.log('\n[Topic5]\nDB Check: ' + deviceData2.length + ' devices loaded.');
}


// --- [Topic 6: .find() / Specific Target Search] ---
// ES6 で追加。ES5環境では polyfill が必要な場合あり
var targetIP = '192.168.2.11';
var targetDevice = deviceData2.find(function (device) {
    return device.ip === targetIP;
});

console.log('\n[Topic6]\n--- 特定IPの検索結果 ---');

if (targetDevice) {
    console.log('SUCCESS: Target found! -> ID: ' + targetDevice.id + ', Type: ' + targetDevice.type);
} else {
    // BUGFIX: targetIIP → targetIP
    console.warn('NOT FOUND: IP ' + targetIP + ' はリストに存在しません。');
}

// targetDevice が存在する場合のみ表示（ガード句）
if (targetDevice) {
    console.log('[FIND SUCCESS] Target found: ' + targetDevice.id);
}


// --- [Topic 7: .map() / Bulk Configuration] ---
// .map は元の配列を元に「新しい配列」を生成する（非破壊）
var vlanAddedList = deviceData2.map(function (device) {
    // スプレッド構文（...）は ES6。ES5比較のためES6要素としてここで使う
    return Object.assign({}, device, { vlan: 100 }); // ES5寄せ（spreadの代替）
});

// ES6版（スプレッド構文）も併記
var vlanAddedListES6 = deviceData2.map((device) => {
    return { ...device, vlan: 100 };
});

console.log('\n[Topic7]\n--- [VLAN Config Applied: ES5(Object.assign)] ---');
console.log(vlanAddedList);

console.log('\n[Topic7-ES6]\n--- [VLAN Config Applied: ES6(Spread)] ---');
console.log(vlanAddedListES6);


// --- [Topic 8: .some() & .every() / Health Check] ---
// ES5比較教材としては「ES6以降で便利」枠（古い環境では polyfill 前提）
var isAnyDown = deviceData2.some(function (d) { return d.Status === 'Down'; }); // 1台でもDownならtrue
var isAllUp   = deviceData2.every(function (d) { return d.Status === 'UP'; });  // 全台UPならtrue

console.log('\n[Topic8]\n警報フラグ: ' + isAnyDown);
console.log('全系正常フラグ: ' + isAllUp);


// --- [Topic 9: Ternary Operator / Status Labeling] ---
// 三項演算子は ES5 でも使える。ログ整形は ES6 だと読みやすい
console.log('\n[Topic9]\n--- [Status Labeling] ---');
deviceData2.forEach(function (d) {
    var label = (d.Status === 'UP') ? '✅OK' : '❌NG';
    console.log(d.id + ': [' + label + ']');
});

// ES6版（テンプレート文字列）
deviceData2.forEach(function (d) {});
deviceData2.forEach((d) => {
    var label = (d.Status === 'UP') ? '✅OK' : '❌NG';
    console.log(`${d.id}: [${label}]`);
});


// --- [Topic 10: Logical Operators / Extended Filtering] ---
// && (AND) を使った複合条件（Type かつ Status など）
var downSwitches = deviceData2.filter(function (d) {
    return d.type === 'Switch' && d.Status === 'Down';
});

console.log('\n[Topic10]\n--- [調査対象] DownしているSwitch一覧 ---');
console.log(downSwitches);



/*
 * 【解法ポイント：エンジニアの眼力（Phase 2: 運用・保守編）】
 *
 * 1. .find() : ピンポイント検索
 *    全体から「これだ」という1つだけを掴む。見つからない場合は undefined。
 *
 * 2. .map() : コンフィグの一括整形（トランスレート）
 *    既存リストから「新設定リスト」を生成するパイプライン処理（非破壊）。
 *
 * 3. { ...device } / Object.assign : Configの継承（コピペ＆上書き）
 *    JS版 copy run start。既存設定を継承しつつ一部だけ上書きする。
 *
 * 4. 三項演算子 : 1行の条件付きラベル
 *    if-else を 1 行で。短い判定に最適。
 *
 * 5. && / || (論理演算子) : 複合ACL（Extended Access-List）
 *    複数条件（Type かつ Status など）を組み合わせて絞り込む。
 *
 * 【1行ハック】
 * 「JS開発は Config の自動生成と同じ。
 *  map で雛形を作り、継承（... / assign）で上書きし、
 *  三項演算子で状態をラベル化して、理想の構成（データ）へ収束させる。」
 */


// 課題,テーマ,エンジニアの眼力（ハックの極意）
// Q1,Provider,「接続先の確立」：どのクラウド（GCP/AWS）にどの特権でログインするかを定義する「セッション確立」のフェーズ。
// Q2,Variables,「パラメータシートの外出し」：JSの const 定数と同じ。IPアドレスやプロジェクトIDなどの「動く値」を分離し、再利用性を高める。
// Q3,VPC,「仮想ルータの設置」：L3の器（グローバルなルーティングドメイン）を定義。auto_create_subnetworks = false にして手動設計が基本。
// Q4,Subnet,「インターフェースの切り出し」：VPCのIDを参照して紐付ける。依存関係管理の核心。
// Q5,Firewall,「タグベースのACL」：IPだけでなくタグで制御。条件フィルタと同じ発想。
// Q6,NAT/Router,「依存関係の連鎖」：Routerを作ってからNATを載せる。Terraformが作成順序を計算するため投入順ミスが起きにくい。
// Q7,三項演算子,"「環境分岐」：var.env == ""prod"" ? 100 : 1000 のように、1行で本番と開発の設定を切り替える。"
// Q8,for_each,「コンフィグ量産」：JSの forEach / map と同じ。Map（連想配列）を回して大量リソースを自動生成する。
// Q9,Outputs,「showコマンドの自動化」：構築後にIDやIP一覧をダンプする。console.log() と同じ。
// Q10,Lifecycle,「誤削除防止」：prevent_destroy は物理ロック。運用フェーズの最後の防衛線。