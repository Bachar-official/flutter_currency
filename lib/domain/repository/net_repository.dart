import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_currency/constants/urls.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:flutter_currency/entities/daily_currency.dart';

class NetRepository {
  late final Dio dio;

  NetRepository({required this.dio});

  Future<List<Currency>> getLatestCurrency(Currency currency) async {
    var response = await dio.get(Urls.getLatestCurrencyWithBase(currency));
    if (response.statusCode == 200) {
      var map = response.data['data'] as Map;
      return map.entries.map((element) => Currency(name: element.key, price: element.value)).toList();
    }
    return [];
  }

  Future<List<DailyCurrency>> getHistoricalCurrency({
    required Currency currency,
    required DateTime from,
    required DateTime to}) async {
    var response = await dio.get(Urls.getHistoricalCurrency(
        currency: currency,
        from: from,
        to: to
    ));
    if (response.statusCode == 200) {
      var map = response.data['data'] as Map;
      return map.entries.map((element) => DailyCurrency.parsed(
          strDate: element.key,
          json: element.value
      )).toList();
    }
    return [];
  }
}