class Currency {
  late String name;
  late String id;
  Currency({required this.name, required this.id});

  @override
  String toString() {
    return 'Currency, name: $name, id: $id';
  }
}