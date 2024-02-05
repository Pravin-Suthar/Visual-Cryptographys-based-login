import 'package:flutter/material.dart';
import 'package:frontend/login_registration/login.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.to(() => LoginPage());
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Change button color here
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: Text(
                "Invigilator Login",
                style: TextStyle(
                  fontSize: 18, // Change text size here
                  color: Colors.white, // Change text color here
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between buttons
            ElevatedButton(
              onPressed: () {
                // Add Student Section logic here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Change button color here
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
              child: Text(
                "Student Section",
                style: TextStyle(
                  fontSize: 18, // Change text size here
                  color: Colors.white, // Change text color here
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
