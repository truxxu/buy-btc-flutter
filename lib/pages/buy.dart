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
  String _price = "";

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

  String? _validationError;
  bool get _showError => _validationError != null;

  String? Function(String?)? get validator => (value) {
        if (value == null || value.isEmpty) {
          return 'error';
        }
        if (Decimal.parse(value) < Decimal.parse("0.001") ||
            Decimal.parse(value) > Decimal.parse('5')) {
          return 'error';
        }
        return null;
      };

  @override
  Widget build(BuildContext context) {
    var inputValue =
        priceController.text.isNotEmpty ? priceController.text : "0";
    var computedAmount =
        (Decimal.parse(inputValue) * Decimal.parse(widget.price));

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
              final error = validator?.call(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  _validationError = error;
                });
              });
              return null;
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
            '~ $computedAmount USD',
          ),
          const SizedBox(
            height: 40,
          ),
          if (_showError)
            const Text(
              "Please enter a valid amount \n Min 0.001, Max 5 BTC",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                showModal(
                  context,
                  inputValue,
                  computedAmount,
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
