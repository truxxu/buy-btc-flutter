import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../organisms/chart.dart';

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
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(15),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Text(parsedDate),
                        const Text(
                          "35.5K",
                          style: TextStyle(
                            fontSize: 70,
                            color: Colors.amber,
                          ),
                        ),
                        const Text('BTC/USD')
                      ],
                    ),
                  ),
                ),
                const Chart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
