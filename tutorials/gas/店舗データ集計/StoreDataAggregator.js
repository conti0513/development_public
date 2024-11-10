// 店舗データ集計ツール
var CONFIG = {
  SUMMARY_SHEET_ID: 'シートID',  // スプレッドシートID
  FORMAT_SHEET_NAME: '整形用シート',  // 整形用シート（データ抽出元）
  AGGREGATE_SHEET_NAME: '集計用シート',  // 集計用シート（データ貼り付け先）
  STORE_NAME: '店舗５',  // 店舗名
  TAX_RATE: '10%',  // 税率を設定
  SEPARATOR_TEXT: '店舗５ここまで'  // データの最下部に追加する区切り文字列
};

// 関数1: 整形用シートの色付き行を配列に格納して返す
function getColoredRowsData() {
  var spreadsheet = SpreadsheetApp.openById(CONFIG.SUMMARY_SHEET_ID);
  var sourceSheet = spreadsheet.getSheetByName(CONFIG.FORMAT_SHEET_NAME);
  
  if (!sourceSheet) {
    Logger.log("整形用シートが見つかりません");
    return [];
  }

  var data = sourceSheet.getDataRange().getValues();
  var backgrounds = sourceSheet.getDataRange().getBackgrounds();
  var coloredRowsData = [];

  for (var i = 0; i < data.length; i++) {
    if (backgrounds[i].some(color => color !== '#ffffff' && color !== '#FFFFFF')) {
      coloredRowsData.push(data[i]);
      Logger.log("抽出した行 " + (i + 1) + ": " + JSON.stringify(data[i]));
    }
  }

  Logger.log("全色付き行のデータ: " + JSON.stringify(coloredRowsData));
  return coloredRowsData;
}

// 関数2: データを集計用シートの最下部に追加し、最後に区切り文字列を追加
function copyDataToAggregateSheet() {
  var spreadsheet = SpreadsheetApp.openById(CONFIG.SUMMARY_SHEET_ID);
  var destinationSheet = spreadsheet.getSheetByName(CONFIG.AGGREGATE_SHEET_NAME);
  
  if (!destinationSheet) {
    Logger.log("集計用シートが見つかりません");
    return;
  }

  var lastRow = destinationSheet.getLastRow();
  var outputData = [];

  if (lastRow === 0) {
    outputData.push(["店舗名", "商品名", "税率", "金額"]); // ヘッダー
    lastRow = 1;
  }

  var coloredRowsData = getColoredRowsData();

  if (coloredRowsData.length > 0) {
    coloredRowsData.forEach(function(row) {
      var rowData = row[0].split(/\s+/);
      var storeName = CONFIG.STORE_NAME;
      var productName = rowData[0];
      var taxRate = CONFIG.TAX_RATE;
      var amount = rowData[3];

      Logger.log("店舗名: " + storeName + ", 商品名: " + productName + ", 税率: " + taxRate + ", 金額: " + amount);

      outputData.push([storeName, productName, taxRate, amount]);
    });
  }

  outputData.push([CONFIG.SEPARATOR_TEXT, "", "", ""]);
  destinationSheet.getRange(lastRow + 1, 1, outputData.length, outputData[0].length).setValues(outputData);
  
  Logger.log("データが集計用シートに転記され、区切り文字列が最下部に追加されました");
}
