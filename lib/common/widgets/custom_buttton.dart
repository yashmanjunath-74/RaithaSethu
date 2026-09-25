import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButtton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double? Fontsize;

  const CustomButtton(
      {super.key,
      required this.text,
      required this.onTap,
      this.color,
      this.Fontsize});

  @override
  Widget build(BuildContext context) {
    final bool isPrimary = color == null;
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isPrimary ? GlobalVariables.primaryColor : color,
          foregroundColor: isPrimary ? Colors.white : Colors.black87,
          elevation: isPrimary ? 2 : 0,
          shadowColor: isPrimary
              ? GlobalVariables.primaryColor.withOpacity(0.4)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalVariables.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: TextStyle(
            fontSize: Fontsize ?? 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
