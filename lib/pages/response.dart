import 'package:flutter/material.dart';

class Response extends StatelessWidget {
  const Response({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Your bitcoin is on the way',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 20),
                ),
                const Icon(
                  Icons.verified,
                  color: Colors.greenAccent,
                  size: 200,
                ),
                ElevatedButton(
                  child: const Text('Return'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
