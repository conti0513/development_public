<?php
// sample code 1
// int型の変数を宣言
// 変数を渡して3乗の整数を返す関数
// 変数を渡して3乗の値を返す関数を定義

function calcCubic($num) {
    // 3乗した計算結果を$resultに代入　→　出力する
    $result = pow ($num, 3);
    return $result;
}

// 関数を実行
echo calcCubic(3);

// output
27

// sample code 2
function flagExsists (bool $flag) {
    return !$flag;
}
echo var_export(flagExsists(true));

// output
false


// sample code 3

function returnNumText(int $number, string $text){
    return $number.":".$text;
}

echo returnNumText(7,'aaa');
echo PHP_EOL;


// output
7:aaa
string(5) "7:aaa"

// sample code 4
function calcByCondition(int $number, bool $flag){
    if($flag === true) {
        $number++;
    } elseif($flag === false) {
        $number--;
    }
    return $number;
}

echo calcByCondition(5,false);
echo PHP_EOL;

// output
4


// sample code 5
function repeatText(int $count, string $text) {
    if ($count <= 0) {
        echo "Out of range";
    }

    for($i = 1; $i <= $count; $i++){
      echo $text;
      echo PHP_EOL;
    }
}

repeatText(5,'aaa');


// output
aaa
aaa
aaa
aaa
aaa

// sample code debug
$number = 5;
$text = "test";
$flag = true;
$test = null;
$array = array(1,2,3);

// $number = 5;
var_dump($number);
print_r($number);
var_export($number);

// output
int(5)
5
5

// $text = "test";
var_dump($text);
print_r($text);
var_export($text);

// output
string(4) "test"
test
'test'


// $flag = true;
var_dump($flag);
print_r($flag);
var_export($flag);

// output
bool(true)
1
true


// $test = null;
var_dump($test);
print_r($test);
var_export($test);

// output
NULL
NULL

// $array = array(1,2,3);
var_dump($array);
print_r($array);
var_export($array);

// output
// var_dump($array);
// NULLarray(3) {
  [0]=>
  int(1)
  [1]=>
  int(2)
  [2]=>
  int(3)
}

// print_r($array);
Array
(
    [0] => 1
    [1] => 2
    [2] => 3
)

// var_export($array);
array (
  0 => 1,
  1 => 2,
  2 => 3,
)
