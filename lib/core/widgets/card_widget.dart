
import 'package:flutter/material.dart';

Widget customCardWidget({required Widget child}){
  return  Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.redAccent)
              ),
              
              elevation: 9,
              shadowColor: Colors.blueGrey,
              color: Colors.white,
              child: Padding(padding: const EdgeInsets.all(20),
              child: child,));
}