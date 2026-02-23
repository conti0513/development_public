/* ============================================================
 * Q46 (ES5) - Array/Object + filter/forEach + indexOf + find/map/some/every
 * 目的: ES5中心の書き方で「NW運用ログ」っぽい処理を理解する（※一部ES6機能は使用しない）
 * ============================================================ */

// --- [Topic 1: Array Object / show interface brief --json] ---
var deviceData2 = [
    { id: 'RT-02', type: 'Router',   Status: 'UP',   ip: '192.168.2.1' },
    { id: 'SW-03', type: 'Switch',   Status: 'Down', ip: '192.168.2.10' },
    { id: 'SW-04', type: 'Switch',   Status: 'UP',   ip: '192.168.2.11' },
    { id: 'FW-02', type: 'Firewall', Status: 'Down', ip: '10.1.0.1' }
];

console.log('\n[Topic1]\n--- [arr deviceData2] ---');
console.log(deviceData2);


// --- [Topic 2: .filter() / ACL: permit status down] ---
var downDevices = deviceData2.filter(function (device) {
    return device.Status === 'Down';
});

console.log('\n[Topic2]\n--- [警報] 以下のデバイスが Down しています ---');
downDevices.forEach(function (device) {
    console.log('ALERT: ' + device.id + ' (' + device.ip + ')');
});


// --- [Topic 3: .forEach() / Logging Loop] ---
console.log('\n[Topic3]\n--- [System Log: Scan Started] ---');
downDevices.forEach(function (device) {
    var message = 'ALERT: ' + device.id + ' is ' + device.Status;
    console.log(message);
});


// --- [Topic 4: String Method / Prefix Match (indexOf)] ---
console.log('\n[Topic4]\n--- [CRITICAL] External segment prefix check (indexOf) ---');
downDevices.forEach(function (device) {
    // indexOf('10.') === 0 なら "10." が文字列先頭にある
    if (device.ip.indexOf('10.') === 0) {
        console.warn('CRITICAL: External segment error on ' + device.id);
    }
});


// --- [Topic 5: データ存在チェック] ---
console.log('\n[Topic5]\n--- [DB Check] ---');
if (deviceData2.length === 0) {
    console.error('ERROR: Device list is empty!');
} else {
    console.log('DB Check: ' + deviceData2.length + ' devices loaded.');
}


// --- [Topic 6: Specific Target Search (ES5) ---
// ES5には .find() がないケースがあるため、forループで代替（確実に動く）
console.log('\n[Topic6]\n--- [Target Search: ES5 loop] ---');

var targetIP = '192.168.2.11';
var targetDevice = null;

for (var i = 0; i < deviceData2.length; i++) {
    if (deviceData2[i].ip === targetIP) {
        targetDevice = deviceData2[i];
        break;
    }
}

if (targetDevice) {
    console.log('SUCCESS: Target found! -> ID: ' + targetDevice.id + ', Type: ' + targetDevice.type);
} else {
    console.warn('NOT FOUND: IP ' + targetIP + ' はリストに存在しません。');
}

if (targetDevice) {
    console.log('[FIND SUCCESS] Target found: ' + targetDevice.id);
}


// --- [Topic 7: .map() 代替 (ES5) ---
// ES5には .map が無い環境もあるため、forEachで生成（互換性重視）
console.log('\n[Topic7]\n--- [VLAN Config Applied: ES5 compatible] ---');

var vlanAddedList = [];
deviceData2.forEach(function (device) {
    // ディープコピーではない（教材用途）。必要なら clone を別途
    var copied = {
        id: device.id,
        type: device.type,
        Status: device.Status,
        ip: device.ip,
        vlan: 100
    };
    vlanAddedList.push(copied);
});

console.log(vlanAddedList);


// --- [Topic 8: .some() & .every() 代替 (ES5) ---
// some/every も無い場合があるので for で代替
console.log('\n[Topic8]\n--- [Health Flags: ES5 loop] ---');

var isAnyDown = false;
var isAllUp = true;

for (var j = 0; j < deviceData2.length; j++) {
    if (deviceData2[j].Status === 'Down') {
        isAnyDown = true;
    }
    if (deviceData2[j].Status !== 'UP') {
        isAllUp = false;
    }
}

console.log('警報フラグ: ' + isAnyDown);
console.log('全系正常フラグ: ' + isAllUp);


// --- [Topic 9: Ternary Operator / Status Labeling] ---
console.log('\n[Topic9]\n--- [Status Labeling] ---');

deviceData2.forEach(function (d) {
    var label = (d.Status === 'UP') ? 'OK' : 'NG';
    console.log(d.id + ': [' + label + ']');
});


// --- [Topic 10: Logical Operators / Extended Filtering] ---
console.log('\n[Topic10]\n--- [調査対象] DownしているSwitch一覧 ---');

var downSwitches = deviceData2.filter(function (d) {
    return d.type === 'Switch' && d.Status === 'Down';
});

console.log(downSwitches);




/* ============================================================
 * Q46 (ES6) - const/let + arrow + template literal + find/map/some/every + startsWith
 * 目的: ES6の標準メソッドと書き方で、同じ処理を短く安全に書く
 * ============================================================ */

const deviceData6 = [
    { id: 'RT-02', type: 'Router',   status: 'UP',   ip: '192.168.2.1' },
    { id: 'SW-03', type: 'Switch',   status: 'Down', ip: '192.168.2.10' },
    { id: 'SW-04', type: 'Switch',   status: 'UP',   ip: '192.168.2.11' },
    { id: 'FW-02', type: 'Firewall', status: 'Down', ip: '10.1.0.1' }
];

console.log('\n[Topic1]\n--- [arr deviceData6] ---');
console.log(deviceData6);


// --- [Topic 2: .filter()] ---
const downDevices6 = deviceData6.filter(d => d.status === 'Down');

console.log('\n[Topic2]\n--- [警報] 以下のデバイスが Down しています ---');
downDevices6.forEach(d => console.log(`ALERT: ${d.id} (${d.ip})`));


// --- [Topic 3: forEach logging] ---
console.log('\n[Topic3]\n--- [System Log: Scan Started] ---');
downDevices6.forEach(d => console.log(`ALERT: ${d.id} is ${d.status}`));


// --- [Topic 4: Prefix Match (startsWith)] ---
console.log('\n[Topic4]\n--- [CRITICAL] External segment prefix check (startsWith) ---');
downDevices6.forEach(d => {
    if (d.ip.startsWith('10.')) {
        console.warn(`CRITICAL: External segment error on ${d.id}`);
    }
});


// --- [Topic 5: Data existence check] ---
console.log('\n[Topic5]\n--- [DB Check] ---');
if (deviceData6.length === 0) {
    console.error('ERROR: Device list is empty!');
} else {
    console.log(`DB Check: ${deviceData6.length} devices loaded.`);
}


// --- [Topic 6: .find()] ---
console.log('\n[Topic6]\n--- [Target Search: find] ---');

const targetIP6 = '192.168.2.11';
const targetDevice6 = deviceData6.find(d => d.ip === targetIP6);

if (targetDevice6) {
    console.log(`SUCCESS: Target found! -> ID: ${targetDevice6.id}, Type: ${targetDevice6.type}`);
} else {
    console.warn(`NOT FOUND: IP ${targetIP6} はリストに存在しません。`);
}

if (targetDevice6) {
    console.log(`[FIND SUCCESS] Target found: ${targetDevice6.id}`);
}


// --- [Topic 7: .map() + spread] ---
console.log('\n[Topic7]\n--- [VLAN Config Applied: map + spread] ---');

const vlanAddedList6 = deviceData6.map(d => ({ ...d, vlan: 100 }));
console.log(vlanAddedList6);


// --- [Topic 8: .some() & .every()] ---
console.log('\n[Topic8]\n--- [Health Flags] ---');

const isAnyDown6 = deviceData6.some(d => d.status === 'Down');
const isAllUp6 = deviceData6.every(d => d.status === 'UP');

console.log(`警報フラグ: ${isAnyDown6}`);
console.log(`全系正常フラグ: ${isAllUp6}`);


// --- [Topic 9: Ternary Operator] ---
console.log('\n[Topic9]\n--- [Status Labeling] ---');

deviceData6.forEach(d => {
    const label = (d.status === 'UP') ? '✅OK' : '❌NG';
    console.log(`${d.id}: [${label}]`);
});


// --- [Topic 10: Logical Operators / Extended Filtering] ---
console.log('\n[Topic10]\n--- [調査対象] DownしているSwitch一覧 ---');

const downSwitches6 = deviceData6.filter(d => d.type === 'Switch' && d.status === 'Down');
console.log(downSwitches6);