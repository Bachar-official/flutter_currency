import 'package:flutter/material.dart';
import 'package:flutter_currency/entities/currency_pair.dart';

class ConvertResult extends StatelessWidget {
  final CurrencyPair pair;
  final num amount;
  final bool isLoading;

  const ConvertResult(
      {Key? key,
      required this.pair,
      required this.amount,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle currencyStyle = const TextStyle(fontSize: 50);
    BoxFit fit = BoxFit.fitWidth;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                FittedBox(
                    fit: fit,
                    child:
                        Text('$amount ${pair.source}', style: currencyStyle)),
                const Text('is', style: TextStyle(fontSize: 30)),
                FittedBox(
                    fit: fit,
                    child: Text('${pair.price * amount} ${pair.destination}',
                        style: currencyStyle))
              ],
            ),
          );
  }
}
