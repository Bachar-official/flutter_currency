import 'currency.dart';

class CurrencyPair {
  late final Currency source;
  late final Currency destination;
  late final num price;

  CurrencyPair(
      {required this.source, required this.destination, required this.price});
}
