# アプリインストールデモスクリプト
$apps = @(
    @{name="DemoApp1"; installer="demo_installer1.exe"},
    @{name="DemoApp2"; installer="demo_installer2.exe"}
)

foreach ($app in $apps) {
    Write-Host "Pretending to install: $($app.name) from $($app.installer)"
    # 実際の Start-Process は以下のようなイメージ
    # Start-Process -FilePath ".\installers\$($app.installer)" -ArgumentList "/silent" -Wait
}
