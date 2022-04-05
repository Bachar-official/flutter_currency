class Rate {
  late final String id;
  late final num price;
  String? name;

  Rate({required this.id, required this.price});

  void setName(String currencyName) {
    name = currencyName;
  }

  factory Rate.fromJson(MapEntry<String, dynamic> json) =>
      Rate(id: json.key, price: json.value);
}
