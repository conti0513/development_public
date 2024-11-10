「店舗データ集計ツール」の概要
CONFIG設定: 集計用シートID、整形用シート名、集計用シート名、店舗名、税率、区切り文字列を設定できます。
関数1 (getColoredRowsData): 整形用シートから色付き行を配列として取得し、データをログに出力。
関数2 (copyDataToAggregateSheet): 取得した色付き行データを集計用シートの最下部に追加し、最後に店舗ごとの区切り文字列を挿入します。
特徴

CONFIG.STORE_NAMEとCONFIG.SEPARATOR_TEXTにより、複数の店舗を管理可能です。



// 必要な設定をCONFIGオブジェクトで定義
var CONFIG = {
  SUMMARY_SHEET_ID: '1FRhdlneG3gowZnAqxQh_5mkdRI8RX4BIOaFqHZB8ef4',  // スプレッドシートID
  FORMAT_SHEET_NAME: '整形用シート',  // 整形用シート（データ抽出元）
  AGGREGATE_SHEET_NAME: '集計用シート',  // 集計用シート（データ貼り付け先）
  STORE_NAME: '店舗４',  // 店舗名
  TAX_RATE: '10%',  // 税率を設定
  SEPARATOR_TEXT: '店舗４ここまで'  // データの最下部に追加する区切り文字列
};

// 関数1: 整形用シートの色付き行を配列に格納して返す
function getColoredRowsData() {
  var spreadsheet = SpreadsheetApp.openById(CONFIG.SUMMARY_SHEET_ID);
  var sourceSheet = spreadsheet.getSheetByName(CONFIG.FORMAT_SHEET_NAME); // 整形用シート
  
  if (!sourceSheet) {
    Logger.log("整形用シートが見つかりません");
    return [];
  }

  // 整形用シートのデータと背景色を取得
  var data = sourceSheet.getDataRange().getValues();
  var backgrounds = sourceSheet.getDataRange().getBackgrounds();

  // 色付き行のデータを抽出して配列に格納
  var coloredRowsData = [];
  for (var i = 0; i < data.length; i++) {
    if (backgrounds[i].some(color => color !== '#ffffff' && color !== '#FFFFFF')) {
      coloredRowsData.push(data[i]);  // 色付き行のデータをそのまま配列に追加
      Logger.log("抽出した行 " + (i + 1) + ": " + JSON.stringify(data[i]));  // 各行をログに表示
    }
  }

  // 配列全体の内容をログに出力
  Logger.log("全色付き行のデータ: " + JSON.stringify(coloredRowsData));
  
  Logger.log("色付き行のデータが配列に格納されました");
  return coloredRowsData;
}


// 関数2: データを集計用シートの最下部に追加し、最後に区切り文字列を追加
function copyDataToAggregateSheet() {
  var spreadsheet = SpreadsheetApp.openById(CONFIG.SUMMARY_SHEET_ID);
  var destinationSheet = spreadsheet.getSheetByName(CONFIG.AGGREGATE_SHEET_NAME); // 集計用シート
  
  if (!destinationSheet) {
    Logger.log("集計用シートが見つかりません");
    return;
  }

  // 既存のデータの最終行を取得
  var lastRow = destinationSheet.getLastRow();
  
  // 既存のデータがない場合、ヘッダーを追加
  var outputData = [];
  if (lastRow === 0) {
    outputData.push(["店舗名", "商品名", "税率", "金額"]); // ヘッダー
    lastRow = 1; // データの開始行
  }

  // 関数1から色付き行データを取得
  var coloredRowsData = getColoredRowsData();

  // データがある場合にのみ処理
  if (coloredRowsData.length > 0) {
    coloredRowsData.forEach(function(row) {
      var rowData = row[0].split(/\s+/); // スペースで分割して配列化
      var storeName = CONFIG.STORE_NAME; // 店舗名
      var productName = rowData[0];      // 商品名
      var taxRate = CONFIG.TAX_RATE;     // 税率（固定値）
      var amount = rowData[3];           // 金額

      // ログでデータ内容を確認
      Logger.log("店舗名: " + storeName + ", 商品名: " + productName + ", 税率: " + taxRate + ", 金額: " + amount);

      outputData.push([storeName, productName, taxRate, amount]);
    });
  }

  // データの最下部に区切り文字列を追加
  outputData.push([CONFIG.SEPARATOR_TEXT, "", "", ""]);

  // 集計用シートの最下行からデータを貼り付け
  destinationSheet.getRange(lastRow + 1, 1, outputData.length, outputData[0].length).setValues(outputData);
  
  Logger.log("データが集計用シートに転記され、区切り文字列が最下部に追加されました");

}

---