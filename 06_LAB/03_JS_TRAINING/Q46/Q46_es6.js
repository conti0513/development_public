/* ============================================================
 * Q46 (ES6)
 * Modern JavaScript Version
 * const / let / arrow / template literal / spread
 * find / map / some / every / startsWith
 * ============================================================ */


// --- [Topic 1: Array of Objects / show inventory] ---
const deviceData = [
  { id: 'RT-02', type: 'Router',   status: 'UP',   ip: '192.168.2.1' },
  { id: 'SW-03', type: 'Switch',   status: 'Down', ip: '192.168.2.10' },
  { id: 'SW-04', type: 'Switch',   status: 'UP',   ip: '192.168.2.11' },
  { id: 'FW-02', type: 'Firewall', status: 'Down', ip: '10.1.0.1' }
];

console.log('\n[Topic1] Device Inventory');
console.log(deviceData);


// --- [Topic 2: .filter() / Down Detection] ---
const downDevices = deviceData.filter(d => d.status === 'Down');

console.log('\n[Topic2] Down Devices Alert');
downDevices.forEach(d => console.log(`ALERT: ${d.id} (${d.ip})`));


// --- [Topic 3: Logging Loop] ---
console.log('\n[Topic3] System Log Scan');
downDevices.forEach(d => console.log(`ALERT: ${d.id} is ${d.status}`));


// --- [Topic 4: Prefix Match / startsWith] ---
console.log('\n[Topic4] External Segment Check');

downDevices.forEach(d => {
  if (d.ip.startsWith('10.')) {
    console.warn(`CRITICAL: External segment error on ${d.id}`);
  }
});


// --- [Topic 5: Data Existence Check] ---
console.log('\n[Topic5] DB Check');

if (deviceData.length === 0) {
  console.error('ERROR: Device list is empty!');
} else {
  console.log(`DB Check: ${deviceData.length} devices loaded.`);
}


// --- [Topic 6: .find() / Target Search] ---
console.log('\n[Topic6] Target Search');

const targetIP = '192.168.2.11';
const targetDevice = deviceData.find(d => d.ip === targetIP);

if (targetDevice) {
  console.log(`SUCCESS: Found ${targetDevice.id} (${targetDevice.type})`);
} else {
  console.warn(`NOT FOUND: IP ${targetIP} not found.`);
}


// --- [Topic 7: .map() + Spread / Bulk Config Injection] ---
console.log('\n[Topic7] VLAN Injection');

const vlanApplied = deviceData.map(d => ({
  ...d,
  vlan: 100
}));

console.log(vlanApplied);


// --- [Topic 8: .some() & .every() / Health Flags] ---
console.log('\n[Topic8] Health Flags');

const isAnyDown = deviceData.some(d => d.status === 'Down');
const isAllUp   = deviceData.every(d => d.status === 'UP');

console.log(`Any Down: ${isAnyDown}`);
console.log(`All Up: ${isAllUp}`);


// --- [Topic 9: Ternary Operator / Status Labeling] ---
console.log('\n[Topic9] Status Labels');

deviceData.forEach(d => {
  const label = d.status === 'UP' ? '✅OK' : '❌NG';
  console.log(`${d.id}: ${label}`);
});


// --- [Topic 10: Logical Operators / Extended Filtering] ---
console.log('\n[Topic10] Down Switches');

const downSwitches = deviceData.filter(
  d => d.type === 'Switch' && d.status === 'Down'
);

console.log(downSwitches);



// ============================================================
// Engineer Insight (Modern JS Perspective)
// ============================================================

/*
1. filter()   -> ACL的フィルタリング
2. find()     -> 単一ターゲット捕捉
3. map()      -> 非破壊トランスフォーム
4. spread     -> 設定継承（copy + override）
5. some()     -> 1台でも異常か？
6. every()    -> 全系正常か？
7. ternary    -> 状態ラベルの簡潔化
8. startsWith -> プレフィックス判定の可読性向上

------------------------------------------------------------
1行ハック：
「ES6は宣言的。
 何をするかが明確で、どう回すかを考えなくていい。」
------------------------------------------------------------
*/