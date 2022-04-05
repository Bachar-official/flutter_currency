import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:flutter_currency/entities/daily_rate.dart';

class ListPageViewModel extends ChangeNotifier {
  Currency _baseCurrency = Currency(name: 'Russian Ruble', id:'RUB');
  bool _isLoading = false;
  List<Rate> _rates = [];
  List<Currency> _currencies = [];
  late final NetRepository _repository;
  late final void Function(Color, String) _showNotification;

  ListPageViewModel() {
    _repository = NetRepository(dio: Dio());
    _getCurrencies();
  }

  List<Currency> get currencies => _currencies;
  Currency get baseCurrency => _baseCurrency;
  bool get isLoading => _isLoading;
  List<Rate> get rates => _rates;

  void setShowNotification(void Function(Color, String) callback) {
    _showNotification = callback;
  }

  void _setIsLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _getCurrencies() async {
    _setIsLoading();
    try {
      _currencies = await _repository.getCurrencies();
    } catch(e) {
      _showNotification(Colors.red, 'ERROR: ${e.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }

  void setBaseCurrency(Currency newCurrency) {
    _baseCurrency = newCurrency;
    notifyListeners();
  }

  void _findRateNames() {
    for (Currency currency in _currencies) {
      for (Rate rate in _rates) {
        if (rate.id == currency.id) {
          rate.setName(currency.name!);
        }
      }
    }
  }

  void getLatestRates() async {
    _setIsLoading();
    try {
      _rates = await _repository.getLatestRate(baseCurrency);
      _findRateNames();
    } catch(e) {
      _showNotification(Colors.red, 'ERROR: ${e.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }
}