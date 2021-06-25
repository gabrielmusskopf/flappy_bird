import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/popup.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  double velocity = 2.5;
  bool hasStarted = false;
  bool hasEnded = false;
  int score = 0;
  int best = 0;

  static double barrierBistance = 1.5;
  static double barrierXOne = barrierBistance;
  double barrierXTwo = barrierXOne + barrierBistance;
  double barrierYOneTop = 170;
  double barrierYOneBottom = 170;
  double barrierYTwoTop = 120;
  double barrierYTwoBottom = 230;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    hasStarted = true;
    hasEnded = false;
    score = 0;

    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + velocity * time;
      setState(() {
        birdYAxis = initialHeight - height;
        barrierXOne -= 0.05;
        barrierXTwo -= 0.05;
      });

      setState(() {
        if (barrierXOne > -0.05 && barrierXOne < 0.05 ||
            barrierXTwo > -0.05 && barrierXTwo < 0.05) {
          score += 1;
        }
      });

      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3.5;
        } else {
          barrierXOne -= 0.05;
        }
      });

      setState(() {
        if (barrierXTwo < -2) {
          barrierXTwo += 3.5;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (birdYAxis > 1) {
        timer.cancel();
        endGame();
      }
    });
  }

  void endGame() {
    hasStarted = false;
    hasEnded = true;

    if (score > best) {
      best = score;
    }
  }

  void restartGame() {
    setState(() {
      birdYAxis = 0;
      time = 0;
      height = 0;
      initialHeight = 0;
      hasStarted = false;
      hasEnded = false;
      barrierXOne = barrierBistance;
      barrierXTwo = barrierXOne + barrierBistance;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (hasStarted && !hasEnded) {
          jump();
        } else if (hasEnded) {
          restartGame();
        } else {
          startGame();
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                AnimatedContainer(
                  alignment: Alignment(0, birdYAxis),
                  duration: Duration(milliseconds: 0),
                  color: Colors.blue,
                  child: MyBird(),
                ),
                Container(
                  alignment: Alignment(0, -0.3),
                  child: hasStarted
                      ? Text("")
                      : Text(
                          "T A P  T O  P L A Y",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXOne, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: barrierYOneBottom,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXOne, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: barrierYOneTop,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXTwo, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: barrierYTwoTop,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierXTwo, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: barrierYTwoBottom,
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    child: hasEnded ? MyPopup(score) : Text("")),
              ],
            ),
          ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
                  color: Colors.brown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SCORE",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            score.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "BEST",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            best.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          )
                        ],
                      )
                    ],
                  )))
        ],
      )),
    );
  }
}
