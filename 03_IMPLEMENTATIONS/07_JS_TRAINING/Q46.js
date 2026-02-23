
// --- [Topic 1: Array Object / show interface brief --json] ---
// 配列(Array)の中にオブジェクト({})を格納。NW機器1台 = 1つの { } 
// NW2
var deviceData2 = [
    { id: 'RT-02', type: 'Router', Status: 'UP', ip: '192.168.2.1' },
    { id: 'SW-03', type: 'Switch', Status: 'Down', ip: '192.168.2.10' },
    { id: 'SW-04', type: 'Switch', Status: 'UP', ip: '192.168.2.11' },
    { id: 'FW-02', type: 'Switch', Status: 'Down', ip: '10.1.0.1' }
]

// 配列全体をコンソールに表示
console.log(`[Topic1]\n---[arr deviceData2]---\n`,deviceData2);


// --- [Topic 2: .filter() / ACL: permit status down] ---
// 条件(return)に合う要素だけを抽出して新バッファ(downDevices)に格納
var downDevices = deviceData2.filter(function (device) {
    return device.Status === 'Down';
});

console.log('\n\n[Topic2]\n--- [警報] 以下のデバイスが Down しています ---');

downDevices.forEach(function (device) {
    console.log('ALERT: ' + device.id + ' (' + device.ip + ')');
});


// --- [Topic 3: .forEach() / Logging Loop] ---
// リストを上から一行ずつなめる。文字列結合(+)でログを整形
console.log('\n\n[Topic3]\n--- [System Log: Scan Started] ---');
downDevices.forEach(function (device) {
    var message = 'ALERT: ' + device.id + ' is ' + device.Status;
    console.log(message);
});


// アロー関数で書いた場合
// function という文字を消して、 => (矢印) でつなぐ
downDevices.forEach( (device) => {
    console.log( `ALERT: ${device.id} is ${device.Status}` );
});


// --- [Topic 4: String Method / Prefix Match (indexOf)] ---
// indexOf === 0 は、IPのプレフィックス(10.)が「先頭」にあるかの判定
// downDevices.forEach(function(device) {
//     if (device.ip.indexOf('10.') === 0) {
//         console.warn('CRITICAL: External segment error on ' + device.id);
//     }
// });


downDevices.forEach(function(device){
    if(device.ip.indexOf(`10.`) === 0){
        console.warn(`\n\n[Topic4]\nCRITICAL: External segment error on ` + device.id);
    }
});


// --- [Topic 5: データ存在チェック] ---
if (deviceData2.length === 0) {
    // データが0件の場合（異常事態）
    console.error(`\n\n[Topic5]\nERROR: Device list is empty!`);
} else {
    // 1件でもデータがあればこちらを通る
    console.log(`\n\n[Topic5]\nDB Check: ${deviceData2.length} devices loaded.`);
}

// // --- [Topic 6: .find() / Specific Target Search] ---
// var targetIp = '192.168.2.11';
// var targetDevice = deviceData2.find( (device) => {
//     return device.ip === targetIp;
// });

var targetIIP = `192.168.2.11`;
var targetDevice = deviceData2.find( (device) => {
    return device.ip === targetIIP;
});

// ログ出力
console.log(`\n\n[Topic6]\n--- 特定IPの検索結果 ---`);

if (targetDevice) {
    // 見つかった場合：そのデバイスの詳細を表示
    console.log(`SUCCESS: Target found! -> ID: ${targetDevice.id}, Type: ${targetDevice.type}`);
} else {
    // 見つからなかった場合（IPミスなど）：警告を出す
    console.warn(`NOT FOUND: IP ${targetIIP} はリストに存在しません。`);
}


// // targetDevice が存在する場合のみ表示（ガード句）
// if (targetDevice) {
//     console.log(`[FIND SUCCESS] Target found: ${targetDevice.id}`);
// }


// // --- [Topic 7: .map() / Bulk Configuration] ---
// // .map は元の配列を元に「新しい配列」を生成する（非破壊）
// var vlanAddedList = deviceData2.map( (device) => {
//     // スプレッド構文（...）で中身をコピーしつつ vlan を追加
//     return { ...device, vlan: 100 };
// });

// console.log('--- [VLAN Config Applied] ---');
// console.log(vlanAddedList);


// // --- [Topic 8: .some() & .every() / Health Check] ---
// var isAnyDown = deviceData2.some( (d) => d.Status === 'Down' ); // 1台でもDownならtrue
// var isAllUp   = deviceData2.every( (d) => d.Status === 'UP' );   // 全台UPならtrue

// console.log(`警報フラグ: ${isAnyDown}`); // true が出れば異常あり
// console.log(`全系正常フラグ: ${isAllUp}`);


// // --- [Topic 9: Ternary Operator / Status Labeling] ---
// deviceData2.forEach( (d) => {
//     // (条件) ? trueの時 : falseの時
//     var label = (d.Status === 'UP') ? '✅OK' : '❌NG';
//     console.log(`${d.id}: [${label}]`);
// });




// // --- [Topic 10: Logical Operators / Extended Filtering] ---
// var downSwitches = deviceData2.filter( (d) => {
//     // && (AND) を使った複合条件
//     return d.type === 'Switch' && d.Status === 'Down';
// });

// console.log('--- [調査対象] DownしているSwitch一覧 ---');
// console.log(downSwitches);



/*
 * 【解法ポイント：エンジニアの眼力（Phase 2: 運用・保守編）】
 * * 1. .find() : ピンポイント・パケットキャプチャ
 * 全パケットから「これだ！」という1つだけを掴む。見つからない場合は undefined。
 * * 2. .map() : コンフィグの一括整形（トランスレート）
 * 現場使用率No.1。既存リストを元に「新設定リスト」を生成するパイプライン処理。
 * * 3. { ...device } (スプレッド構文) : Configの継承（コピペ＆上書き）
 * JS版 copy run start。既存設定をコピペしつつ、一部だけ書き換える時短テク。
 * * 4. ? : (三項演算子) : 1行の条件付きラベル（ロジカル・タグ）
 * if-else を 1 行で。ServiceNowの短いスクリプトで多用される必須構文。
 * * 5. && / || (論理演算子) : 複合ACL（Extended Access-List）
 * 複数の条件（Type かつ Status など）を組み合わせた高度なフィルタリング。
 * * 【1行ハック】
 * 「JS開発は『Configの自動生成』と同じ。.map で雛形を作り、... で設定を継承し、
 * 三項演算子でステータスを判定して、理想の構成図（データ）へ収束させよ。」
 */