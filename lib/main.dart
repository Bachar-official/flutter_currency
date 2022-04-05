import 'package:flutter/material.dart';
import 'package:flutter_currency/domain/view_model/conversion_page_view_model.dart';
import 'package:flutter_currency/domain/view_model/list_page_view_model.dart';
import 'package:flutter_currency/domain/view_model/navigation_view_model.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ChangeNotifierProvider(create: (_) => ConversionPageViewModel()),
      ChangeNotifierProvider(create: (_) => ListPageViewModel())
    ], child: const App()),
  );
}
