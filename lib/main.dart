import 'dart:async';

import 'package:flutter/material.dart';

import 'organisms/bottom.dart';
import 'pages/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isLoading = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer(
      const Duration(seconds: 2),
      () {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

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
      home: _isLoading ? const Splash() : const Bottom(),
    );
  }
}
