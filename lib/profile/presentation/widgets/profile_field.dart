import 'package:flutter/material.dart';
import '../../../utils/common_color.dart';
import '../../../utils/common_font_style.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            '$label:',
            style: CommonFontStyle.boldFontStyle(
              fontSize: 15,
              color: CommonColor.bottomNavIconColor(),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: CommonFontStyle.boldFontStyle(
              fontSize: 14,
              color: CommonColor.bottomNavSelectedIconColor(),
            ),
          ),
        ),
      ],
    );
  }
}