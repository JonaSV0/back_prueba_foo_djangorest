import 'package:get/get.dart';

class FilterContainerController extends GetxController {
  var itemCount = false.obs;

  void update_bool() {
    if (itemCount.value == true){
      itemCount.value = false;
    }
    else {
      itemCount.value = true;
    }
  }
}
