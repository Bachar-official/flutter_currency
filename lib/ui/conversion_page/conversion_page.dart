import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/view_model/conversion_page_view_model.dart';
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
                  const Icon(Icons.arrow_left),
                  const Icon(Icons.money),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        onChanged: model.setAmount,
                      ),
                    ),
                  ),
                  FlexibleAutocomplete(
                      flex: 2,
                      key: sourceKey,
                      value: model.source,
                      currencies: model.currencies,
                      onSelected: model.onSourceSelected),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.money),
                  const Icon(Icons.arrow_right),
                  FlexibleAutocomplete(
                      key: destinationKey,
                      value: model.destination,
                      currencies: model.currencies,
                      onSelected: model.onDestinationSelected),
                ],
              ),
              ElevatedButton(
                  onPressed: model.convert, child: const Text('Convert')),
              const Spacer(flex: 1),
              model.pair.price != 0
                  ? Flexible(
                      flex: 2,
                      child: ConvertResult(
                          pair: model.pair,
                          amount: model.amount,
                          isLoading: model.isLoading),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}
