import 'package:flutter/material.dart';

import 'common_color.dart';
import 'common_font_style.dart';

class CommonButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback buttonAction;

  const CommonButton({super.key, required this.buttonTitle, required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonAction,
      child: Container(
        alignment: Alignment.center,
        height: 48,
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
            color: CommonColor.buttonColor(),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: const [BoxShadow(
                blurRadius: 10,
                color: Colors.blueGrey,
                offset: Offset(1,3),
            ),]
        ),
        child: Text(
          buttonTitle,
          style: CommonFontStyle.boldFontStyle(color: Colors.white),
        ),
      ),
    );
  }
}