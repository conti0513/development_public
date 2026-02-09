# ユーザー作成デモスクリプト
$users = @(
    @{username="demo1"; fullname="Demo User 1"; password="Demo@123"},
    @{username="demo2"; fullname="Demo User 2"; password="Demo@123"}
)

foreach ($user in $users) {
    $securePassword = ConvertTo-SecureString $user.password -AsPlainText -Force
    New-LocalUser -Name $user.username -FullName $user.fullname -Password $securePassword
    Add-LocalGroupMember -Group "Administrators" -Member $user.username
    Write-Host "Created user: $($user.username)"
}
