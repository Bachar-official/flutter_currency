import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {

  late final int pageIndex;
  late final Function onPageChanged;

  BottomBar({required this.pageIndex, required this.onPageChanged});

  List<BottomNavigationBarItem> _barItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _barItems(),
      onTap: (index) => onPageChanged(index),
    );
  }
}