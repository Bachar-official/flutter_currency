class Currency {
  late String name;
  late String id;
  Currency({required this.name, required this.id});

  factory Currency.fromJson(Map<String, dynamic> json) =>
      Currency(name: json['currencyName'], id: json['id']);

  @override
  String toString() {
    return '$name ($id)';
  }
}