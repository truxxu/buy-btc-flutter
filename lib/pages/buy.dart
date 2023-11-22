import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class Buy extends StatelessWidget {
  const Buy({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: BuyForm(),
        ),
      ),
    );
  }
}

class BuyForm extends StatefulWidget {
  const BuyForm({
    super.key,
  });

  @override
  State<BuyForm> createState() => _BuyFormState();
}

class _BuyFormState extends State<BuyForm> {
  final _formKey = GlobalKey<FormState>();

  String? _validationError;
  bool get _showError => _validationError != null;
  final priceController = TextEditingController();

  String? Function(String?)? get validator => (value) {
        if (value == null || value.isEmpty) {
          return 'error';
        }
        return null;
      };

  @override
  Widget build(BuildContext context) {
    var price = "35500.0";
    var inputValue =
        priceController.text.isNotEmpty ? priceController.text : "0";
    var computedAmount = (Decimal.parse(inputValue) * Decimal.parse(price));

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter the amount of BTC to buy',
          ),
          TextFormField(
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
              "Please enter a valid amount",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                debugPrint('success!');
              }
            },
            child: const Text("Buy"),
          ),
        ],
      ),
    );
  }
}
