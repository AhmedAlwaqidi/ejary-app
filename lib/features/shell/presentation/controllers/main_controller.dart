import 'package:get/get.dart';

/// MainController coordinates active bottom navigation index
class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
