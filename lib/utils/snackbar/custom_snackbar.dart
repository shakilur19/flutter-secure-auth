import 'package:flutter/material.dart';

import '../common_color.dart';
import '../navigation/navigation_service.dart';

class SnackBarUtils {
  static void showError({
    EdgeInsets? margin,
    String? message,
    Color? color,
    TextStyle? style,
    SnackBarBehavior? snackBarBehavior,
    SnackBarAction? snackBarAction,
    BuildContext? context,
  }) {
    debugPrint('error message : $message');

    TextStyle defaultStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF2F3137),
    );

    final snackBar = SnackBar(
      content: Text(
        textAlign: TextAlign.start,
        message ?? 'Error! Try Again...',
        style: style ?? defaultStyle,
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: CommonColor.appBarColor(),
          ),
          borderRadius: BorderRadius.circular(8)),
      backgroundColor: color ?? Colors.red,
      dismissDirection: DismissDirection.up,
      behavior: snackBarBehavior ?? SnackBarBehavior.fixed,
      margin: margin ?? const EdgeInsets.all(0),
      action: snackBarAction,
    );
    ScaffoldMessenger.of(
            context ?? NavigationService.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }

  static void showSuccess({String message = 'Success!', Color? color}) {
    TextStyle defaultStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF2F3137),
    );

    final snackBar = SnackBar(
      content: Text(
        message,
        style: defaultStyle,
      ),
      backgroundColor: color ?? Colors.green,
    );
    ScaffoldMessenger.of(NavigationService.navigatorKey.currentContext!)
        .showSnackBar(snackBar);
  }
}
