import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {

final TextEditingController controller;
  final String label;
  final Icon? icon;
  final bool? obscureText;
  final TextInputType? textInputType;
  final Function(String)? onChange;

  const CommonTextField({
    super.key,
    required this.controller,
    required this.label,
    this.icon,
    this.obscureText,
    this.textInputType,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (b) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      controller: controller,
      keyboardType: textInputType?? TextInputType.text,
      onChanged: onChange,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: icon?? const Icon(Icons.subscriptions),
      ),
      obscureText: obscureText?? false,
    );
  }

}