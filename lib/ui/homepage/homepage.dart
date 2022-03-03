import 'package:flutter/material.dart';

import '../../constants/currency_dictionary.dart';

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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: DropdownButtonFormField<String>(
          onChanged: (value) => onChangeQuery(value),
          items: getCurrencies(),
          value: currencyDictionary.values.toList()[0],
        ),
      )
    );
  }
}