import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/general/paganiation_data_model.dart';
import 'package:promotion_dashboard/data/model/home/users/user_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/users_data.dart';

abstract class UsersManagementController extends GetxController {
  String? rolesValue = 'All';
  Future<void> getUsersData({required int pageIndex});
  Future<void> showUser(int id);
  void updateRolesValue(String value);
  void filterUsers();
}

class UsersManagementControllerImp extends UsersManagementController {
  bool loading = false;
  UsersData usersData = UsersData();

  UserModel? userModel;
  List<UserModel> users = [];
  List<UserModel> filteredUsers = [];
  late PaganationDataModel paganationDataModel;

  @override
  void onInit() {
    super.onInit();
    getUsersData(pageIndex: 1);
    filterUsers();
  }

  @override
  Future<void> getUsersData({required int pageIndex}) async {
    loading = true;
    update();
    var response = await usersData.get(pageIndex: pageIndex);
    if (response.isSuccess) {
      users = List.generate(response.data.length,
          (index) => UserModel.fromJson(response.data[index]));
      paganationDataModel = PaganationDataModel.fromJson(response.body['meta']);
      filterUsers();
      update();
    }
    loading = false;
    update();
  }

  @override
  Future<void> showUser(int id) async {
    loading = true;
    update();
    Get.parameters.clear();
    var response = await usersData.getUser(id);
    if (response.isSuccess) {
      userModel = UserModel.fromJson(response.data);
    }

    loading = false;
    update();
  }

  // void showOrderDetailsDialog(int id) async {
  //   await showUser(id);
  //   if (userModel != null) {
  //     Get.dialog(
  //       OrderDetailsDialog(
  //         orderModel: orderModel!,
  //       ),
  //     );
  //     update();
  //   }
  // }

  @override
  void updateRolesValue(String value) {
    rolesValue = value;
    filterUsers();
    update();
  }

  @override
  void filterUsers() {
    if (rolesValue == 'All') {
      filteredUsers = users;
    } else {
      filteredUsers = users
          .where((user) => user.role == rolesValue!.toLowerCase())
          .toList();
    }
  }
}
