import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/common/design/customColors.dart';
import 'package:frontend/common/design/fontStyle.dart';

import 'package:frontend/controller/student_marks.dart';
import 'package:frontend/home.dart';
import 'package:frontend/marksentry/mark_entry_page.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final studentMarksController = Get.put(StudentMarksController());

  @override
  void initState() {
    super.initState();
    studentMarksController.getAllStudentMarks();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).extension<AppColors>()!.c3,
          statusBarBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              bool exitConfirmed = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm Exit'),
                    content:
                        const Text('Are you sure you want to exit the app?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(false); // User does not want to exit
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => Homepage()); // User confirms exit
                        },
                        child: const Text('Exit'),
                      ),
                    ],
                  );
                },
              );

              return exitConfirmed ?? false;
            },
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).extension<AppColors>()!.c5,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 21.0.h, left: 17.0.w),
                          child: Container(
                            decoration: const BoxDecoration(
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
                            '   All  Student  Marks',
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
                        color: Theme.of(context).extension<AppColors>()!.c12,
                      ),
                      child: Obx(
                        () {
                          if (studentMarksController
                              .fetchedRowMarksEntry.value.isEmpty) {
                            return const Center(
                              child: Text('No students found'),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: studentMarksController
                                  .fetchedRowMarksEntry.value.length,
                              itemBuilder: (context, index) {
                                final student = studentMarksController
                                    .fetchedRowMarksEntry.value[index];
                                return ListTile(
                                  title: Text('Roll No ${student["rollNo"]}'),
                                  onTap: () {
                                    studentMarksController
                                            .seletedStudentId.value =
                                        studentMarksController
                                            .fetchedRowMarksEntry
                                            .value[index]['rollNo']
                                            .toString();
                                    studentMarksController.isEditMarks.value =
                                        true;
                                    Get.to(() => MarksEntryPage(
                                        isEdit: studentMarksController
                                            .isEditMarks.value));
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  studentMarksController.isEditMarks.value = false;
                  Future.delayed(const Duration(seconds: 1), () {
                    Get.to(() => MarksEntryPage(
                        isEdit: studentMarksController.isEditMarks.value));
                  });
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ));
  }
}
