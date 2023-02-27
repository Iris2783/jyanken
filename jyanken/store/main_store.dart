import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const JyankenPage(),
    );
  }
}

class JyankenPage extends StatefulWidget {
  const JyankenPage({super.key});

  @override
  State<JyankenPage> createState() => _JyankenPageState();
}

class _JyankenPageState extends State<JyankenPage> {
  //関数・変数はここから下に記述する
  //関数の作り方は右の通り　[返り値の型] [関数の名前]( [引数の型] [引数の名前] ) { [関数の中で実行する命令];}

  final String goo = '✊'; //✊を変数gooに置き換えている
  final String choki = '✌️'; //✌️を変数chokiに置き換えている
  final String par = '✋'; //✋を変数parに置き換えている

  int drawCount = 0; //int型(整数を入れることができる型)の変数drawCountを設定し、引き分けの回数をカウントしている
  int winCount = 0; //int型(整数を入れることができる型)の変数winCountを設定し、勝ちの回数をカウントしている
  int loseCount = 0; //int型(整数を入れることができる型)の変数loseCountを設定し、負けの回数をカウントしている
  int gameCount = 0; //int型(整数を入れることができる型)の変数gameCountを設定し、試合の回数をカウントしている

  String myHand = '✊'; //String型の変数myHandに＝以下の値を代入している　今入れている✊は初期値となり、一番最初に表示されるもの。
  String computerHand = '✊'; //String型の変数computerHandに＝以下の値を代入している　今入れている✊は初期値となり一番最初に表示されるもの
  String result = '引き分け'; //String型の変数resultに＝以下の値を代入している　今入れている引き分けは初期値となり一番最初に表示されるもの
  String finish = '勝敗はいかに...?';
  String showResult = '???';

  void selectHand(String selectedHand) {
    //関数selectHandが実行されると以下の処理が実行される
    myHand = selectedHand; //selectHandにString型の引数(代入される値で、今回のケースでは✊、✌️、✋)が与えられると、myHandに代入されて画面に表示される
    generateComputerHand(); //それとほぼ同時にgenerateComputerHand関数の処理が実行される。処理内容は以下の通り。
    judge(); //myHandとgeneratedComputerHandの勝敗をif文で記述してい関数judgeの処理をここで実行
    displayGame();
    resetGame();
    setState(() {});
  }

  void generateComputerHand() {
    //generateComputerHand関数が実行されると以下の処理が実行される
    final randomNumber = Random().nextInt(3); //randomNumberにランダムに生成した整数0,1,2を代入する　final型の変数は一度代入すると変更できないので処理速度が速くなる
    computerHand = randomNumberToHand(randomNumber); //関数randomNumberToHandに引数(このケースではrandomNumberに整数0,1,2のいづれかが与えられる)が与えられると以下の処理が実行される
  }

  String randomNumberToHand(int randomNumber) {
    //関数randomNumberToHandが実行されると以下の処理が実行される
    switch (randomNumber) {
      //関数randomNumberToHandに引数(今回のケースではrandomNumberに整数0,1,2のいづれかが与えられる)が与えられると以下の処理が実行される
      case 0: //randomNumberの値が0であった場合は✊に変換(スイッチ)される処理
        return '✊';
      case 1: //randomNumberの値が1であった場合は✌️に変換(スイッチ)される処理
        return '✌️';
      case 2: //randomNumberの値が2であった場合は✋に変換(スイッチ)される処理
        return '✋';
      default: //randomNumberの値がもし上記以外であった場合はデフォルトで✊に変換(スイッチ)する処理
        return '✊';
    }
  }

  void judge() {
    if (myHand == computerHand) {
      result = '引き分け';
      drawCount += 1;
      gameCount += 1;
      print(gameCount);
      // print(drawCount);
    } else if (myHand == 'goo' && computerHand == 'choki' || myHand == 'choki' && computerHand == 'par' || myHand == 'par' && computerHand == 'goo') {
      result = '勝ち';
      winCount += 1;
      gameCount += 1;
      print(gameCount);
      // print(winCount);
    } else {
      result = '負け';
      loseCount += 1;
      gameCount += 1;
      print(gameCount);
      // print(loseCount);
    }
  }

  void displayGame() {
    if (gameCount == 5) {
      finish = '5回戦終了！';
      showResult = '勝ち:$winCount, 負け:$loseCount, 引き分け:$drawCount';
    }
  }

  void resetGame() {
    gameCount = 0;
    winCount = 0;
    loseCount = 0;
    drawCount = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jyanken Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              finish, //変数finishをここに置いておくことで変数に代入される値が表示される
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 10),
            Text(
              showResult, //変数resultをここに置いておくことで変数に代入される値が表示される
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 48),
            Text(
              result, //変数resultをここに置いておくことで変数に代入される値が表示される
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 48),
            Text(
              computerHand, //変数computerHandをここに置いておくことで変数に代入される値が表示される
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 48),
            Text(
              myHand, //変数myHandをここに置いておくことで変数に代入される値が表示される
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, //childrenプロパティにあるウィジェットの余白を均等に並べることができる
              children: [
                ElevatedButton(
                  onPressed: () {
                    // myHand = '✊';
                    // print(myHand);
                    // setState(() {});
                    selectHand('✊'); //関数selectHandに✊を引数として代入し、上記に記載の関数の処理を実行している
                  },
                  child: const Text('✊'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // myHand = '✌️';
                    // print(myHand);
                    // setState(() {});
                    selectHand('✌️'); //関数selectHandに✌️を引数として代入し、上記に記載の関数の処理を実行している
                  },
                  child: const Text('✌️'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // myHand = '✋';
                    // print(myHand);
                    // setState(() {});
                    selectHand('✋'); //関数selectHandに✋を引数として代入し、上記に記載の関数の処理を実行している
                  },
                  child: const Text('✋'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
