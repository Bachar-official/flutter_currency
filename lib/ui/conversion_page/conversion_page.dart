import 'package:flutter/material.dart';
import 'package:flutter_currency/constants/currency_dictionary.dart';
import 'package:flutter_currency/domain/view_model/conversion_page_view_model.dart';
import 'package:provider/provider.dart';

class ConversionPage extends StatelessWidget {
  const ConversionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversionPageViewModel>(
      builder: (context, model, child) => Scaffold(
          body: Center(
        child: Column(
          children: [
            Autocomplete<MapEntry<String, String>>(
              displayStringForOption: model.displayCurrencyOption,
              optionsBuilder: model.currencyOptionBuilder,
              onSelected: (currency) {
                model.setBaseCurrency(currency.key.toUpperCase());
              },
            ),
          ],
        ),
      )),
    );
  }
}
