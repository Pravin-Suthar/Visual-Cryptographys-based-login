import 'package:flutter/material.dart';
import 'package:frontend/common/design/customColors.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>{
      const AppColors(
        c1: Color.fromRGBO(0, 0, 0, 1), // Black
        c2: Color.fromRGBO(38, 38, 38, 1), // A shade of dark gray
        c3: Color.fromRGBO(77, 77, 77, 1), // A slightly lighter shade of dark gray
        c4: Color.fromRGBO(115, 115, 115, 1), // A shade of medium gray
        c5: Color.fromRGBO(166, 166, 166, 1), // A slightly lighter shade of medium gray
        c6: Color.fromRGBO(204, 204, 204, 1), // A shade of light gray
        c7: Color.fromRGBO(217, 217, 217, 1), // A slightly darker shade of light gray
        c8: Color.fromRGBO(242, 242, 242, 1), // Another shade of light gray
        c9: Color.fromRGBO(255, 255, 255, 0.9), // An off-white color with a bit of transparency
        c10: Color.fromRGBO(255, 255, 255, 0.7), // White with opacity
        c11: Color.fromRGBO(255, 255, 255, 0.5), // White with medium opacity
        c12: Color.fromRGBO(255, 255, 255, 1), // White
      ),
    },
  );
}
