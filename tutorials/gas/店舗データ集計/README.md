「店舗データ集計ツール」の概要
CONFIG設定: 集計用シートID、整形用シート名、集計用シート名、店舗名、税率、区切り文字列を設定できます。
関数1 (getColoredRowsData): 整形用シートから色付き行を配列として取得し、データをログに出力。
関数2 (copyDataToAggregateSheet): 取得した色付き行データを集計用シートの最下部に追加し、最後に店舗ごとの区切り文字列を挿入します。
特徴

CONFIG.STORE_NAMEとCONFIG.SEPARATOR_TEXTにより、複数の店舗を管理可能です。

