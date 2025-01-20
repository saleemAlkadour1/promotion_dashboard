import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/notifications/notifications_management_controller.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/custom_dawer.dart';

abstract class HomeController extends GetxController {}

class HomeControllerImp extends HomeController {
  int selectedIndex = 0;
  int previousIndex = 0;

  final List screens = [
    DrawerItems.dashboard.screen,
    DrawerItems.categoriesManagement.screen,
    DrawerItems.productsManagement.screen,
    DrawerItems.orders.screen,
    DrawerItems.transactions.screen,
    DrawerItems.users.screen,
    DrawerItems.notifications.screen,
    DrawerItems.chats.screen,
    DrawerItems.settings.screen,
  ];

  void changeIndex(int newIndex) {
    previousIndex = selectedIndex;
    selectedIndex = newIndex;
    if (previousIndex == DrawerItems.notifications.value &&
        newIndex != DrawerItems.notifications.value) {
      Get.find<NotificationsManagementControllerImp>().markAsLastRead();
    }

    update();
  }
}
