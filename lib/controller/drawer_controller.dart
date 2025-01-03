import 'package:get/get.dart';

class DrawerController extends GetxController {}

class DrawerControllerImp extends DrawerController {
  int activeIndex = 0;
  void updateIndex(int index) {
    activeIndex = index;
    update();
  }
}
