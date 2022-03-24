import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_currency/constants/urls.dart';
import 'package:flutter_currency/entities/currency.dart';

class NetRepository {
  late final Dio dio;

  NetRepository({required this.dio});

  Future<List<Currency>> getCurrencies() async {
    var result = await dio.get(await Urls.getCurrencies());
    var map = result.data['results'] as Map<String, dynamic>;
    return map.entries.map(
            (element) => Currency(name: element.value['currencyName'], id: element.value['id'])
    ).toList();
  }

  Future<void> getHistorical() async {
    var result = await dio.get(await Urls.getHistoricalCurrency(
        Currency(name: '', id: 'USD'), Currency(name: '', id: 'RUB'),
      DateTime(2022, 03, 20), DateTime.now()
    ));
    print(result.data);
  }
}