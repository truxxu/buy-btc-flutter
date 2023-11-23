import 'dart:async';

import 'package:flutter/material.dart';

class Response extends StatefulWidget {
  const Response({super.key});

  @override
  State<Response> createState() => _ResponseState();
}

class _ResponseState extends State<Response> {
  bool _isLoading = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer(
      const Duration(seconds: 3),
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : const Success(),
          ),
        ),
      ),
    );
  }
}

class Success extends StatelessWidget {
  const Success({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
