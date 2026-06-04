import 'package:flutter/material.dart';
import '../common_color.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.9,
      child: Container(
        alignment: Alignment.center,
        height:MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0x30000000),
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: CommonColor.bottomNavSelectedIconColor(),
            valueColor: AlwaysStoppedAnimation<Color>(
              CommonColor.bottomNavSelectedIconColor(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingViewTransparent extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingViewTransparent({Key? key, this.height, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1,
      child: Container(
        color: const Color(0x80000000),
        height: height ?? MediaQuery.of(context).size.height,
        width: width ?? MediaQuery.of(context).size.width,
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              backgroundColor: const Color(0xfff8f8f8),
              valueColor: AlwaysStoppedAnimation<Color>(
                  CommonColor.appBarColor())),
        ),
      ),
    );
  }
}
