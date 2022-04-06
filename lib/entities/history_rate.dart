class HistoryRate {
  late final DateTime date;
  late final num price;

  HistoryRate({
    required this.date,
    required this.price,
  });

  factory HistoryRate.fromJson(
          MapEntry<String, dynamic> json, String currencyId) =>
      HistoryRate(
          date: DateTime.parse(json.key), price: json.value[currencyId]);

  @override
  String toString() => 'Rate, date: $date, price: $price';
}
