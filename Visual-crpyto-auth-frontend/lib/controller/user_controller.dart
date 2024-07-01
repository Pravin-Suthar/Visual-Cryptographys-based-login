import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:frontend/api_url.dart';
import 'package:frontend/app_landing_page/app_landing_page.dart';
import 'package:frontend/common/image_overlay.dart';
import 'package:frontend/common/sncakbar.dart';
import 'package:frontend/login_registration/login.dart';
import 'package:frontend/login_registration/registration.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  Rx<Uint8List?> selectedFileBytes = Rx<Uint8List?>(null);
  Rx<Uint8List?> overlayedFileBytes = Rx<Uint8List?>(null);
  var shouldAnimate = false.obs;
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
  bool isString(String value) {
  return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
}


  var isOtpSend = false.obs;
  void registerUser() async {
    try {

     if (firstNameController.text.isEmpty || lastNameController.text.isEmpty) {
      warningSnackBar(Get.context as BuildContext, 'First name and last name are mandatory.');
      return;
    }

    // Check if firstName and lastName are strings
    if (!isString(firstNameController.text) || !isString(lastNameController.text)) {
      warningSnackBar(Get.context as BuildContext, 'First name and last name must be strings.');
      return;
    }

      String body = json.encode({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'phoneNumber': phoneNumberController.text,
        'address': addressController.text,
        'qualifications': qualificationsController.text,
      });
   
      http.Response res = await http.post(
        Uri.parse(registerUserUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var jsonData = jsonDecode(res.body);

      if (jsonData['success']) {
        successSnackBar(
            Get.context as BuildContext, 'User registered successfully!');

        Get.to(() => LoginPage());
        firstNameController.clear();
        lastNameController.clear();
        phoneNumberController.clear();
        genderController.clear();
        addressController.clear();
        emailController.clear();
        otpController.clear();
        qualificationsController.clear();
      } else {
        successSnackBar(Get.context as BuildContext, jsonData['message']);
      }
    } catch (error) {
  
      warningSnackBar(Get.context as BuildContext,
          'Registration failed. Please try again later.');
    }
  }

  void loginUser() async {
    try {
      var body = json.encode({'email': emailController.text.trim()});
      http.Response res = await http.post(
        Uri.parse(loginUserUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      var jsonData = jsonDecode(res.body);
      if (jsonData['success'] == true) {
        isOtpSend.value = true;
        Get.to(() => ImageOverlayPage());

        final base64Image = jsonData['share1'];
        final bytes = base64Decode(base64Image);
        selectedFileBytes.value = bytes;

        successSnackBar(Get.context as BuildContext, jsonData['message']);
      } else {
        warningSnackBar(Get.context as BuildContext, 'Please Register First');
        Get.to(() => UserRegistrationScreen());
      }
    } catch (e) {
      print(e);
      warningSnackBar(Get.context as BuildContext, 'Something went wrong');
    }
  }

  void verifyOtp() async {
    try {
      String email = emailController.text.trim();
      var body = json.encode({'email': email, 'otp': otpController.text});
      http.Response res = await http.post(
        Uri.parse(verifyUserUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var jsonData = jsonDecode(res.body);
   

      if (jsonData['success'] == true) {
      
        isOtpSend.value = false;
        Get.to(() => AppLandingPage());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', (jsonData['userId']));
      
    
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

