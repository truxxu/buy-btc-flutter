import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.black54,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            'Hello World',
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
