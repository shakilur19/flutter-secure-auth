import 'package:flutter/material.dart';
import 'common_color.dart';
import 'common_font_style.dart';

class CommonAppbar {
  static AppBar getCommonAppbar(String? title){
    return AppBar(
      title: Text(title?? "Home", style: CommonFontStyle.boldFontStyle(color: Colors.white),),
      backgroundColor: CommonColor.appBarColor(),
      centerTitle: true,
    );
  }
}