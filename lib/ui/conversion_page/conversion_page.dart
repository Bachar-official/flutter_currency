import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/constants/currency_dictionary.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/domain/view_model/conversion_page_view_model.dart';
import 'package:flutter_currency/entities/currency.dart';
import 'package:flutter_currency/ui/conversion_page/components/convert_result.dart';
import 'package:flutter_currency/ui/conversion_page/components/flexible_autocomplete.dart';
import 'package:provider/provider.dart';

class ConversionPage extends StatelessWidget {
  const ConversionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showNotification(Color color, String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        content: Text(message),
      ));
    }
    return Consumer<ConversionPageViewModel>(
      builder: (context, model, child) {
        Key sourceKey = UniqueKey();
        Key destinationKey = UniqueKey();
        TextEditingController amountController =
            TextEditingController(text: model.amount.toString());
        model.setCallback(showNotification);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.repeat),
            tooltip: 'Swap currencies',
            onPressed: model.swapCurrencies,
          ),
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
                  FlexibleAutocomplete(
                      value: model.source,
                      currencies: model.currencies,
                      onSelected: model.onSourceSelected),
                ],
              ),
              Row(
                children: [
                  const Text('I want'),
                  FlexibleAutocomplete(
                      value: model.destination,
                      currencies: model.currencies,
                      onSelected: model.onDestinationSelected),
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
