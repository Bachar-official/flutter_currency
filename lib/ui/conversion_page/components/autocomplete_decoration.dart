import 'dart:async';

import 'package:flutter/material.dart';

class AutocompleteWithDecoration<K,V> extends StatelessWidget {
  final String Function(MapEntry<K,V>) displayCurrencyOption;
  final FutureOr<Iterable<MapEntry<K,V>>> Function(TextEditingValue) currencyOptionBuilder;
  final void Function(MapEntry<K,V>) onSelected;
  final void Function(String) setCurrency;
  final String? hintText;

  const AutocompleteWithDecoration({
    required this.displayCurrencyOption,
    required this.currencyOptionBuilder,
    required this.onSelected,
    required this.setCurrency,
    this.hintText, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
          //contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 4),
          helperText: hintText,
      ),
      child: Autocomplete<MapEntry<K, V>>(
        displayStringForOption: displayCurrencyOption,
        optionsBuilder: currencyOptionBuilder,
        onSelected: (currency) {
          setCurrency(currency.key.toString().toUpperCase());
        },
      ),
    );
  }
}