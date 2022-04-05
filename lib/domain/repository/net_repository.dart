import 'package:dio/dio.dart';
import 'package:flutter_currency/constants/urls.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:flutter_currency/entities/currency_pair.dart';

class NetRepository {
  late final Dio dio;

  NetRepository({required this.dio});

  Future<List<Currency>> getCurrencies() async {
    var result = await dio.get(Urls.getCurrencies());
    if (result.statusCode == 200) {
      var map = result.data['symbols'] as Map<String, dynamic>;
      return map.entries.map(
              (element) => Currency.fromJson(element)).toList();
    } else {
      return [];
    }
  }

  Future<CurrencyPair> convert(Currency source, Currency destination) async {
    var result = await dio.get(Urls.getCurrencyConvert(source, destination));
    if (result.statusCode == 200) {
      var map = result.data as Map<String, dynamic>;
      num price = map['result'];
      return CurrencyPair(
          source: source,
          destination: destination,
          price: num.parse(price.toStringAsFixed(3)));
    } else {
      return CurrencyPair(source: source, destination: destination, price: 0);
    }
  }

  Future<void> getHistorical() async {
    var result = await dio.get(await Urls.getHistoricalCurrency(
        Currency(name: '', id: 'USD'), Currency(name: '', id: 'RUB'),
      DateTime(2022, 03, 20), DateTime.now()
    ));
    print(result.data);
  }
}