import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/entities/currency.dart';

import '../../constants/currency_dictionary.dart';

class ConversionPageViewModel extends ChangeNotifier {
  late Dio _dio;
  late NetRepository _repository;
  String _baseCurrency = 'USD';
  String _destinationCurrency = 'RUB';
  num _amount = 1;
  num _multiplier = 0;
  bool _isLoading = false;
  List<Currency> _list = [];

  ConversionPageViewModel() {
    _dio = Dio();
    _repository = NetRepository(dio: _dio);
  }

  bool get isLoading => _isLoading;
  num get amount => _amount;
  num get exchange => _multiplier * _amount;

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void setBaseCurrency(String currency) {
    _baseCurrency = currency;
    notifyListeners();
  }

  void setDestinationCurrency(String currency) {
    _destinationCurrency = currency;
    notifyListeners();
  }

  void setAmount(String amount) {
    num? newAmount = num.tryParse(amount);
    if (newAmount != null) {
      _amount = newAmount;
    } else {
      _amount = 1;
      notifyListeners();
    }
  }

  FutureOr<Iterable<MapEntry<String, String>>> currencyOptionBuilder
      (TextEditingValue value) {
    return currencyDictionary.entries
        .where((element) =>
        element.value.toLowerCase().contains(value.text.toLowerCase()))
        .toList();
  }
}