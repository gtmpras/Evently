import 'package:flutter/material.dart';

Widget customTextFormField(
  TextEditingController controller,
  TextInputType inputType,
) {
  return TextFormField(
    cursorHeight: 0.5,
    controller: controller,
    keyboardType: inputType,
    decoration: InputDecoration(border: OutlineInputBorder()),
  );
}

Widget customDatePicker(
  TextEditingController controller,
  BuildContext context,
) {
  return TextField(
    controller: controller,
    readOnly: true, // Make the field read-only to trigger the date picker
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Select Date', // Optional hint text
    ),
    onTap: () => _selectDate(context, controller),
  );
}

Future<void> _selectDate(
  BuildContext context,
  TextEditingController controller,
) async {
  // Open the date picker and await the selected date
  DateTime? datePicked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime(2026),
  );

  if (datePicked != null) {
    // Format the selected date as yyyy-MM-dd
    controller.text =
        '${datePicked.year}-${datePicked.month.toString().padLeft(2, '0')}-${datePicked.day.toString().padLeft(2, '0')}';
  }
}
