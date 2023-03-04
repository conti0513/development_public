
<?php

// 20220122-02 修正箇所
// その１ Q1からQ4までのファイルをまとめる／重複していた変数の宣言を削除
// その２ echoの出力結果については、改行コードを「."\n"」→「,PHP_EOL」に修正
// その３ 出力結果に問題番号を追記
// その４ Q3 演算子の前後に半角スペースを追記／不要なelse文を削除
// その５ Q3とQ4はそれぞれ設問に解答するように変更
// その６ Q4 ifの条件：比較演算子の不備を修正

echo "----------",PHP_EOL,"Q1",PHP_EOL,"----------",PHP_EOL; //修正その３
// 1. 基本的な変数の宣言
// 以下の指定された条件に合うような値を変数に代入して宣言してください。
// ・整数（int） $number: 5
// ・文字列（string） $text: test
// ・論理型（boolean） $flag: true
// ・null型 $test: null

// 変数を宣言
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


echo "----------",PHP_EOL,"Q2",PHP_EOL,"----------",PHP_EOL; //修正その３
// Q2. 基本的な計算
// 整数型の２つの変数を宣言してください。
// 2つの変数を用いて、　足す、引く、かける、割る、割った余りを出力してください。

$intNum1 = 9;
$intNum2 = 5;

// 足す
echo $intNum1 + $intNum2,PHP_EOL;
var_dump($intNum1 + $intNum2)."\n";

// 引く
echo $intNum1 - $intNum2,PHP_EOL;
var_dump($intNum1 - $intNum2)."\n";

// かける
echo $intNum1 * $intNum2,PHP_EOL;
var_dump($intNum1 * $intNum2)."\n";

// 割る
echo $intNum1 / $intNum2,PHP_EOL;
var_dump($intNum1 / $intNum2)."\n";

// 割った余り
echo $intNum1 % $intNum2,PHP_EOL;
var_dump($intNum1 % $intNum2)."\n";


echo "----------",PHP_EOL,"Q3",PHP_EOL,"----------",PHP_EOL; //修正その３

// Q3. 条件式とboolean(論理型)について
// 初期値がfalseである論理型の変数を宣言してください。
// 問題2で宣言した２つの変数を足した結果が偶数であれば、論理型の変数にtrueを代入してください。

// 変数を宣言
$flag = false;

// Q3 処理
// 修正その５を適用
if(($intNum1 + $intNum2) % 2 == 0){
    $flag = true; 
}
// 確認のためフラグの状態を出力
var_dump($flag);

echo "----------",PHP_EOL,"Q4",PHP_EOL,"----------",PHP_EOL; //修正その３
// Q4. 条件式
// 設問3のboolean型の変数を利用した条件式を作成し、以下のように出力してください。
// ・偶数なら.....「偶数です」
// ・奇数なら.....「奇数です」

// Q4 処理
// 修正その１からその4まで適用（問題をまとめる、処理をまとめる、演算子の前後にスペースを追記、不要なelse文を削除、echos出力結果の改行にPHP_EOLを利用）
// 修正その５を適用（処理Q3の結果を受けられるように修正）
// 修正その６を適用（ifの条件：比較演算子の不備を修正）
if($flag == true){
    var_dump($flag)."\n";
    echo "偶数です",PHP_EOL;
}else{
    var_dump($flag)."\n";
    echo "奇数です",PHP_EOL;
}

echo "----------",PHP_EOL; //修正その３
?>