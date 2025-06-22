import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;
  var tapedIndex = 0.obs;

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
  void onTapIndex (int index) {
    tapedIndex.value =index;
  }
}
