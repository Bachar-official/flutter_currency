class Currency {
  late String name;
  late String id;
  Currency({required this.name, required this.id});

  factory Currency.fromJson(MapEntry<String, dynamic> json) =>
      Currency(name: json.value['description'], id: json.value['code']);

  @override
  String toString() {
    return '$name ($id)';
  }
}