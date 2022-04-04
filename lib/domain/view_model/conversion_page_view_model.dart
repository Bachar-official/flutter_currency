import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:flutter_currency/entities/currency_pair.dart';

class ConversionPageViewModel extends ChangeNotifier {
  late Dio _dio;
  late NetRepository _repository;

  num _amount = 1;
  bool _isLoading = false;
  List<Currency> _list = [];
  Currency source = Currency(name: 'Russian ruble', id: 'RUB');
  Currency destination = Currency(name: 'United States dollar', id: 'USD');
  late CurrencyPair pair;

  ConversionPageViewModel() {
    _dio = Dio();
    _repository = NetRepository(dio: _dio);
    pair = CurrencyPair(source: source, destination: destination, price: 0);
    getCurrencies();
  }

  bool get isLoading => _isLoading;
  num get amount => _amount;
  List<Currency> get currencies => _list;

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void getCurrencies() async {
    _setLoading();
    try {
      _list = await _repository.getCurrencies();
      _isLoading = false;
    } catch(e) {
      print(e.toString());
    }
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

  void convert() async {
    _setLoading();
    pair = await _repository.convert(source, destination);
    _isLoading = false;
    notifyListeners();
  }
}