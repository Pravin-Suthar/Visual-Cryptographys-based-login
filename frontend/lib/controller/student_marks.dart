import 'package:flutter/cupertino.dart';
import 'package:frontend/api_url.dart';
import 'package:frontend/marksentry/home_marks.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/common/sncakbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentMarksController extends GetxController {
  // Observables for student marks
  var fetchedRowMarksEntry = [].obs;
  var studentMark = {}.obs;
  var studentId = ''.obs;
  var examType = ''.obs;
  var course = ''.obs;
  var rollno = ''.obs;
  var seletedStudentId = ''.obs;
  RxBool isEditMarks = false.obs;
  RxBool isfetching = false.obs;
  RxList<Map<String, String>> allmarks = <Map<String, String>>[].obs;


  void getAllStudentMarks() async {
    isfetching.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? examinerId = prefs.getInt('examinerid');
    try {
      http.Response res = await http.get(
        Uri.parse('$getAllStudentsMarksUrl/$examinerId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var jsonData = jsonDecode(res.body);
      if (jsonData['success'] == true) {
        fetchedRowMarksEntry.value = jsonData['studentMark'];
        isfetching.value = false;
        successSnackBar(
          Get.context as BuildContext,
          'Data fetched successfully!',
        );
      } else {
        isfetching.value = false;
        successSnackBar(
          Get.context as BuildContext,
          'Failed to fetch data!',
        );
      }
    } catch (e) {
      isfetching.value = false;
      successSnackBar(
        Get.context as BuildContext,
        'Error: $e',
      );
    }
  }

  // Function to create a student mark entry
  void createStudentMark() async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? examinerId = prefs.getInt('examinerid');
    String body = json.encode({
      'studentId': studentId.value,
      'rollNo': rollno.value,
      'course': course.value,
      'examType': examType.value,
      'marks': allmarks,
    });
    try {
      http.Response res = await http.post(
        Uri.parse('$createStudentMarkUrl/$examinerId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var jsonData = jsonDecode(res.body);
      if (jsonData['success']) {
        Get.to(() => StudentListPage());
        isEditMarks.value = false;
        allmarks.clear();

        studentMark.clear();
        getAllStudentMarks();
        successSnackBar(
            Get.context as BuildContext, 'Marks Entered successfully!');

        fetchedRowMarksEntry.value = jsonData['studentMark'];
      } else {
        warningSnackBar(Get.context as BuildContext, "Entery exists");
        Get.to(() => StudentListPage());
      }
    } catch (e) {
      // warningSnackBar(Get.context as BuildContext, e.toString());
    }
  }

  Future<void> getStudentMarkById() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? examinerId = prefs.getInt('examinerid');
    // Assuming you get the selected student ID from somewhere

    try {
      Map<String, dynamic> requestBody = {
        'examinerid': examinerId,
        'studentid': seletedStudentId.trim(),
      };

      http.Response res = await http.post(
        Uri.parse(getStudentMarkByIdUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      var jsonData = jsonDecode(res.body);

            if (jsonData['success'] == true) {
        //  fetchedRowMarksEntry.value = jsonData['studentMark'];
         studentMark.value = jsonData['studentMark'];
     

        course.value = studentMark['course'];
        examType.value = studentMark['examType'];
        rollno.value = studentMark['rollNo'];
        successSnackBar(
          Get.context as BuildContext,
          'Data fetched successfully!',
        );
      } else {
        isfetching.value = false;
        successSnackBar(
          Get.context as BuildContext,
          'Failed to fetch data!',
        );
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to fetch all student marks

  // Function to update a student mark entry
  void updateStudentMark() async {
    try {
      String body = json.encode({
        'studentId': studentId.value,
        'rollNo': rollno.value,
        'course': course.value,
        'examType': examType.value,
        'marks': allmarks,
      });
      http.Response res = await http.patch(
        Uri.parse('${updateStudentMarkUrl}/${seletedStudentId.trim()}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var jsonData = jsonDecode(res.body);

      if (jsonData['success'] == true) {
        allmarks.clear();

        studentMark.clear();
        getAllStudentMarks();
        Get.to(() => StudentListPage());
        successSnackBar(
          Get.context as BuildContext,
          'Data updated successfully!',
        );
      } else {
        successSnackBar(
          Get.context as BuildContext,
          'Failed to update data!',
        );
      }
    } catch (e) {
      print(e);
    }
  }

//   // Function to delete a student mark entry
//   void deleteStudentMark(int id) async {
//     try {
//       isLoading(true);
//       final response = await http.post(deleteStudentMarkUrl(id.toString()));
//       if (response.statusCode == 204) {
//         studentMarks.removeWhere((mark) => mark.id == id);
//         error('');
//       } else {
//         error('Failed to delete student mark');
//       }
//     } catch (e) {
//       error('An error occurred while deleting student mark');
//     } finally {
//       isLoading(false);
//     }
//   }

  // Function to get a specific student mark entry by ID

}
