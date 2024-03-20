import 'package:get/get.dart';

class ShoppingAmountController extends GetxController {
  var itemAmountShop= 0.0.obs;

  void add_amount(double amount) {
    itemAmountShop.value = itemAmountShop.value +  amount;
  }

  void remove_amount(double amount){
    itemAmountShop.value -= amount;
  }
}