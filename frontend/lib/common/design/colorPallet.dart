import 'package:flutter/material.dart';
import 'package:frontend/common/design/customColors.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>{
      const AppColors(
        c1: Color.fromRGBO(245, 166, 35, 1),
        c2: Color.fromRGBO(32, 114, 92, 1),
        c3: Color.fromRGBO(255, 86, 34, 1),
        c4: Color.fromRGBO(32, 114, 92, 0.7),
        c5: Color.fromRGBO(127, 58, 138, 1),
        c6: Color.fromRGBO(21, 67, 96, 1),
        c7: Color.fromRGBO(251, 192, 45, 0.8),
        c8: Color.fromRGBO(255, 86, 34, 0.1),
        c9: Color.fromRGBO(58, 83, 155, 1),
        c10: Color.fromRGBO(0, 166, 90, 1),
        c11: Color.fromRGBO(255, 69, 117, 1),
        c12: Color.fromRGBO(255, 255, 255, 1),
      ),
    },
  );
}
