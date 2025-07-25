import 'package:flutter/material.dart';

class TextFieldFormat extends StatelessWidget {
  final String textFieldName;
  final String? required;
  final Widget textFormField;
  final double? titleSize;

  const TextFieldFormat({
    super.key,
    required this.textFieldName,
    required this.textFormField,
    this.required,
    this.titleSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            children: [
              Text(textFieldName),
              required == null
                  ? Container()
                  : Text(
                    " $required",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        textFormField,
      ],
    );
  }
}
