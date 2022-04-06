import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/view_model/chart_page_view_model.dart';
import 'package:flutter_currency/entities/history_rate.dart';
import 'package:flutter_currency/ui/chart_page/components/date_field.dart';
import 'package:flutter_currency/ui/conversion_page/components/flexible_autocomplete.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void showNotification(Color color, String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: color,
        content: Text(message),
      ));
    }

    List<FlSpot> spots(List<HistoryRate> rates) {
      rates.forEach(print);
      return rates
          .map((entry) => FlSpot(entry.date.millisecondsSinceEpoch.toDouble(),
              entry.price.toDouble()))
          .toList();
    }

    return Consumer<ChartPageViewModel>(
      builder: (context, model, child) {
        Key sourceKey = UniqueKey();
        Key destinationKey = UniqueKey();
        model.setNotification(showNotification);
        DateTime now = DateTime.now();
        DateFormat format = DateFormat('yyyy-MM-dd');
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            tooltip: 'Swap currencies',
            child: const Icon(Icons.repeat),
            onPressed: model.swapCurrencies,
          ),
          body: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.arrow_left),
                  const Icon(Icons.money),
                  FlexibleAutocomplete(
                      key: sourceKey,
                      value: model.sourceCurrency,
                      currencies: model.currencies,
                      onSelected: model.setSourceCurrency),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.money),
                  const Icon(Icons.arrow_right),
                  FlexibleAutocomplete(
                      key: destinationKey,
                      value: model.destinationCurrency,
                      currencies: model.currencies,
                      onSelected: model.setDestinationCurrency),
                ],
              ),
              Row(children: [
                const Icon(Icons.date_range),
                const Icon(Icons.arrow_right),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateField(
                        value: model.dateValue,
                        firstDate: model.fromDate,
                        lastDate: now.subtract(const Duration(days: 1)),
                        onChanged: model.setDate),
                  ),
                ),
              ]),
              ElevatedButton(
                  onPressed: model.getHistoricalData,
                  child: const Text('Get historical data')),
              model.rates.isNotEmpty
                  ? Flexible(
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 56,
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                getTitlesWidget: (value, meta) =>
                                    Transform.rotate(
                                        angle: 3.14 / 2,
                                        child: Text(format.format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                value.toInt())))),
                                showTitles: true,
                                reservedSize: 75,
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              color: Colors.black,
                              spots: spots(model.rates),
                              belowBarData: BarAreaData(
                                show: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}
