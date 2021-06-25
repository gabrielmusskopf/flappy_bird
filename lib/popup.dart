import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPopup extends StatelessWidget {
  MyPopup(this.score);

  final score;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.yellow.shade200,
            border: Border.all(width: 5, color: Colors.yellow.shade900),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Text(
                "FIM DE JOGO",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 50,
              child: Text(
                'SCORE: $score',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 30,
              child: Text(
                'PRESSIONE PARA SEGUIR',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ));
  }
}
