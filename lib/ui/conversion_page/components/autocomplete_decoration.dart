import 'dart:async';

import 'package:flutter/material.dart';

class AutocompleteWithDecoration<K,V> extends StatelessWidget {
  final String Function(MapEntry<K,V>) displayCurrencyOption;
  final FutureOr<Iterable<MapEntry<K,V>>> Function(TextEditingValue) currencyOptionBuilder;
  final void Function(MapEntry<K,V>) onSelected;
  final void Function(String) setCurrency;
  final String? hintText;
  final String? value;
  final TextEditingController textController;

  const AutocompleteWithDecoration({
    required this.displayCurrencyOption,
    required this.currencyOptionBuilder,
    required this.onSelected,
    required this.setCurrency,
    required this.textController,
    this.value,
    this.hintText, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        helperText: hintText,
      ),
      child: Autocomplete<MapEntry<K, V>>(
        fieldViewBuilder: (context, controller, node, onFieldSubmitted) =>
        TextField(
          controller: controller,
          focusNode: node,
        ),
        displayStringForOption: displayCurrencyOption,
        optionsBuilder: currencyOptionBuilder,
        onSelected: (currency) {
          setCurrency(currency.key.toString().toUpperCase());
        },
        initialValue: TextEditingValue(text: value!),
      ),
    );
  }
}