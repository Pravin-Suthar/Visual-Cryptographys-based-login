import 'package:flutter/material.dart';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/controller/examiner_controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ExaminerController examinerController = Get.put(ExaminerController());

  @override
  void initState() {
    super.initState();
    examinerController.isOtpSend.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final ExaminerController examinerController = Get.put(ExaminerController());
    return Obx(() {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login Using your Registered Email',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  enabled: true,
                  controller: examinerController.emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        Theme.of(context).extension<AppColors>()!.c12 as Color,
                    contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                    hintText: "Enter your registered email",
                    hintStyle: CustomTextStyle.T4(context),
                  ),
                ),
                SizedBox(height: 20.h),
               
                SizedBox(height: 20.h),
                Visibility(
                  visible: !examinerController.isOtpSend.value,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:
                          Theme.of(context).extension<AppColors>()!.c1 as Color,
                      backgroundColor:
                          Theme.of(context).extension<AppColors>()!.c12 as Color,
                    ),
                    onPressed: () {
                      examinerController.loginExaminer();
                    },
                    child: Text(
                      examinerController.isOtpSend.value
                          ? 'Otp Sent'
                          : 'Request Otp',
                      style: CustomTextStyle.T4(context),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
