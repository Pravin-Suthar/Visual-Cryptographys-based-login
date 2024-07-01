import 'package:flutter_dotenv/flutter_dotenv.dart';

String mainApiUrl = dotenv.env['HOSTED_URL'].toString();

String registerUserUrl = '$mainApiUrl/api/user/register';
String loginUserUrl = '$mainApiUrl/api/user/login';
String verifyUserUrl = '$mainApiUrl/api/user/verifyOtp';
String getUserDetailsUrl = '$mainApiUrl/api/user/getUserName';
