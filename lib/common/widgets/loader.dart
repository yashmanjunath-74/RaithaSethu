import 'package:RaithaSethu/constants/global_variables.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                GlobalVariables.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading...',
            style: TextStyle(
              color: GlobalVariables.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
