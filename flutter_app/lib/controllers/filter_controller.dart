import 'package:get/get.dart';

class FilterController extends GetxController {
  var selectedModelName = ''.obs;
  var selectedMarcaName = ''.obs;
  var selectedColorName = ''.obs;
  var selectedTallaName = ''.obs;

  void setSelectedModelName(String name) {
    selectedModelName.value = name;
  }

  void setSelectedMarcaName(String name) {
    selectedMarcaName.value = name;
  }

  void setSelectedColorName(String name) {
    selectedColorName.value = name;
  }

  void setSelectedTallaName(String name) {
    selectedTallaName.value = name;
  }
}