class Price {
  final String price;

  const Price({required this.price});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      price: json['bitcoin']['usd'].toString(),
    );
  }
}
