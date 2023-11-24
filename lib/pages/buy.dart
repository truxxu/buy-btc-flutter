import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/price.dart';
import '../organisms/buy_form.dart';

class Buy extends StatefulWidget {
  const Buy({super.key});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  late Future<Price> futurePrice;

  Future<Price> fetchPrice() async {
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd'));

    if (response.statusCode == 200) {
      return Price.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to fetch price');
    }
  }

  @override
  void initState() {
    super.initState();
    futurePrice = fetchPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: FutureBuilder<Price>(
              future: futurePrice,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return BuyForm(price: snapshot.data!.price);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
