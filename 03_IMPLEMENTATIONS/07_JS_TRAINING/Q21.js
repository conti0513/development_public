/**
 * Mastery Drill: No.21 (JSON.parse / DB連携・検疫・オブジェクト化)
 * --------------------------------------------------
 * 【シナリオ：DBからのデータフロー】
 * 1. 抽出 (Extraction): DBから「生文字列」を取得する。
 * 2. 整形 (Cleaning): 前後の余計な空白を掃除する。
 * 3. 検問 (Parsing): try-catch 構文で安全にパースする。
 * 4. 防衛 (Fallback): 失敗しても「空のオブジェクト」を返し、システムを止めない。
 * --------------------------------------------------
 */

// --- [擬似的なDB取得関数] ---
function getRawDataFromDB() {
    // 実際には gr.getValue('u_custom_json') や row.payload など
    // DBにはしばしば、末尾に改行が入っていたり、壊れたJSONが入っている。
    return '  {"id": 101, "name": "Tanaka", "roles": ["admin"]}  \n'; 
}

// --- [実戦型：JSON整形・変換フロー] ---

// 1. 抽出 (Extract)
var rawData = getRawDataFromDB();

// 2. 整形 (Clean / Q28: trim)
// パース前にトリムしないと、古いエンジンでは改行コードだけでエラーになる場合がある。
var cleanedData = rawData ? rawData.trim() : "";

// 3. 検問 & 防衛 (Try-Catch / Q21)
var userObj;

try {
    // 文字列をJSの道具（オブジェクト）に変換
    userObj = JSON.parse(cleanedData);
    
    console.log('✅ パース成功: ID=' + userObj.id);
} catch (e) {
    // 4. 防衛 (Fallback)
    // エラーが起きた場合、ここで「空のオブジェクト」を代入するのがプロの技。
    // これにより、後続の処理で userObj.name を呼んでも「エラー（即死）」せず「undefined」で済む。
    console.error('❌ Q21 Error: JSONの形式が不正です。空のオブジェクトを割り当てます。');
    userObj = {}; 
}

// --- [実行結果の確認] ---
console.log('Q21 Result: ' + (userObj.name || "名称未設定"));

/**
 * 【ハックのポイント：精読の眼力】
 * * 1. なぜトリム(trim)が必要か？:
 * DBから取得した値には見えない改行記号(\n)が含まれることが多く、
 * JSON.parse() はこれに非常に敏感です。検疫（掃除）はセットだと覚えましょう。
 * * 2. なぜ catch で {} を入れるのか？:
 * パースに失敗して userObj が undefined のままだと、その後のコードで
 * userObj.id を参照した瞬間に「Cannot read property 'id' of undefined」
 * という致命的なエラーでシステムが止まります。これを防ぐのが「防衛代入」です。
 * * 3. 現場での指摘：
 * 「try-catchのないJSON.parseは、外部データにシステムを人質に取らせているのと同じです」
 * ポイント：「JSONパースは『掃除・防護・予備』の3点をセットにして、予期せぬデータ不備からシステムを守り抜く」
 */