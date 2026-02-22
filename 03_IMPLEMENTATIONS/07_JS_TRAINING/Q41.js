/**
 * Mastery Drill: No.41 (Unit Testing / 品質担保の基本)
 * --------------------------------------------------
 * 【シナリオ】
 * 1. 外部から届いた設定値（Q34:split）を計算する関数の「正しさ」を証明せよ。
 * 2. 正常なデータだけでなく、空文字や不正な型に対する「防御力」を測定せよ。
 * --------------------------------------------------
 */

/**
 * テスト対象の関数：カンマ区切りの数字文字列を合計する
 * (Q13, Q31, Q34, Q36 の複合ロジック)
 */
function sumCsv(csvString) {
    if (typeof csvString !== 'string' || !csvString) return 0;

    var parts = csvString.split(",");
    var total = 0;

    for (var i = 0; i < parts.length; i++) {
        var num = parseInt(parts[i].trim()); // Q28:trim & Q34:split
        if (!isNaN(num)) { // Q36:isNaN で数値妥当性チェック
            total += num;
        }
    }
    return total;
}

/**
 * --- [簡易テストランナー] ---
 * 期待値 (expected) と 実際の値 (actual) を比較し、
 * 現場で「壊れていないこと」を証明するためのログを出す。
 */
function assert(testName, actual, expected) {
    if (actual === expected) {
        console.log("✅ PASS: [" + testName + "]");
    } else {
        console.error("❌ FAIL: [" + testName + "]");
        console.error("   期待値: " + expected + " / 実際の値: " + actual);
    }
}

// --- [テスト実行：Happy Path（正常系）] ---
assert("標準的なカンマ区切り", sumCsv("10, 20, 30"), 60);
assert("空白が混じっていても計算できる", sumCsv(" 5 , 15 , 10 "), 30);

// --- [テスト実行：Edge Cases（異常系・境界値）] ---
assert("空文字が来たら0を返す", sumCsv(""), 0);
assert("nullが来てもエラーにならず0を返す", sumCsv(null), 0);
assert("文字が混じっていても無視して数字だけ合計する", sumCsv("10, abc, 20"), 30);
assert("カンマだけの時に無限ループしない", sumCsv(",,,"), 0);

/**
 * 【ハックのポイント：精読時の眼力】
 * 1. なぜ「異常系」をテストするのか？:
 * 本番環境(Prod)では、必ず誰かが間違った設定値をTerraform等で流し込みます。
 * その時にシステムを止めない（NaNを返さない）ことを証明するのが、プロのテストです。
 * 2. コード変更の「セーブポイント」:
 * 修正前のコードでこのテストを走り込ませておけば、リファクタリング後に
 * どこか1箇所でも挙動が変わったら、即座に「赤色」でエラーが出るため、
 * 自信を持って「元に戻す（Q43/ロールバック）」の判断ができます。
 */