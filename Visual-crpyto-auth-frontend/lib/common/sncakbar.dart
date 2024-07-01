import 'package:flutter/material.dart';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';

void successSnackBar(BuildContext context, String text) {
  final SnackBar snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: CustomTextStyle.T1(context),
        ),
      ],
    ),
    backgroundColor: Theme.of(context).extension<AppColors>()!.c2,
    duration: Duration(milliseconds: 250),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void warningSnackBar(BuildContext context, String text) {
  final SnackBar snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: CustomTextStyle.T1(context),
        ),
      ],
    ),
    backgroundColor: Theme.of(context).extension<AppColors>()!.c11 as Color,
    duration: Duration(milliseconds: 1000),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
