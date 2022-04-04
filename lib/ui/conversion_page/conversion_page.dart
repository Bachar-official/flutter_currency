import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/constants/currency_dictionary.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/domain/view_model/conversion_page_view_model.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:flutter_currency/ui/conversion_page/components/convert_result.dart';
import 'package:provider/provider.dart';

class ConversionPage extends StatelessWidget {
  const ConversionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConversionPageViewModel>(
      builder: (context, model, child) {
        TextEditingController amountController =
            TextEditingController(text: model.amount.toString());
        return Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  const Text('I have'),
                  Flexible(
                    child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      onChanged: model.setAmount,
                    ),
                  ),
                  Flexible(
                    child: Autocomplete<Currency>(
                      initialValue:
                          TextEditingValue(text: model.source.toString()),
                      optionsBuilder: (TextEditingValue value) =>
                          model.currencies.where((currency) => currency.name
                              .toLowerCase()
                              .startsWith(value.text.toLowerCase())),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const Text('I want'),
                  Flexible(
                    child: Autocomplete<Currency>(
                      initialValue:
                          TextEditingValue(text: model.destination.toString()),
                      optionsBuilder: (TextEditingValue value) =>
                          model.currencies.where((currency) => currency.name
                              .toLowerCase()
                              .startsWith(value.text.toLowerCase())),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: model.convert, child: const Text('Convert')),
              model.pair.price != 0
                  ? ConvertResult(
                      pair: model.pair,
                      amount: model.amount,
                      isLoading: model.isLoading)
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}
