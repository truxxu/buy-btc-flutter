import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    String txUrl =
        'https://blockstream.info/tx/c732e1e672f25c58af1e5154462022176b68d2e769d53bbb56674bc2c7bf0e30';

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
        TextButton(
          onPressed: () async {
            Uri url = Uri.parse(txUrl);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: const Text('Details'),
        ),
        ElevatedButton(
          child: const Text('Return'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
