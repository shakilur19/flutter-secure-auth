import 'dart:io';
import 'package:flutter/material.dart';
import 'package:login_template/auth/presentation/signup_screen.dart';
import '../../auth/presentation/login_screen.dart';
import '../../landing/presentation/landing_screen.dart';
import '../const/app_route_const.dart';

class AppRoute {
  static final widgetMap = <String, Widget Function(RouteSettings)> {
    AppRouteConst.login: (settings) => const LoginScreen(),
    AppRouteConst.landing: (settings) => const LandingScreen(),
    AppRouteConst.signup: (settings) => const SignupScreen(),
  };

  static Route generateRoute(RouteSettings settings) {
    Widget widget = widgetMap[settings.name]?.call(settings) ??
        Container();

    if (Platform.isIOS) {
      return MaterialPageRoute(
        builder: (context) {
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, res) async {
              if (didPop) return;
              _onPop(context);
            },
            child: widget,
          );
        },
        settings:
        RouteSettings(name: settings.name, arguments: settings.arguments),
      );
    }

    return _createRoute(settings, widget);
  }

  static Route _createRoute(final RouteSettings settings, final widget) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      barrierColor: Colors.black,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static bool _onPop(BuildContext context) {
    if (Navigator.of(context).userGestureInProgress) {
      return false;
    }
    Navigator.of(context).pop();
    return true;
  }
}