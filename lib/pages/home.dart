import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Text(
                'Hello World',
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Button"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
