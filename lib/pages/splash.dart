import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Center(
              child: Text(
            'Buy\nBTC',
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 70,
              fontWeight: FontWeight.w600,
            ),
          )),
        ),
      ),
    );
  }
}
