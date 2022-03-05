import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_currency/entities/currency.dart';

import '../../constants/currency_dictionary.dart';

class ConversionPageViewModel extends ChangeNotifier {
  late Dio _dio;
  String _baseCurrency = 'RUB';
  String _destinationCurrency = 'USD';
  bool _isLoading = false;

  ConversionPageViewModel() {
    _dio = Dio();
  }

  bool get isLoading => _isLoading;
  String get baseCurrency => _baseCurrency;
  String get destinationCurrency => _destinationCurrency;

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void setBaseCurrency(String currency) {
    _baseCurrency = currency;
  }

  void setDestinationCurrency(String currency) {
    _destinationCurrency = currency;
  }

  String displayCurrencyOption(MapEntry<String, String> entry) {
    return currencyDictionary.entries.where((element) =>
    element.key == entry.key).first.value;
  }

  FutureOr<Iterable<MapEntry<String, String>>> currencyOptionBuilder
      (TextEditingValue value) {
    return currencyDictionary.entries
        .where((element) =>
        element.value.toLowerCase().startsWith(value.text.toLowerCase()))
        .toList();
  }
}