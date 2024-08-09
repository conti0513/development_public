<?php

// 要件定義
// 使用可能な手はグー、チョキ、パー
// 勝ち負けは、通常のじゃんけん
// あいこの場合は再勝負
// 決着後に継続するか確認する


// 定数定義
const ROCK = 1;
const SCISSORS = 2;
const PAPER = 3;
const HAND_LIST = [ROCK => 'グー', SCISSORS => 'チョキ', PAPER => 'パー'];

/**
 * ユーザーとコンピューターのハンドを取得
 * 
 * @param array $HAND_LIST、arr_rand
 * @return array $arr_hands
 */
function getHands() {
    echo 'じゃんけんで勝負しましょう！' . PHP_EOL;
    echo '1:グー, 2:チョキ, 3:パー' . PHP_EOL . PHP_EOL;
    echo 'あなたのじゃんけんの手を決めてください >>> ';
    
    $input = trim(fgets(STDIN));

    if (!array_key_exists($input, HAND_LIST)) {
        echo '正しく入力してください' . PHP_EOL;
        return getHands();
    }
    
    $player_hand = HAND_LIST[$input];
    $com_hand = HAND_LIST[array_rand(HAND_LIST)];
    return [$player_hand, $com_hand];
}

/**
 * プレイの勝敗を判定
 * 
 * @param array $arr_hands
 * @return array $judgement_result
 */
function judgeHands($arr_hands) {
    list($player_hand, $com_hand) = $arr_hands;
   
    if ($player_hand === $com_hand) {
        $play_result = 'DRAW';
    } elseif (
        ($player_hand === HAND_LIST[ROCK] && $com_hand === HAND_LIST[SCISSORS]) || 
        ($player_hand === HAND_LIST[SCISSORS] && $com_hand === HAND_LIST[PAPER]) ||
        ($player_hand === HAND_LIST[PAPER] && $com_hand === HAND_LIST[ROCK])
    ) {
        $play_result = 'WIN';
    } else {
        $play_result = 'LOSE';
    }
    
    return [$player_hand, $com_hand, $play_result];
}

/**
 * 判定結果に応じてメッセージを取得
 * 
 * @param array judgement_result
 * @return メッセージ
 */
function putResult($judgement_result){
    list($player_hand, $com_hand, $play_result) = $judgement_result;
    $result_messages = [
        'DRAW' => '結果はあいこです。',
        'WIN' => '結果はプレイヤーの勝ちです。',
        'LOSE' => '結果はコンピューターの勝ちです。',
    ];
    $message = "プレイヤー: {$player_hand}" . PHP_EOL;
    $message .= "コンピューター: {$com_hand}" . PHP_EOL;
    $message .= $result_messages[$play_result] . PHP_EOL;
    echo $message . PHP_EOL . PHP_EOL;

    // あいこの場合は勝負継続
    if ($play_result === 'DRAW'){
        playGame();
    }
}

// じゃんけんを開始
function playGame(){
    $arr_hands = getHands();
    $judgement_result = judgeHands($arr_hands);
    putResult($judgement_result);
    askPlayGameAgain();
}

// 再度プレイするか確認
function askPlayGameAgain() {
    echo PHP_EOL . '再度じゃんけんで勝負しますか？ 1:はい, 2:いいえ >>> ';   
    $input_re_game = trim(fgets(STDIN));

    if ($input_re_game == 2 ) {
        endGame();
    } elseif ( $input_re_game == 1 ) {
        playGame();
    }
}

// プレイ開始
playGame();

// プレイ終了
function endGame() {
    echo PHP_EOL . 'じゃんけんを終了します。';
    exit; // スクリプトの実行を終了する
}
