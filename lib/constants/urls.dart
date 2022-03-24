import 'package:flutter_currency/entities/currency.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

class Urls {
  static const _baseUrl = 'https://free.currconv.com/api/v7';

  static Future<String> getApiKey() async {
    return await rootBundle.loadString('lib/assets/api_key.txt');
  }

  static Future<String> getCurrencies() async {
    String apiKey = await getApiKey();
    return '$_baseUrl/currencies?apiKey=$apiKey';
  }

  static Future<String> getCurrencyConvert(
      Currency base, Currency destination) async {
    String apiKey = await getApiKey();
    return '$_baseUrl/convert?q=${base.id}_${destination.id}'
        '&compact=ultra&apiKey=$apiKey';
  }

  static Future<String> getHistoricalCurrency(
      Currency base, Currency destination, DateTime from, DateTime to
      ) async {
    String apiKey = await getApiKey();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strFrom = formatter.format(from);
    String strTo = formatter.format(to);
    print('$_baseUrl/convert?q=${base.id}_${destination.id}&compact=ultra'
        '&date=$strFrom&endDate=$strTo&apiKey=$apiKey');
    return '$_baseUrl/convert?q=${base.id}_${destination.id}&compact=ultra'
        '&date=$strFrom&endDate=$strTo&apiKey=$apiKey';
  }
}


