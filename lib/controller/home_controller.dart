import 'package:get/get.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/custom_dawer.dart';

abstract class HomeController extends GetxController {}

class HomeControllerImp extends HomeController {
  int selectedIndex = 0;

  final List screens = [
    DrawerItems.dashboard.screen,
    DrawerItems.categoriesManagement.screen,
    DrawerItems.productsManagement.screen,
    DrawerItems.transaction.screen,
    DrawerItems.notifications.screen,
    DrawerItems.faq.screen,
    DrawerItems.settings.screen,
  ];

  void changeIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      update();
    }
  }
}
