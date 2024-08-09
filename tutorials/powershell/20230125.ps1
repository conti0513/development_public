# sample code 1
# 以下の指定された条件に合うように値を代入して宣言する
# int $number: 7
# string $text: test
# boolean $flag: true
# null $test: null

Write-Host "`n----sample code 1-----`n"

# 変数を宣言
$number = 5;
$text = test;
$flag = true;
$test = null;

# 出力
Write-Host $number`n;
Write-Host $text`n;
Write-Host $flag`n;
Write-Host $test`n;

# 型の確認
# 変数の値がNULLなので、GetType() メソッドがエラーとなる。OK。
Write-Host $number.GetType().FullName;
Write-Host $text.GetType().FullName;
Write-Host $flag.GetType().FullName;
Write-Host $test.GetType().FullName;

Write-Host "`n----sample code 2-----`n"
# 整数型の2つの変数を宣言
# 2つの変数を用いて、足す、引く、かける、割る、割ったあまりを出力

$intN1 = 9;
$intN2 = 8;
$intSum = $intN1 + $intN2;

Write-Host ($intN1 + $intN2);
Write-Host ($intN1 - $intN2);
Write-Host ($intN1 * $intN2);
Write-Host ($intN1 / $intN2);
Write-Host ($intN1 % $intN2);

Write-Host "`n----sample code 3,4-----`n"
# 初期値がfalseの変数を宣言
# sample code 2で宣言した2つの変数の和が偶数であればtrueを代入、奇数であればfalseを代入

# 初期値がfalseのフラグ:flagを宣言
$flag = false;

# 宣言した2つの変数の和を定義
$intSum = $intN1 + $intN2

if(($intSum) % 2 -eq 0){
    $flag = true;
    else{
        $flag = false;
    }
}

# 初期値がfalseの変数を宣言
# sample code 2で宣言した2つの変数の和が偶数であればtrueを代入、奇数であればfalseを代入

if($flag -eq $true){
    Write-Host "even number";
}else{
    Write-Host "odd number";
}


