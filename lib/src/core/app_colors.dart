import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF619B8A);
  static const Color secondaryColor = Color(0xFFA1C181);
  static const Color backgroundColor = Color(0xFF243D4D);
  static const Color fontColor = Color(0xFFEDF4EF);

  static const Color expenseColor = Color(0xFFFE7F2D);
  static const Color profitColor = Color(0xFFFCCA46);

  static const Color errorColor = Colors.red;

  static Color foregroundColorBasedOnBackground(Color reference) {
    if (reference.computeLuminance() > 0.5) return AppColors.backgroundColor;
    return AppColors.fontColor;
  }
}
