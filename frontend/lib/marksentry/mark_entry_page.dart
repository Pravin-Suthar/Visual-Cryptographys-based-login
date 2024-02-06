import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';
import 'package:frontend/controller/labelcontroller.dart';
import 'package:frontend/controller/student_marks.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MarksEntryPage extends StatefulWidget {
  final bool isEdit;

  MarksEntryPage({Key? key, required this.isEdit}) : super(key: key);

  @override
  _MarksEntryPageState createState() => _MarksEntryPageState();
}

class _MarksEntryPageState extends State<MarksEntryPage> {
  final studentMarksController = Get.put(StudentMarksController());
  final studentmarkscontroller = Get.put(StudentMarksController());
  void _addSubjectRow() {
    studentmarkscontroller.allmarks.add({
      'subject': '',
      'marksReceived': '',
      'maxMarks': '',
    });
  }

  List<String> course = [
    "Computer Science",
    "Artificial Intelligence",
    "Electronic Engineering",
    "Civil Engneering",
    "Machine Learning",
    "Other"
  ];
  List<String> roll_no = [];
  List<String> exam_type = ["Summer Exam", " Winter Exam"];

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  Future<void> initializeState() async {

    for (int i = 1; i <= 40; i++) {
      String rollNumber = "COBB${i.toString().padLeft(2, '0')}";
      roll_no.add(rollNumber);
    }

    if (widget.isEdit) {
      await studentmarkscontroller.getStudentMarkById();
      studentmarkscontroller.allmarks.clear();
      final studentData = studentmarkscontroller.studentMark.value;

      final marks = studentData['marks'];
      final parsedMarks = jsonDecode(marks);
      if (parsedMarks is List) {
        for (final mark in parsedMarks) {
          studentmarkscontroller.allmarks.add({
            'subject': mark['subject'],
            'marksReceived': mark['marksReceived'],
            'maxMarks': mark['maxMarks'],
          });
        }
      }
    } else {
      studentmarkscontroller.allmarks.clear();
      studentmarkscontroller.examType.value =
          exam_type.isNotEmpty ? exam_type[0] : '';
      studentmarkscontroller.course.value = course.isNotEmpty ? course[0] : '';
      studentmarkscontroller.rollno.value =
          roll_no.isNotEmpty ? roll_no[0] : '';
      studentmarkscontroller.studentMark.clear();
    }
  }

  final labelcontroller1 = Get.put(LabelDropdownController());
  final labelcontroller2 = Get.put(LabelDropdownController());
  final labelcontroller3 = Get.put(LabelDropdownController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).extension<AppColors>()!.c3,
          statusBarBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).extension<AppColors>()!.c5,
              ),
              child: Obx(() => Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 21.0.h, left: 17.0.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 87.w,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 21.0.h),
                              child: Text(
                                '         Student Marks',
                                style: CustomTextStyle.T2(context),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.892,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 21),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).extension<AppColors>()!.c12,
                          ),
                          child: Column(
                            children: [
                              buildDropdown(labelcontroller1, course, 1),
                              buildDropdown(labelcontroller2, exam_type, 2),
                              buildDropdown(labelcontroller3, roll_no, 3),
                              Expanded(
                                  child: ListView.builder(
                                itemCount:
                                    studentmarkscontroller.allmarks.length,
                                itemBuilder: (context, index) {
                                  final TextEditingController
                                      subjectController = TextEditingController(
                                          text: studentmarkscontroller
                                              .allmarks[index]['subject']);
                                  final TextEditingController
                                      marksReceivedController =
                                      TextEditingController(
                                          text: studentmarkscontroller
                                                  .allmarks[index]
                                              ['marksReceived']);
                                  final TextEditingController
                                      maxMarksController =
                                      TextEditingController(
                                          text: studentmarkscontroller
                                              .allmarks[index]['maxMarks']);

                                  return Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: subjectController,
                                          decoration: InputDecoration(
                                              labelText: 'Subject Name'),
                                          onChanged: (value) {
                                            studentmarkscontroller
                                                    .allmarks[index]
                                                ['subject'] = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: TextFormField(
                                          controller: marksReceivedController,
                                          decoration: InputDecoration(
                                              labelText: 'Marks Received'),
                                          onChanged: (value) {
                                            studentmarkscontroller
                                                    .allmarks[index]
                                                ['marksReceived'] = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: TextFormField(
                                          controller: maxMarksController,
                                          decoration: InputDecoration(
                                              labelText: 'Max Marks'),
                                          onChanged: (value) {
                                            studentmarkscontroller
                                                    .allmarks[index]
                                                ['maxMarks'] = value;
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: _addSubjectRow,
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 16.0),
                FloatingActionButton(
                  onPressed: () {
                    studentmarkscontroller.isEditMarks.value
                        ? studentmarkscontroller.updateStudentMark()
                        : studentmarkscontroller.createStudentMark();
                  },
                  child: Icon(Icons.check),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ));
  }

  Widget buildDropdown(
      LabelDropdownController controller, List<String> items, int index) {
    int maxVisibleItems = 3;

    return Obx(() {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              if (index == 1) {
                controller.isDropdownOpen1.value =
                    !controller.isDropdownOpen1.value;
              } else if (index == 2) {
                controller.isDropdownOpen2.value =
                    !controller.isDropdownOpen2.value;
              } else if (index == 3) {
                controller.isDropdownOpen3.value =
                    !controller.isDropdownOpen3.value;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    index == 1
                        ? studentmarkscontroller.course.value
                        : index == 2
                            ? studentmarkscontroller.examType.value
                            : studentmarkscontroller.rollno.value,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      index == 1
                          ? controller.isDropdownOpen1.value
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down
                          : index == 2
                              ? controller.isDropdownOpen2.value
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down
                              : controller.isDropdownOpen3.value
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                      size: 24.0,
                      color: Theme.of(context).extension<AppColors>()!.c5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (index == 1
              ? controller.isDropdownOpen1.value
              : index == 2
                  ? controller.isDropdownOpen2.value
                  : controller.isDropdownOpen3.value)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: maxVisibleItems * 42.0,
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                      scrollbarTheme: ScrollbarThemeData(
                    thickness: MaterialStateProperty.all(4),
                    thumbVisibility: MaterialStateProperty.all(true),
                    radius: Radius.circular(40),
                    crossAxisMargin: 24.0,
                    thumbColor: MaterialStateProperty.all(
                        Color.fromRGBO(5, 74, 104, 1)),
                  )),
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, itemIndex) {
                        final item = items[itemIndex];
                        return InkWell(
                          onTap: () {
                            controller.onItemSelected(item, index);
                          },
                          child: Container(
                            height: 42.0,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            color: index == 1
                                ? studentmarkscontroller.course.value == item
                                    ? Theme.of(context)
                                        .extension<AppColors>()!
                                        .c9
                                    : Colors.transparent
                                : index == 2
                                    ? studentmarkscontroller.examType.value ==
                                            item
                                        ? Theme.of(context)
                                            .extension<AppColors>()!
                                            .c9
                                        : Colors.transparent
                                    : studentmarkscontroller.rollno.value ==
                                            item
                                        ? Theme.of(context)
                                            .extension<AppColors>()!
                                            .c9
                                        : Colors.transparent,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
