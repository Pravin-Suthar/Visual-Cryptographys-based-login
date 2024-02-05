import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/design/colorPallet.dart';
import 'package:frontend/controller/examiner_controller.dart';
import 'package:frontend/home.dart';
import 'package:frontend/login_registration/login.dart';
import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? storedToken = prefs.getString('fcmToken');
  // print("AAAAAAAAAAAAAAAAAAAAAAAAA$storedToken");
  // if (storedToken == null) {
  //   String? newToken = await FirebaseMessaging.instance.getToken();
  //   print((newToken));
  //   await prefs.setString('fcmToken', newToken ?? '');
  //   // Send newToken to your server for registration
  // }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (BuildContext BuildContext, Widget? context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: CustomTheme.lightTheme,
          home: Homepage(),
        );
      },
    );
  }
}
