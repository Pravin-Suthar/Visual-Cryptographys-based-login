import 'package:flutter/material.dart';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';

class InputDecorations {
  static InputDecoration getCustomInputDecoration(String hintText, BuildContext context) {
    return InputDecoration(
      filled: true,
      fillColor: Theme.of(context).extension<AppColors>()!.c12 as Color,
      contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
      hintText: hintText,
      hintStyle: CustomTextStyle.T4(context),
    );
  }
}
