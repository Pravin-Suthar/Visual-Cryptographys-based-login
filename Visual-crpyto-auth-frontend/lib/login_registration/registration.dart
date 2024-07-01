import 'package:flutter/material.dart';
import 'package:frontend/common/textfield_decoration.dart';
import 'package:frontend/controller/user_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserRegistrationScreen extends StatefulWidget {
  UserRegistrationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserRegistrationScreen> createState() =>
      _UserRegistrationScreenState();
}

class _UserRegistrationScreenState
    extends State<UserRegistrationScreen> {
  final UserController userController = Get.put(UserController());
  DateTime? selectedDate;
  final labelscrollcontroller = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );
  List<String> dropdownItems = ["male", "female"];
  void onItemSelected(value) {
    userController.genderController.value = value;
  }

  bool isDropdownOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('user Registration'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Name Field
            TextField(
              enabled: true,
              controller: userController.firstNameController,
             

             decoration: InputDecorations.getCustomInputDecoration("First Name", context)
            ),
            SizedBox(height: 20.h),

            // Last Name Field
            TextField(
              enabled: true,
              controller: userController.lastNameController,
               decoration: InputDecorations.getCustomInputDecoration("Last Name", context)
            ),
            SizedBox(height: 20.h),

            // Email Field
            TextField(
              enabled: true,
              controller: userController.emailController,
               decoration: InputDecorations.getCustomInputDecoration("Email", context)
            ),
            SizedBox(height: 20.h),

            // Phone Number Field
            TextField(
              enabled: true,
              controller: userController.phoneNumberController,
               decoration: InputDecorations.getCustomInputDecoration("Ph No.", context)
     
            ),
            SizedBox(height: 20.h),


            // Address Field
            TextField(
              enabled: true,
              controller: userController.addressController,
               decoration: InputDecorations.getCustomInputDecoration("Address", context)
        
            ),
            SizedBox(height: 20.h),

            // Qualifications Field
            TextField(
              enabled: true,
              controller: userController.qualificationsController,
               decoration: InputDecorations.getCustomInputDecoration("Qualification", context)
            ),
            SizedBox(height: 20.h),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                userController.registerUser();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
