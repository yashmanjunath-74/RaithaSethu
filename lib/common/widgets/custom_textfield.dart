import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final int Maxlen;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.Maxlen = 1,
    this.obscureText = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: Maxlen,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: GlobalVariables.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon,
                color: GlobalVariables.textLight, size: 20)
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: GlobalVariables.dividerColor),
          borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: GlobalVariables.dividerColor),
          borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: GlobalVariables.primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: GlobalVariables.errorColor, width: 1),
          borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your $hintText';
        }
        return null;
      },
    );
  }
}
