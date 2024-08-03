import 'package:get/get.dart';

class CustomSearchController extends GetxController {
  var searchQuery = ''.obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
