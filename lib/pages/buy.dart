import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'response.dart';
import '../models/price.dart';

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

class BuyForm extends StatefulWidget {
  const BuyForm({super.key, required this.price});

  final String price;

  @override
  State<BuyForm> createState() => _BuyFormState();
}

class _BuyFormState extends State<BuyForm> {
  final _formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  Decimal _computed = Decimal.parse('0');

  @override
  Widget build(BuildContext context) {
    String inputValue = priceController.text;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter the amount of BTC to buy',
          ),
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
              FilteringTextInputFormatter.deny(','),
            ],
            controller: priceController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid amount';
              }
              if (Decimal.parse(value) < Decimal.parse("0.001")) {
                return 'Min. order 0.001BTC';
              }
              if (Decimal.parse(value) > Decimal.parse('5')) {
                return 'Max. order 5 BTC';
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(
                  () {
                    _computed =
                        Decimal.parse(value) * Decimal.parse(widget.price);
                  },
                );
                return;
              }
              setState(() {
                _computed = Decimal.parse('0');
              });
            },
            showCursor: false,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 70,
              color: Colors.amberAccent,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "0",
            ),
          ),
          Text(
            '~ $_computed USD',
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showModal(
                  context,
                  inputValue,
                  _computed,
                );
              }
            },
            child: const Text("Buy"),
          ),
        ],
      ),
    );
  }

  Future<void> showModal(
      BuildContext context, String inputValue, Decimal computedAmount) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 350,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const Text(
                  'Please verify your order',
                ),
                Text(
                  'Amount: $inputValue BTC \n Total: $computedAmount USD',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                ElevatedButton(
                  child: const Text('Accept'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Response()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
