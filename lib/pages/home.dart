import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../organisms/chart.dart';
import '../models/price.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                  return Content(price: snapshot.data!.price);
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

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.price,
  });

  final String price;

  @override
  Widget build(BuildContext context) {
    double test = int.parse(price) / int.parse('1000');
    var now = DateTime.now();
    var parsedDate = DateFormat.yMMMMEEEEd().format(now);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Text(
                  '${test.toStringAsFixed(1)}K',
                  style: const TextStyle(
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
    );
  }
}
