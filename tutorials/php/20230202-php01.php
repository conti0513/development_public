<?php

// define
// sample code
echo "----------",PHP_EOL,"sample define",PHP_EOL,"----------",PHP_EOL;
define("GOOGLE_URL", "https://www.google.co.jp");
echo GOOGLE_URL;

// output
// https://www.google.co.jp
echo "----------",PHP_EOL;

// types
// sample code
echo "----------",PHP_EOL,"sample types",PHP_EOL,"----------",PHP_EOL;
$number = 5;
$text = "test";
$flag = true;
$test = null;

// 確認のため変数を出力
echo $number,PHP_EOL;
echo $text,PHP_EOL;
echo $flag,PHP_EOL;
echo $test,PHP_EOL;
echo "----------",PHP_EOL;

// 変数の型を確認
var_dump($number)."\n";
var_dump($text)."\n";
var_dump($flag)."\n";
var_dump($test)."\n";
echo "----------",PHP_EOL;

// var_dump:型に関する情報をダンプする
// sample code
$word = "php";
var_dump($word);
echo "----------",PHP_EOL;

// sample
// 本来はわかりやすい変数にするべきだが、仮で以下の変数を宣言
$a = 10 + 5;
$b = 10 - 5;
$c = 10 / 5;
$d = 10 * 5;
$e = 10 % 5;
$f = (1 + 2) * 3 * (4 + 5);

// 型を確認してみる
var_dump($a);
var_dump($b);
var_dump($c);
var_dump($d);
var_dump($e);
var_dump($f);
echo "----------",PHP_EOL;

// 変数$gに1を足す処理
$g = 50;
  $g++;
  var_dump($g);
  echo "----------",PHP_EOL;

// 変数$gから1を引く処理
  $g--;
  var_dump($g);
  echo "----------",PHP_EOL;

// 変数$nameに文字列を入れて出力してみる
// 改行コードは「PHP_EOL」が利用可能
echo "----------",PHP_EOL;
$name = "Jiro";
$value1 = "Hello {$name}";
$value2 = 'Hello $name';
  echo $name;
  echo PHP_EOL;
  echo $value1;
  echo PHP_EOL;
  echo $value2;
  echo PHP_EOL;
  echo "----------",PHP_EOL;

// sample code calc
echo "----------",PHP_EOL,"sample calc",PHP_EOL,"----------",PHP_EOL;
// 基本的な計算
// 整数型の２つの変数を宣言
// 2つの変数を用いて、　足す、引く、かける、割る、割った余りを出力

$int_num1 = 8;
$int_num2 = 7;

// 足す
echo $int_num1 + $int_num2,PHP_EOL;
var_dump($int_num1 + $int_num2)."\n";

// 引く
echo $int_num1 - $int_num2,PHP_EOL;
var_dump($int_num1 - $int_num2)."\n";

// かける
echo $int_num1 * $int_num2,PHP_EOL;
var_dump($int_num1 * $int_num2)."\n";

// 割る
echo $int_num1 / $int_num2,PHP_EOL;
var_dump($int_num1 / $int_num2)."\n";

// 割った余り
echo $int_num1 % $int_num2,PHP_EOL;
var_dump($int_num1 % $int_num2)."\n";
echo "----------",PHP_EOL;


// sample code if
echo "----------",PHP_EOL,"sample if",PHP_EOL,"----------",PHP_EOL;

// 条件式とboolean(論理型)
// 初期値がfalseである論理型の変数を宣言
// sample code 2で宣言した２つの変数を足した結果が偶数であれば、論理型の変数にtrueを代入

// 変数を宣言
$flag = false;

if(($int_num1 + $int_num2) % 2 == 0){
    $flag = true;
}
// 確認のためフラグの状態を出力
var_dump($flag);
echo "----------",PHP_EOL;


echo "----------",PHP_EOL,"sample bool",PHP_EOL,"----------",PHP_EOL;

// sample code 3 のboolean型の変数を利用した条件式を作成し、以下のように出力
// ・偶数の場合「even number」
// ・奇数の場合「odd number」

if($flag == true){
    echo "even number",PHP_EOL;
}else{
    echo "odd number",PHP_EOL;
}
echo "----------",PHP_EOL;

