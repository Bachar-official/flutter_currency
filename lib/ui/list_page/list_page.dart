import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/view_model/list_page_view_model.dart';
import 'package:flutter_currency/ui/conversion_page/components/flexible_autocomplete.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ListPageViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_left),
                  FlexibleAutocomplete(
                    currencies: model.currencies,
                    value: model.baseCurrency,
                    onSelected: model.setBaseCurrency,
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: model.getLatestRates,
                  child: const Text('Get latest rates')),
              model.isLoading
                  ? const CircularProgressIndicator()
                  // : ListView.builder(
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   itemBuilder: (BuildContext ctx, int index) {
                  //     return ListTile(
                  //       leading: Text(model.rates[index].price.toStringAsFixed(3)),
                  //         title: Text(model.rates[index].name!),
                  //       subtitle: Text(model.rates[index].id),
                  //     );
                  //   },
                  //   itemCount: model.rates.length,
                  // )
                  : Expanded(
                      child: CustomScrollView(slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => ListTile(
                                    leading: Text(model.rates[index].price
                                        .toStringAsFixed(3)),
                                    title: Text(model.rates[index].name!),
                                    subtitle: Text(model.rates[index].id),
                                  ),
                              childCount: model.rates.length),
                        ),
                      ]),
                    ),
            ],
          ),
        );
      },
    );
  }
}
