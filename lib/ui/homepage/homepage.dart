import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/repository/net_repository.dart';
import 'package:flutter_currency/domain/view_model/navigation_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants/currency_dictionary.dart';
import '../../entities/currency.dart';
import 'components/bottom_bar.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer<NavigationViewModel>(
        builder: (context, model, child) => BottomBar(
          pageIndex: model.pageIndex,
          onPageChanged: (index) => model.setPage(index),
        ),
      ),
    );
  }
}
