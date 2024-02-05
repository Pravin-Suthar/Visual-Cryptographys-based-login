// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:frontend/common/design/customColors.dart';

class CustomTextStyle {
  static TextStyle T1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          fontFamily: 'Verdana',
          fontWeight: FontWeight.w800,
          color: Theme.of(context).extension<AppColors>()!.c1,
          fontSize: 14,
          letterSpacing: 0.2,
        );
  }

  static TextStyle T2(BuildContext context) {
    return TextStyle(
      fontFamily: 'Verdana',
      fontWeight: FontWeight.w800,
      color: Theme.of(context).extension<AppColors>()!.c2,
      fontSize: 18,
      letterSpacing: 0.2,
    );
  }

  static TextStyle T3(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1!.copyWith(
          fontFamily: 'Verdana',
          fontWeight: FontWeight.w800,
          color: Theme.of(context).extension<AppColors>()!.c3,
          fontSize: 14,
          letterSpacing: 0.5,
        );
  }

  static TextStyle T4(BuildContext context) {
    return TextStyle(
      fontFamily: 'Verdana',
      fontWeight: FontWeight.w700,
      color: Theme.of(context).extension<AppColors>()!.c1,
      fontSize: 14,
      letterSpacing: 0.2,
    );
  }
}
