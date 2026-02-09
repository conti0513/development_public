# ユーザー削除デモスクリプト
$users = @("demo1", "demo2")

foreach ($username in $users) {
    if (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) {
        Remove-LocalUser -Name $username
        Write-Host "Removed user: $username"
    } else {
        Write-Host "User not found: $username"
    }
}
