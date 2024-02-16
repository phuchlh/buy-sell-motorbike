import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WarningLottie extends StatelessWidget {
  const WarningLottie({super.key, required this.firstLine, required this.secondLine});
  final String firstLine;
  final String secondLine;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
        width: 300,
        height: 300,
        child: Column(
          children: [
            Lottie.asset(
              'assets/images/warning.json',
              width: 150,
              height: 150,
              fit: BoxFit.fill,
            ),
            Text(
              "$firstLine",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              secondLine,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
