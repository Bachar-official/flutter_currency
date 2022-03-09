import 'package:flutter_currency/entities/currency.dart';
import 'package:intl/intl.dart';

class Urls {
  static const _baseUrl = 'https://api.currencyapi.com/v3';
  static const _apiKey = 'f0f26a90-9aba-11ec-841c-699a0d7f059c';

  static String getLatestCurrencyWithBase(String currency) {
    return '$_baseUrl/latest?apikey=$_apiKey&base_currency=$currency';
  }

  static String getHistoricalCurrency({
    required Currency currency,
    required DateTime from,
    required DateTime to
  }) {
    return '$_baseUrl/historical?apikey=$_apiKey&base_currency=${currency.name}'
        '&date_from=${DateFormat('yyyy-MM-dd').format(from)}'
        '&date_to=${DateFormat('yyyy-MM-dd').format(to)}';
  }
}


