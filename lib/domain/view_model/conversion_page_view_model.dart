import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:flutter_currency/entities/currency_pair.dart';

class ConversionPageViewModel extends ChangeNotifier {
  late Dio _dio;
  late NetRepository _repository;
  late void Function(Color, String) _showNotification;

  num _amount = 1;
  bool _isLoading = false;
  List<Currency> _list = [];
  Currency _source = Currency(name: 'Russian ruble', id: 'RUB');
  Currency _destination = Currency(name: 'United States dollar', id: 'USD');
  late CurrencyPair pair;

  ConversionPageViewModel() {
    _dio = Dio();
    _repository = NetRepository(dio: _dio);
    pair = CurrencyPair(source: _source, destination: _destination, price: 0);
    getCurrencies();
  }

  Currency get source => _source;
  Currency get destination => _destination;
  bool get isLoading => _isLoading;
  num get amount => _amount;
  List<Currency> get currencies => _list;

  void onSourceSelected(Currency newCurrency) {
    _source = newCurrency;
    notifyListeners();
  }

  void onDestinationSelected(Currency newCurrency) {
    _destination = newCurrency;
    notifyListeners();
  }

  void setCallback(void Function(Color, String) callback) {
    _showNotification = callback;
  }

  void _setLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void swapCurrencies() {
    Currency temp = _source;
    _source = _destination;
    _destination = temp;
    notifyListeners();
  }

  void getCurrencies() async {
    _setLoading();
    try {
      _list = await _repository.getCurrencies();
      _isLoading = false;
    } catch(e) {
      _showNotification(Colors.red, 'ERROR: ${e.toString()}');
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
    try {
      pair = await _repository.convert(_source, _destination);
    } catch(e) {
      _showNotification(Colors.red, 'ERROR: ${e.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }
}