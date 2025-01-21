import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/general/home_controller.dart';
import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/constants/storage_keys.dart';
import 'package:promotion_dashboard/data/model/profile/user_model.dart';
import 'package:promotion_dashboard/data/resource/remote/auth/auth_data.dart';

abstract class DrawerController extends GetxController {
  Future<void> logout();
}

class DrawerControllerImp extends DrawerController {
  int previousIndex = 0;

  int selectedIndex = 0;
  UserModel? user;

  @override
  void onInit() {
    user = UserModel.fromJson(Shared.getMapValue(StorageKeys.user));
    super.onInit();
  }

  final HomeControllerImp homeController = Get.find<HomeControllerImp>();
  AuthData authData = AuthData();

  void updateIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;

      homeController.changeIndex(index);

      update();
    }
  }

  @override
  Future<void> logout() async {
    Get.offAndToNamed(AppRoutes.login);
    await authData.logout();
    Shared.clear();
    Shared.setValue(StorageKeys.step, 1);
  }
}
