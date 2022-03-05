import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int pageIndex;
  final Function onPageChanged;

  const BottomBar(
      {Key? key, required this.pageIndex, required this.onPageChanged})
      : super(key: key);

  List<BottomNavigationBarItem> _barItems() {
    return const [
      BottomNavigationBarItem(
          icon: Icon(Icons.attach_money), label: 'Конвертация'),
      BottomNavigationBarItem(icon: Icon(Icons.table_rows), label: 'Список'),
      BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Графики'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pageIndex,
      items: _barItems(),
      onTap: (index) => onPageChanged(index),
    );
  }
}
