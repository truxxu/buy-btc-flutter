import 'package:flutter/material.dart';

class Buy extends StatelessWidget {
  const Buy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                'Buy page',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
