import 'package:flutter/material.dart';

class Buy extends StatelessWidget {
  const Buy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter the amount ot buy',
              ),
              TextFormField(
                showCursor: false,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 70, color: Colors.amberAccent),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "0",
                ),
              ),
              const Text(
                'approx. 1,200 USD',
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Buy"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
