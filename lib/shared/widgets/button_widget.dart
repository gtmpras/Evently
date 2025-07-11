
import 'package:flutter/material.dart';

Widget customElevatedButton({ required VoidCallback onPressed, required Widget child, ButtonStyle? style}){
  return ElevatedButton(onPressed: onPressed,
   style: style?? ElevatedButton.styleFrom(
    elevation: 5,
    backgroundColor:  Colors.white,
    ),
   child: child);

}