import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:frontend/api_url.dart';
import 'package:frontend/common/image_overlay.dart';
import 'package:frontend/common/sncakbar.dart';
import 'package:frontend/controller/dropdown_controller.dart';
import 'package:frontend/home.dart';
import 'package:frontend/login_registration/registration.dart';
import 'package:frontend/marksentry/home_marks.dart';
import 'package:frontend/marksentry/mark_entry_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class ExaminerController extends GetxController {
  
  Rx<Uint8List?> selectedFileBytes = Rx<Uint8List?>(null);
  Rx<Uint8List?> overlayedFileBytes= Rx<Uint8List?>(null);
  final dropdowncontroller = Get.put(DropdownController());
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  // TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController qualificationsController = TextEditingController();
//  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
 void setOverlayedFileBytes(Uint8List fileBytes) {
    overlayedFileBytes.value = fileBytes;
  }

  var isOtpSend = false.obs;
  void registerExaminer() async {


    try {
      String body = json.encode({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'phoneNumber': phoneNumberController.text,
        'gender': dropdowncontroller.selected.value,
        'address': addressController.text,
        'qualifications': qualificationsController.text,
      });
      print(body);
      http.Response res = await http.post(
        Uri.parse(registerExaminerUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var jsonData = jsonDecode(res.body);

      if (jsonData['success']) {
        successSnackBar(
            Get.context as BuildContext, 'Examiner registered successfully!');

        Get.to(() => Homepage());
        firstNameController.clear();
        lastNameController.clear();
        phoneNumberController.clear();
        genderController.clear();
        addressController.clear();
        emailController.clear();
        otpController.clear();
        qualificationsController.clear();
      } else {
        successSnackBar(Get.context as BuildContext, "aserdfghff");
      }
    } catch (error) {
      print(error.toString());
      warningSnackBar(Get.context as BuildContext,
          'Registration failed. Please try again later.');
    }
  }

 void loginExaminer() async {
  print("jsonData");
  try {
    var body = json.encode({'email': emailController.text.trim()});
    http.Response res = await http.post(
      Uri.parse(loginExaminerUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    var jsonData = jsonDecode(res.body);
    print(jsonData);

    if (jsonData['success'] == true) {
      isOtpSend.value = true;
Get.to(() => ImageOverlayPage());
     // Decode base64 encoded shares
// String share1Base64 = jsonData['share1'];
// Uint8List share1Bytes = base64Decode(share1Base64);
// selectedFileBytes.value = share1Bytes;

//bard ai logic
final base64Image = jsonData['share1'];
 final bytes = base64Decode(base64Image);
  selectedFileBytes.value = bytes;

print(selectedFileBytes);
print("Image data size: ${selectedFileBytes.value!.length}");

// PopupImageSelector.showImagePopup(selectedFileBytes);

      // Show the image in a pop-up
      //_showImagePopup();
      
      successSnackBar(Get.context as BuildContext, jsonData['message']);
    } else {
      warningSnackBar(Get.context as BuildContext, 'Please Register First');
      Get.to(() => ExaminerRegistrationScreen());
    }
  } catch (e) {
    warningSnackBar(Get.context as BuildContext, 'Something went wrong');
  }
}

  void verifyOtp() async {
    try {
      String email = emailController.text.trim();
      var body = json.encode({'email': email, 'otp': otpController.text});
      http.Response res = await http.post(
        Uri.parse(verifyExaminerUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var jsonData = jsonDecode(res.body);
      print(jsonData);

      if (jsonData['success'] == true) {
        print(jsonData['examinersid']);
        isOtpSend.value = false;
        Get.to(() => StudentListPage());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('examinerid', (jsonData['examinersid']));
        int? examinerId = prefs.getInt('examinerid');
        print(examinerId);
        successSnackBar(Get.context as BuildContext, 'Logged in successfully');
      } else {
        warningSnackBar(
            Get.context as BuildContext, 'Please try / contact support team.');
      }
    } catch (e) {
      warningSnackBar(Get.context as BuildContext, 'Something went wrong');
    }
  }
}

class PopupImageSelector {
  static void showImagePopup(Rx<Uint8List?> selectedFileBytes) {
    double overlayOpacity = 0.5; // Initial opacity
    late Slider overlaySlider;

    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    selectedFileBytes.value != null
                        ? Image.memory(
                            selectedFileBytes.value!,
                            width: 200,
                            height: 200,
                          )
                        : SizedBox(),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Overlay Opacity:'),
                        Expanded(
                          child: Slider(
                            value: overlayOpacity,
                            onChanged: (value) {
                              setState(() {
                                overlayOpacity = value;
                              });
                            },
                            min: 0.0,
                            max: 1.0,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Select one more file using file picker
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['png'],
                        );

                        if (result != null) {
                          PlatformFile file = result.files.first;

                          // Try to use file.bytes
                          if (file.bytes != null) {
                            Uint8List newFileBytes = file.bytes!;
                            // Overlay the new file with the specified opacity
                            selectedFileBytes.value = overlayImages(
                              selectedFileBytes.value,
                              newFileBytes,
                              overlayOpacity,
                            );
                          } else {
                            // If file.bytes is null, try to read the file
                            List<int> fileBytes =
                                await File(file.path!).readAsBytes();
                            Uint8List newFileBytes =
                                Uint8List.fromList(fileBytes);

                            // Overlay the new file with the specified opacity
                            selectedFileBytes.value = overlayImages(
                              selectedFileBytes.value,
                              newFileBytes,
                              overlayOpacity,
                            );
                          }

                          // Update the image in the pop-up
                          setState(() {});
                        }
                      },
                      child: Text('Select One More'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Uint8List? overlayImages(
    Uint8List? backgroundBytes,
    Uint8List overlayBytes,
    double overlayOpacity,
  ) {
    if (backgroundBytes == null) {
      // If the background is null, return the overlay directly
      return overlayBytes;
    }

    int overlayByteLength = overlayBytes.length;

    // Ensure both images have the same length
    if (backgroundBytes.length != overlayByteLength) {
      return null;
    }

    Uint8List resultBytes = Uint8List(overlayByteLength);

    for (int i = 0; i < overlayByteLength; i++) {
      int blendedValue = ((1.0 - overlayOpacity) * backgroundBytes[i] +
              overlayOpacity * overlayBytes[i])
          .round();

      resultBytes[i] = blendedValue.clamp(0, 255);
    }

    return resultBytes;
  }
}