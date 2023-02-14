<?php

echo "----------",PHP_EOL,"sample declare arrays",PHP_EOL,"----------",PHP_EOL;
// declare arrays
$int_arr = array(7);
$str_arr = array("apple", "banana", "grape");

var_dump($int_arr);
var_dump($str_arr);


// sample 2-1
$array_each = array();
$array_each[] = 1;
$array_each[] = 2;
$array_each[] = 3;

// sample 2-2
$array_batch = array (1, 2, 3);

var_dump($array_each);
var_dump($array_batch);


echo "----------",PHP_EOL,"sample foreach",PHP_EOL,"----------",PHP_EOL;

foreach ($array_batch as $value){
    echo $value;
    echo PHP_EOL;
}


echo "----------",PHP_EOL,"sample array use link",PHP_EOL,"----------",PHP_EOL;

// link
foreach ($array_batch as &$value){
    echo $value;
    echo PHP_EOL;
    $value = $value * 10;
}
unset($value);
var_dump($array_batch);

// reassignment
foreach ($array_each as $index => $value){
    echo $value;
    echo PHP_EOL;
    $value = $value * 10 ;
    $array_each[$index] = $value;
}

var_dump($array_each);

