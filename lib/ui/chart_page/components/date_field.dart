import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  DateTime value;
  DateTime firstDate;
  DateTime lastDate;
  void Function(DateTime) onChanged;

  DateField({
    Key? key,
    required this.value,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('yyyy-MM-dd');
    String textValue = format.format(value);
    TextEditingController controller = TextEditingController(text: textValue);
    void _selectDate() async {
      DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: firstDate,
          lastDate: lastDate);
      if (newDate != null && newDate != value) {
        value = newDate;
        onChanged(newDate);
      }
    }
    return GestureDetector(
      onTap: () => _selectDate(),
      child: AbsorbPointer(
        child: TextField(
          controller: controller,
        ),
      ),
    );
  }


}
