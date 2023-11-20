import 'package:flutter/material.dart';

import 'organisms/bottom.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Buy BTC!",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          background: Colors.black54,
          brightness: Brightness.dark,
        ),
      ),
      home: const Bottom(),
    );
  }
}
