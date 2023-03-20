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
  int drawCount = 0;
  int winCount = 0;
  int loseCount = 0;
  int gameCount = 0;

  String myHand = '✊';
  String computerHand = '✊';
  String result = '引き分け';
  String finish = '勝敗はいかに...?';
  String showResult = '???';

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    generateComputerHand();
    judge();
    displayGame();
    setState(() {});
  }

  void generateComputerHand() {
    final randomNumber = Random().nextInt(3);
    computerHand = randomNumberToHand(randomNumber);
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '✊';
      case 1:
        return '✌️';
      case 2:
        return '✋';
      default:
        return '✊';
    }
  }

  void judge() {
    /// gameCount += 1は全てのパターンで発生するので、
    gameCount += 1; // if文で分岐する前に書いてしまった方が良い
    if (myHand == computerHand) {
      result = '引き分け';
    } else if ((myHand == '✊' && computerHand == '✌️') ||
        (myHand == '✌️' && computerHand == '✋') ||
        (myHand == '✋' && computerHand == '✊')) {
      result = '勝ち';
      winCount += 1;
    } else {
      result = '負け';
      loseCount += 1;
    }
  }

  void displayGame() {
    if (gameCount == 5) {
      finish = '5回戦終了！';
      showResult = '勝ち:$winCount, 負け:$loseCount, 引き分け:$drawCount';
    }
  }

  void resetGame() {
    /// 5回戦終わったあとも勝負を続けることができてしまうので、
    /// gameCount が 5より大きくなってしまう場合がある。
    /// そのため、この if (gameCount == 5) の条件はなくてもいいかもしれない。
    if (gameCount == 5) {
      finish = '勝敗はいかに...?';
      showResult = '???';
      gameCount = 0;
      winCount = 0;
      loseCount = 0;
      drawCount = 0;
      setState(() {});
    }
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
              finish,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 10),
            Text(
              showResult,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 48),
            Text(
              result,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 48),
            Text(
              computerHand,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 48),
            Text(
              myHand,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    selectHand('✊');
                  },
                  child: const Text('✊'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand('✌️');
                  },
                  child: const Text('✌️'),
                ),
                ElevatedButton(
                  onPressed: () {
                    selectHand('✋');
                  },
                  child: const Text('✋'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                resetGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('更新'),
            ),
          ],
        ),
      ),
    );
  }
}
