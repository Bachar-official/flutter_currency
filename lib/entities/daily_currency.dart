import 'package:flutter_currency/entities/currency.dart';

class DailyCurrency {
  late DateTime date;
  late List<Currency> list;

  DailyCurrency({required this.date, required this.list});
  DailyCurrency.parsed({required String strDate, required Map<dynamic, dynamic> json}) {
    date = DateTime.parse(strDate);
    list = _getListFromMap(json);
  }

  List<Currency> _getListFromMap(Map<dynamic, dynamic> json) {
    return json.entries.map((record) =>
        Currency(
            name: record.key,
            price: record.value
        )).toList();
  }
}