import 'package:flutter/material.dart';
import 'package:frontend/common/textfield_decoration.dart';
import 'package:frontend/controller/examiner_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExaminerRegistrationScreen extends StatefulWidget {
  ExaminerRegistrationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ExaminerRegistrationScreen> createState() =>
      _ExaminerRegistrationScreenState();
}

class _ExaminerRegistrationScreenState
    extends State<ExaminerRegistrationScreen> {
  final ExaminerController examinerController = Get.put(ExaminerController());
  DateTime? selectedDate;
  final labelscrollcontroller = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );
  List<String> dropdownItems = ["male", "female"];
  void onItemSelected(value) {
    examinerController.genderController.value = value;
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       examinerController.selectedDate.value = picked;
  //     });
  // }
  bool isDropdownOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Examiner Registration'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Name Field
            TextField(
              enabled: true,
              controller: examinerController.firstNameController,
             

             decoration: InputDecorations.getCustomInputDecoration("First Name", context)
            ),
            SizedBox(height: 20.h),

            // Last Name Field
            TextField(
              enabled: true,
              controller: examinerController.lastNameController,
               decoration: InputDecorations.getCustomInputDecoration("Last Name", context)
            ),
            SizedBox(height: 20.h),

            // Email Field
            TextField(
              enabled: true,
              controller: examinerController.emailController,
               decoration: InputDecorations.getCustomInputDecoration("Email", context)
            ),
            SizedBox(height: 20.h),

            // Phone Number Field
            TextField(
              enabled: true,
              controller: examinerController.phoneNumberController,
               decoration: InputDecorations.getCustomInputDecoration("Ph No.", context)
     
            ),
            SizedBox(height: 20.h),


            // Address Field
            TextField(
              enabled: true,
              controller: examinerController.addressController,
               decoration: InputDecorations.getCustomInputDecoration("Address", context)
        
            ),
            SizedBox(height: 20.h),

            // Qualifications Field
            TextField(
              enabled: true,
              controller: examinerController.qualificationsController,
               decoration: InputDecorations.getCustomInputDecoration("Qualification", context)
            ),
            SizedBox(height: 20.h),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                examinerController.registerExaminer();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
