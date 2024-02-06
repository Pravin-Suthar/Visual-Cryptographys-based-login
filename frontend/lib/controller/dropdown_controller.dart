import 'package:get/get.dart';

class DropdownController extends GetxController {
  RxString selected = ''.obs;
  void onItemSelected(String value) {
    selected.value = value;
  }

  var isDropdownOpen = false.obs;
}
