# Open_URL_01.ps1

$url_list = "/Users/yoshi/Documents/code/PowerShell/list/duolingo_url_list.csv"
$ary_list = @(Get-Content $url_list)
$app_01 = '/Applications/Google Chrome.app'

# # ary_list の内容を1行づつ表示
# foreach($str_name in $ary_list)
#   {
#       Write-Host $str_name
#   }

foreach($str_name in $ary_list)
  {
    open -a $app_01 $str_name
    Start-Sleep -Seconds 3
  }



