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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                onChanged: (value) => model.setAmount(value),
                                initialValue: model.amount.toString(),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration: const InputDecoration(
                                    helperText: 'Количество валюты'),
                              ),
                            ),
                            Flexible(
                              child: AutocompleteWithDecoration<String, String>(
                                textController: model.baseController,
                                currencyOptionBuilder:
                                    model.currencyOptionBuilder,
                                displayCurrencyOption:
                                    model.displayCurrencyOption,
                                setCurrency: model.setBaseCurrency,
                                onSelected: (currency) {
                                  model.setBaseCurrency(currency.key);
                                },
                                hintText: 'Исходная валюта',
                                value: model.baseCurrency,
                              ),
                            )
                          ],
                        ),
                        AutocompleteWithDecoration<String, String>(
                          textController: model.destinationController,
                          currencyOptionBuilder: model.currencyOptionBuilder,
                          displayCurrencyOption: model.displayCurrencyOption,
                          setCurrency: model.setDestinationCurrency,
                          onSelected: (currency) {
                            model.setDestinationCurrency(currency.key);
                          },
                          hintText: 'Желаемая валюта',
                          value: model.destinationCurrency,
                        ),
                      ],
                    ),
                  ),
                  IconButton(onPressed: model.swapCurrencies, icon: const Icon(Icons.repeat))
                ],
              ),
              ElevatedButton(
                  onPressed: model.getLatestCurrency,
                  child: const Text('Конвертировать')),
              model.exchange == 0
                  ? const Text('Ещё не искали')
                  : Text(model.exchange.toString())
            ],
          ),
        ),
      ),
    );
  }
}
