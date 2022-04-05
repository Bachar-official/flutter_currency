import 'package:flutter/material.dart';

import '../../../entities/currency.dart';

class FlexibleAutocomplete extends StatelessWidget {
  final Currency value;
  final List<Currency> currencies;
  final void Function(Currency) onSelected;

  const FlexibleAutocomplete({
    Key? key,
    required this.value,
    required this.currencies,
    required this.onSelected
  }) : super(key: key);

  @override
  Widget build(context) => Flexible(
    child: Autocomplete<Currency>(
      key: key,
      initialValue:
      TextEditingValue(text: value.toString()),
      optionsBuilder: (TextEditingValue value) =>
          currencies.where((currency) => currency.name
              .toLowerCase()
              .startsWith(value.text.toLowerCase())),
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
  );
}