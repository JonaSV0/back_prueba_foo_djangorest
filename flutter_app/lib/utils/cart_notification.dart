import 'package:get/get.dart';

class CartController extends GetxController {
  var itemCount = 0.obs;

  void update_count(int amount) {
    itemCount.value = amount;
  }
}
