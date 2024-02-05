import 'package:flutter/material.dart';
import 'package:frontend/controller/student_marks.dart';
import 'package:get/get.dart';

class LabelDropdownController extends GetxController {
  List<String> course = ["CS", "AI", "EE"];
  List<String> roll_no = ["1", "2", "3"];
  List<String> exam_type = ["Summer", " winter"];

  @override
  void onInit() {
    super.onInit();

    // Populate the roll_no list during initialization
    for (int i = 1; i <= 40; i++) {
      String rollNumber = "COBB${i.toString().padLeft(2, '0')}";
      roll_no.add(rollNumber);
    }
  }

  var isDropdownOpen1 = false.obs;
  var isDropdownOpen2 = false.obs;
  var isDropdownOpen3 = false.obs;
  final studentmarkscontroller = Get.put(StudentMarksController());

  void onItemSelected(String item, int dropdownIndex) {
    if (dropdownIndex == 1) {
      studentmarkscontroller.course.value = item;
      isDropdownOpen1.value = false;
      print("Selected Course: ${studentmarkscontroller.course.value} ");
    } else if (dropdownIndex == 2) {
      studentmarkscontroller.examType.value = item;
      isDropdownOpen2.value = false;
      print("Selected Exam Type: ${studentmarkscontroller.examType.value} ");
    } else if (dropdownIndex == 3) {
      studentmarkscontroller.rollno.value = item;
      isDropdownOpen3.value = false;
      print("Selected Roll No: ${studentmarkscontroller.rollno.value}");
    }
  }
}
