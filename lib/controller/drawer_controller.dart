import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home_controller.dart';

class DrawerController extends GetxController {}

class DrawerControllerImp extends GetxController {
  int selectedIndex = 0;

  final HomeControllerImp homeController = Get.find<HomeControllerImp>();

  void updateIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;

      homeController.changeIndex(index);

      update();
    }
  }
}
