import 'package:album_app/util/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.errorText,
    this.maxLength,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
  });

  final int? maxLength;
  final TextEditingController? controller;
  final String hint;
  final String errorText;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 14,
        ),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: grayColor,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }

        return null;
      },
    );
  }
}
