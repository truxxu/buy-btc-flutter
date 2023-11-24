class History {
  final int price;
  final List<dynamic> history;

  const History({
    required this.price,
    required this.history,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    final historyData = json['prices'] as List<dynamic>;

    return History(
      price: historyData[30][1],
      history: historyData,
    );
  }
}
