import 'package:flutter/cupertino.dart';

class NavigationViewModel extends ChangeNotifier {
  late int _pageIndex;

  int get pageIndex => _pageIndex;

  NavigationViewModel() {
    _pageIndex = 0;
  }

  void setPage(int index) {
    _pageIndex = index;
    notifyListeners();
  }
}