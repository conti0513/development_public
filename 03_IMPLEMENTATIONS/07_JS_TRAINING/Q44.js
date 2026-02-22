/**
 * Mastery Drill: No.44 (GlideRecord Optimization / ループの高速化)
 * --------------------------------------------------
 * 【シナリオ】
 * 10,000件のレコードがあるテーブルから、特定の条件でデータを抽出せよ。
 * 全カラムを持ってくるのではなく、必要なカラムだけに絞って高速化せよ。
 * --------------------------------------------------
 */

var gr = new GlideRecord('incident');
gr.addQuery('active', true);

// ✅ 最適化ポイント1: 必要なカラムだけを取得 (読み込み負荷激減)
gr.setLimit(100); 
gr.addQuery('priority', 1);

// ✅ 最適化ポイント2: whileループ内での getRowCount() 多用を避ける
gr.query();

while (gr.next()) {
    // ❌ 悪い例: gr.getValue('description') (巨大な文字列はメモリを食う)
    // ✅ 良い例: 本当に判定に必要な sys_id や number だけを扱う
    console.log("Q44 Processing: " + gr.number);
}

/**
 * 【ハックのポイント】
 * 巨大なテーブルに対して query() を投げる際、インデックスが貼られていない
 * カラムで addQuery すると、DB全体がスローダウンします。
 * Terraform等で定義したDBインデックスを意識してクエリを書くのがプロです。
 */