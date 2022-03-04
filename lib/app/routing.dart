import 'package:flutter/material.dart';

import '../ui/homepage/homepage.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case homepage: return _buildRoute((context) => const Homepage(), settings);
      default: throw Exception('Неизвестный путь: ${settings.name}');
    }
  }
 static const homepage = '/';
}

MaterialPageRoute _buildRoute(WidgetBuilder builder, settings) {
  return MaterialPageRoute(settings: settings, builder: builder);
}