import 'package:flutter/material.dart';

class TextFormDecoration {
  BuildContext context;

  TextFormDecoration(this.context);

  InputDecoration decoration({
    required String hintText,
    String? errorText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    EdgeInsetsGeometry? contentPadding,
    Color? fontColor,
    double? fontSize,
    BoxConstraints? iconConstraints,
  }) {
    return InputDecoration(
      filled: true,
      prefixIcon: _buildIcon(prefixIcon),
      counter: const Offstage(),
      isDense: true,
      hintText: hintText,
      prefixIconConstraints: iconConstraints ?? _defaultIconConstraints,
      suffixIconConstraints: iconConstraints ?? _defaultIconConstraints,
      hintStyle: _buildHintStyle(fontColor, fontSize),
      suffixIcon: suffixIcon,
      contentPadding: contentPadding ?? _defaultContentPadding,
      focusedBorder: _buildOutlineInputBorder(Colors.deepPurple.shade600),
      enabledBorder: _buildOutlineInputBorder(
        Colors.grey.shade200.withOpacity(0.7),
      ),
      border: _buildOutlineInputBorder(Colors.transparent),
      errorText: errorText,
    );
  }

  BoxConstraints get _defaultIconConstraints =>
      const BoxConstraints(minWidth: 40.0, minHeight: 40.0);

  EdgeInsets get _defaultContentPadding =>
      const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 10.0);

  Icon? _buildIcon(IconData? icon) {
    return (icon == null) ? null : Icon(icon, color: Colors.deepPurple);
  }

  TextStyle _buildHintStyle(Color? fontColor, double? fontSize) {
    return TextStyle(
      color: fontColor ?? Colors.grey.shade500,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      overflow: TextOverflow.ellipsis,
      fontSize: fontSize ?? 12,
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(Color borderSideColor) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: borderSideColor),
    );
  }
}
