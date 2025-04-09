function summarizeByUnit() {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sourceSheet = ss.getSheetByName('RawData');
    const outputSheet = ss.getSheetByName('Summary');
  
    const data = sourceSheet.getDataRange().getValues();
    const idIndex = 7;       // column for unit ID
    const labelIndex = 11;   // column with matching label (e.g., "aggregated item")
    const amountIndex = 13;
  
    const summaryMap = new Map();
  
    for (let i = 1; i < data.length; i++) {
      const row = data[i];
      const id = row[idIndex]?.toString();
      const label = row[labelIndex]?.toString();
      const amount = Number(row[amountIndex]) || 0;
  
      if (!id || !label.includes('aggregation')) continue;
  
      const idKey = "'" + id; // preserve leading 0
      summaryMap.set(idKey, (summaryMap.get(idKey) || 0) + amount);
    }
  
    const output = Array.from(summaryMap.entries()).map(([id, amount]) => [id, amount]);
    const startRow = 8;
    outputSheet.getRange(startRow, 1, output.length, 2).setValues(output);
  
    Logger.log(`Summarized ${output.length} unit records.`);
  }
  