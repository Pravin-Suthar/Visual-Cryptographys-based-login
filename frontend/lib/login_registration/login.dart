import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/controller/examiner_controller.dart';
import 'package:frontend/login_registration/registration.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ExaminerController examinerController = Get.put(ExaminerController());
  Uint8List? _selectedFileBytes;

  @override
  void initState() {
    super.initState();
    examinerController.isOtpSend.value = false;
  }

Future<void> _pickFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      print('Selected file: ${file.name}');

      // Try to use file.bytes
      if (file.bytes != null) {
        _selectedFileBytes = file.bytes;
      } else {
        // If file.bytes is null, try to read the file
        List<int> fileBytes = await File(file.path!).readAsBytes();
        _selectedFileBytes = Uint8List.fromList(fileBytes);
      }

      print(_selectedFileBytes);

      // Show the image in a pop-up
      _showImagePopup();
    } else {
      // User canceled the file picking
    }
  } catch (e) {
    print('Error picking file: $e');
  }
}




  void _showImagePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
               examinerController.selectedFileBytes != null
                    ? Image.memory(
                        _selectedFileBytes!,
                        width: 200,
                        height: 200,
                      )
                    : SizedBox(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                    hintText: "Email",
                    hintStyle: CustomTextStyle.T4(context),
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).extension<AppColors>()!.c1 as Color,
                    backgroundColor:
                        Theme.of(context).extension<AppColors>()!.c12 as Color,
                  ),
                  onPressed: _pickFile,
                  child: Text(
                    'Select File',
                    style: CustomTextStyle.T4(context),
                  ),
                ),
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
                          : 'Request OTP',
                      style: CustomTextStyle.T4(context),
                    ),
                  ),
                ),
                Visibility(
                  visible: examinerController.isOtpSend.value,
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
                      'Verify',
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
