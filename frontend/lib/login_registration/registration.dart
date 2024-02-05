import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';
import 'package:frontend/common/dropdown.dart';
import 'package:frontend/controller/examiner_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Theme.of(context).extension<AppColors>()!.c4 as Color,
                contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                hintText: "First Name",
                hintStyle: CustomTextStyle.T4(context),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Last Name Field
            TextField(
              enabled: true,
              controller: examinerController.lastNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Theme.of(context).extension<AppColors>()!.c4 as Color,
                contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                hintText: "Last Name",
                hintStyle: CustomTextStyle.T4(context),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Email Field
            TextField(
              enabled: true,
              controller: examinerController.emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Theme.of(context).extension<AppColors>()!.c4 as Color,
                contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                hintText: "Email",
                hintStyle: CustomTextStyle.T4(context),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Phone Number Field
            TextField(
              enabled: true,
              controller: examinerController.phoneNumberController,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Theme.of(context).extension<AppColors>()!.c4 as Color,
                contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                hintText: "Ph No.",
                hintStyle: CustomTextStyle.T4(context),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Date of Birth Field

            // TextField(
            //   enabled: true,
            //   onTap: () => _selectDate(context),
            //   controller: TextEditingController(
            //       text: selectedDate != null
            //           ? DateFormat('yyyy-MM-dd').format(selectedDate!)
            //           : ''),
            //   decoration: InputBox.InputDecoration1(context, "Date of Birth"),
            // ),

            DropdownCustom(),
            // Gender Field
            // TextField(
            //   enabled: true,
            //   controller: examinerController.genderController,
            //   decoration: InputBox.InputDecoration1(context, "Gender"),
            // ),
            // SizedBox(height: 20.h),

            // Address Field
            TextField(
              enabled: true,
              controller: examinerController.addressController,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Theme.of(context).extension<AppColors>()!.c4 as Color,
                contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                hintText: "Address",
                hintStyle: CustomTextStyle.T4(context),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Qualifications Field
            TextField(
              enabled: true,
              controller: examinerController.qualificationsController,
              decoration: InputDecoration(
                filled: true,
                fillColor:
                    Theme.of(context).extension<AppColors>()!.c4 as Color,
                contentPadding: const EdgeInsets.only(bottom: 15, left: 10),
                hintText: "Qualification",
                hintStyle: CustomTextStyle.T4(context),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color:
                        Theme.of(context).extension<AppColors>()!.c5 as Color,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
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
