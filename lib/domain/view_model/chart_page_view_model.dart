import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:flutter_currency/entities/history_rate.dart';

class ChartPageViewModel extends ChangeNotifier {
  late final NetRepository _repository;
  late final void Function(Color, String) _showNotification;

  bool _isLoading = false;
  DateTime _fromDate = DateTime.now().subtract(const Duration(days: 366));
  Currency _sourceCurrency = Currency(id: 'USD', name: 'United States Dollar');
  Currency _destinationCurrency = Currency(id: 'RUB', name: 'Russian Ruble');
  List<HistoryRate> _rates = [];
  List<Currency> _currencies = [];

  ChartPageViewModel() {
    _repository = NetRepository(dio: Dio());
    _getCurrencies();
  }

  bool get isLoading => _isLoading;
  Currency get sourceCurrency => _sourceCurrency;
  Currency get destinationCurrency => _destinationCurrency;
  DateTime get fromDate => _fromDate;
  List<HistoryRate> get rates => _rates;

  void setNotification(void Function(Color, String) callback) {
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

  void setDate(DateTime newDate) {
    if (DateTime.now().difference(newDate) > const Duration(days: 366)) {
      _showNotification(Colors.yellow, 'Only 366 days long history available!');
    } else {
      _fromDate = newDate;
    }
    notifyListeners();
  }

  void setSourceCurrency(Currency newCurrency) {
    _sourceCurrency = newCurrency;
    notifyListeners();
  }

  void setDestinationCurrency(Currency newCurrency) {
    _destinationCurrency = newCurrency;
    notifyListeners();
  }

  void getHistoricalData() {
    //TODO: implement
  }
}