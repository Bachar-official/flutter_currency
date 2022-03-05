import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/domain/view_model/navigation_view_model.dart';
import 'package:flutter_currency/ui/chart_page/chart_page.dart';
import 'package:flutter_currency/ui/conversion_page/conversion_page.dart';
import 'package:flutter_currency/ui/list_page/list_page.dart';
import 'package:provider/provider.dart';

import '../../constants/currency_dictionary.dart';
import '../../entities/currency.dart';
import 'components/bottom_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);
  
  Widget _getPage(int index) {
    switch (index) {
      case 0: return ConversionPage();
      case 1: return ListPage();
      case 2: return ChartPage();
      default: return const SizedBox.shrink();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Валютко'),
      ),
      body: _getPage(provider.pageIndex),
      bottomNavigationBar:  BottomBar(
          pageIndex: provider.pageIndex,
          onPageChanged: (index) => provider.setPage(index),
        ),
    );
  }
}
