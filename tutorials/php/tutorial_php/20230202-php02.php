<?php

echo "----------",PHP_EOL,"sample code 1 if",PHP_EOL,"----------",PHP_EOL;
// declare arrays


// sample code 1
$age = 60;
if ($age < 20) {
    echo "未成年です。";
} else if ($age >= 60) {
    echo "シニアです。";
} else {
    echo"成年です。";
}

// output
シニアです。

echo "----------",PHP_EOL,"sample code 2",PHP_EOL,"----------",PHP_EOL;

// sample code 2
// declare 2 variable number (num1, num2)
// output accoding to the result of num1 - num2
// "even number", "odd number", "0"

$num1 = 15;
$num2 = 15;

$diff = $num1 - $num2;

if ($diff === 0) {
    echo "0".PHP_EOL;
} elseif ($diff % 2 === 1) {
    echo "odd number".PHP_EOL;
} elseif ($diff % 2 === 0) {
    echo "even number".PHP_EOL;
}

// output
0


echo "----------",PHP_EOL,"ternary operator",PHP_EOL,"----------",PHP_EOL;
// ternary operator
// like a one line if block

$age = 19;
echo $age < 20 ? "未成年です" : "成年です";

// 実行結果
未成年です

■イコールの数による違い
// sample code
// ＝＝＝を使った場合
// int型
$value1 = 1;

// str型
$value2 = "1";

//型の比較を行う
if ($value1 === $value2){
    echo "同じです";
} else {
    echo "違います";
}

// 実行結果
違います


echo "----------",PHP_EOL,"switch",PHP_EOL,"----------",PHP_EOL;

$pref = "tokyo";

switch ($pref) {
 case "tokyo":
 case "kanagawa":
 case "chiba":
 echo "kanto";
 break;

default:
 echo "n/a";
 break;
}

// output
kanto

echo "----------",PHP_EOL,"for",PHP_EOL,"----------",PHP_EOL;

// for sample 1
// count 1 to 10
// stop at 5
for ($i = 1; $i <= 10; $i++){
    if ($i === 6) {
    break;
  }
  echo $i . PHP_EOL;}


// for sample 2
$count = 0;

for ($i = 30; $i <= 60; $i++){
    if ($i % 2 === 0 && $i / 2 % 2 === 1){
            $count++;
    }
}
echo $count;
echo PHP_EOL;


// for sample code 3

$count = 0;

for($i = 1000; $i >= 1; $i--){
    if ($i % 3 === 0 && $i % 7 === 0) {
        $count++;
    }
    
    if ($count >= 10) {
        echo $count.PHP_EOL;
        echo $i. PHP_EOL;
        break;
    }
}

// sample code 4
// make a following figure
//   #
//  ###
// #####


$n = 3;
for($i = 0; $i < $n; $i++){
    for($j = 0; $j < ($n - 1) - $i; $j++){
        echo " ";
    }
    for($k = 0; $k <= $i * 2; $k++){
    echo "#";
    }
    echo PHP_EOL;
} 


echo "----------",PHP_EOL,"foreach",PHP_EOL,"----------",PHP_EOL;

// foreach sample code 1
$colors = array("red", "blue", "yellow");

foreach($colors as $value)
    {echo $value . "\n";
}

// foreach sample code 2
$userScores = array( "tanaka" => 90, "yamada" => 80, "suzuki" => 70, );
foreach ( $userScores as $name =>;$score ) {
    echo "name: {$name} score: {$score}";
    echo PHP_EOL;
}




echo "----------",PHP_EOL,"while",PHP_EOL,"----------",PHP_EOL;

echo "-----",PHP_EOL,"for文",PHP_EOL,"-----",PHP_EOL;
for($i = 100; $i <= 200; $i++){
  if ($i % 10 === 5) {
      echo $i.PHP_EOL;
      break;
      }
}

echo "-----",PHP_EOL,"while文",PHP_EOL,"-----",PHP_EOL;
$i = 100;
while($i <= 200){
    if ($i % 10 === 5) {
        echo $i.PHP_EOL;
        break;
    }
$i++;
}

echo "-----",PHP_EOL,"do-while文",PHP_EOL,"-----",PHP_EOL;
$i = 100;
do {
    if ($i % 10 === 5) {
        echo $i.PHP_EOL;
        break;
        }
    $i++;
} while ($i <= 200);



