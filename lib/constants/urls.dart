import 'package:flutter/material.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class Urls {
  static const _baseUrl = 'https://free.currconv.com/api/v7';

  static Future<String> getApiKey() async {
    return await rootBundle.loadString('assets/api_key.txt');
  }

  static Future<String> getCurrencies() async {
    String apiKey = await getApiKey();
    return '$_baseUrl/currencies?apiKey=$apiKey';
  }
}


