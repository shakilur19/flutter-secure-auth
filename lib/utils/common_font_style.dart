import 'package:flutter/material.dart';

class CommonFontStyle {

  static  TextStyle boldFontStyle({double? fontSize, Color? color}) {
    return TextStyle(
      color: color?? Colors.black,
      fontSize: fontSize ?? 16,
      fontWeight: FontWeight.bold,
    );
  }

  static  TextStyle normalFontStyle({double? fontSize, Color? color}) {
    return TextStyle(
      color: color?? Colors.black,
      fontSize: fontSize ?? 14,
      fontWeight: FontWeight.w300,
    );
  }

  static  TextStyle appBarFontStyle({double? fontSize, Color? color}) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.w600,
    );
  }
}