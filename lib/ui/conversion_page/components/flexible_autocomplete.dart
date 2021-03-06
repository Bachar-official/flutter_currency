import 'package:flutter/material.dart';

import '../../../entities/currency.dart';

class FlexibleAutocomplete extends StatelessWidget {
  final Currency value;
  final List<Currency> currencies;
  final void Function(Currency) onSelected;
  final int? flex;

  const FlexibleAutocomplete({
    Key? key,
    this.flex,
    required this.value,
    required this.currencies,
    required this.onSelected
  }) : super(key: key);

  @override
  Widget build(context) => Flexible(
    flex: flex != null ? flex! : 1,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Autocomplete<Currency>(
        key: key,
        initialValue:
        TextEditingValue(text: value.toString()),
        optionsBuilder: (TextEditingValue value) =>
            currencies.where((currency) => currency.name!
                .toLowerCase()
                .contains(value.text.toLowerCase())),
        onSelected: onSelected,
        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
          return TextFormField(
            focusNode: focusNode,
            controller: textEditingController,
            onFieldSubmitted: (String value) => onFieldSubmitted,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: textEditingController.clear,
              ),
            ),
          );
        },
      ),
    ),
  );
}