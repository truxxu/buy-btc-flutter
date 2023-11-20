import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var parsedDate = DateFormat.yMMMMEEEEd().format(now);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                Text(
                  parsedDate,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    // fontSize: 50,
                    color: Colors.amber,
                  ),
                ),
                const Text(
                  'BTC/USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.amber,
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(15),
                  elevation: 10,
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "35.5K",
                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
