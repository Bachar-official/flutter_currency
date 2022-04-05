class Currency {
  late String name;
  late String id;
  Currency({required this.name, required this.id});

  factory Currency.fromJson(MapEntry<String, dynamic> json) =>
      Currency(name: json.key, id: json.value);

  @override
  String toString() {
    return '$name ($id)';
  }
}