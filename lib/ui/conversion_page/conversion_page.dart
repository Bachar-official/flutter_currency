import 'package:flutter/material.dart';
import 'package:flutter_currency/constants/currency_dictionary.dart';
import 'package:flutter_currency/domain/view_model/conversion_page_view_model.dart';
import 'package:provider/provider.dart';

import 'components/autocomplete_decoration.dart';

class ConversionPage extends StatelessWidget {
  const ConversionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversionPageViewModel>(
      builder: (context, model, child) => Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      AutocompleteWithDecoration<String, String>(
                        currencyOptionBuilder: model.currencyOptionBuilder,
                        displayCurrencyOption: model.displayCurrencyOption,
                        setCurrency: model.setBaseCurrency,
                        onSelected: (currency) {
                          model.setBaseCurrency(currency.key);
                        },
                        hintText: 'Валюта-источник',
                      ),
                      AutocompleteWithDecoration<String, String>(
                        currencyOptionBuilder: model.currencyOptionBuilder,
                        displayCurrencyOption: model.displayCurrencyOption,
                        setCurrency: model.setDestinationCurrency,
                        onSelected: (currency) {
                          model.setDestinationCurrency(currency.key);
                        },
                        hintText: 'Валюта-приёмник',
                      ),
                    ],
                  ),
                  //IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
                ],
              ),
            ],
          ),
      ),
    );
  }
}
