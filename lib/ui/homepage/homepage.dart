import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';

import '../../constants/currency_dictionary.dart';
import '../../entities/currency.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String query = '';

  void onChangeQuery(String? value) {
    if (value != null) {
      setState(() {
        query = value;
      });
    }
  }

  List<DropdownMenuItem<String>> getCurrencies() {
    return currencyDictionary.values.map((currency) => DropdownMenuItem<String>(
      value: currency,
      child: Text(currency)
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    Currency currency = Currency(name: 'RUB', price: 0);
    NetRepository repository = NetRepository(dio: Dio());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          child: const Text('Get'),
          onPressed: () async {
            var currencies = await repository.getHistoricalCurrency(
                currency: currency,
                from: DateTime.parse('2020-01-01'),
                to: DateTime.parse('2022-01-01'));
          }
        ),
      )
    );
  }
}