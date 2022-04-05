import 'package:flutter_currency/entities/currency.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

class Urls {
  static const _baseUrl = 'https://api.exchangerate.host';

  static Future<String> getApiKey() async {
    return await rootBundle.loadString('lib/assets/api_key.txt');
  }

  static String getCurrencies() {
    return '$_baseUrl/symbols';
  }

  static String getCurrencyConvert(Currency base, Currency destination) {
    return '$_baseUrl/convert?from=${base.id}'
        '&to=${destination.id}';
  }

  static String getLatestRates(Currency base) {
    return '$_baseUrl/latest?base=${base.id}';
  }

  static String getHistoricalCurrency(
      Currency base, Currency destination, DateTime from, DateTime to) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strFrom = formatter.format(from);
    String strTo = formatter.format(to);
    return '$_baseUrl/timeseries?start_date=$strFrom&end_date=$strTo&base=${base.id}&symbols=${destination.id}';
  }
}
