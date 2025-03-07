import 'package:flutter/material.dart';

//This class returns SizedBox and maintains vertical spacing
class VerticalGap{

  //creates SizedBox with height 2
  static const xxs = SizedBox(height: 2,);

  //creates SizedBox with height 4
  static const xs = SizedBox(height: 4,);

  //creates SizedBox with height 8
  static const s = SizedBox(height: 8,);

  //creates SizedBox with height 10
  static const m = SizedBox(height: 10,);

  //creates SizedBox with height 12
  static const l = SizedBox(height: 12,);

  //creates SizedBox with height 16
  static const xl = SizedBox(height: 16,);

    /// Creates SizedBox with height 24
  static const xxl = SizedBox(height: 24);

  /// Creates SizedBox with height 32
  static const xxxl = SizedBox(height: 32);

  /// Creates SizedBox with height 42
  static const exl = SizedBox(height: 42);

}

//Class that return SizedBox and maintains horizontal spacing
class HorizontalGap{

  //Creates SizedBox with width 4
  static const xs = SizedBox(width: 4,);

  //Creates SizedBox with width 8
  static const s = SizedBox(width: 8,);

  //Creates SizedBox with width 16
  static const l = SizedBox(width: 12,);

  //Creates SizedBox with width 20 
  static const xl = SizedBox(width: 16,);

  //Creates SizedBox with width 24
  static const xxl = SizedBox(width: 24,);
  
}