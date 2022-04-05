import 'package:dio/dio.dart';
import 'package:flutter_currency/constants/urls.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:flutter_currency/entities/currency_pair.dart';
import 'package:flutter_currency/entities/history_rate.dart';

import '../../entities/daily_rate.dart';

class NetRepository {
  late final Dio dio;

  NetRepository({required this.dio});

  Future<List<Currency>> getCurrencies() async {
    var result = await dio.get(Urls.getCurrencies());
    if (result.statusCode == 200) {
      var map = result.data['symbols'] as Map<String, dynamic>;
      return map.entries.map((element) => Currency.fromJson(element)).toList();
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

  Future<List<HistoryRate>> getHistorical(
      Currency source, Currency destination, DateTime from) async {
    var result = await dio.get(
        Urls.getHistoricalCurrency(source, destination, from, DateTime.now()));
    if (result.statusCode == 200) {
      var map = result.data['rates'] as Map<String, dynamic>;
      return map.entries
          .map((entry) => HistoryRate.fromJson(entry, destination.id))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Rate>> getLatestRate(Currency baseCurrency) async {
    var result = await dio.get(Urls.getLatestRates(baseCurrency));
    if (result.statusCode == 200) {
      var map = result.data['rates'] as Map<String, dynamic>;
      return map.entries.map((entry) => Rate.fromJson(entry)).toList();
    } else {
      return [];
    }
  }
}
