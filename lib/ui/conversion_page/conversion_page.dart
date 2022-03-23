import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/constants/currency_dictionary.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/domain/view_model/conversion_page_view_model.dart';
import 'package:provider/provider.dart';

import 'components/autocomplete_decoration.dart';

class ConversionPage extends StatelessWidget {
  const ConversionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NetRepository repository = NetRepository(dio: Dio());
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Пыщь'),
          onPressed: () async {
            var response = await repository.getCurrencies();
            response.forEach(print);
            },
        ),
      ),
    );
  }
}
