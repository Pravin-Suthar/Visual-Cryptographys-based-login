import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/api_url.dart';
import 'package:http/http.dart' as http;

class LandingPageController extends GetxController {
  var isExpanded = false.obs;
  var userName = 'User'.obs;

  void getUserName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');
      String body = json.encode({"userId": userId});

      http.Response res = await http.post(
        Uri.parse(getUserDetailsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      var jsonData = jsonDecode(res.body);

      if (jsonData['success'] == true) {
        // var userDetails = jsonData['userDetails'];
        userName.value = jsonData['userName'];
      } else {
        // Handle error case if needed
      }
    } catch (error) {
      // Handle error case if needed
    }
  }

}