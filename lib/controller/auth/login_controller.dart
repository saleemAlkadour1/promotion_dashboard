import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/constants/storage_keys.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/data/resource/remote/auth/auth_data.dart';
import 'package:promotion_dashboard/core/middleware/middleware.dart';

abstract class LoginController extends GetxController {
  void login();
  void toggleRememberMe(bool? value);
  void showPassword();
}

class LoginControllerImp extends LoginController {
  //The fields
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  bool rememberMe = false;

  bool isSeenPassword = false;

  bool loading = false;

  AuthData authData = AuthData();

  @override
  void login() async {
    if (!formState.currentState!.validate()) return;
    loading = true;
    update();

    var response = await authData.login(email.text, password.text);

    if (response.isSuccess) {
      Shared.setValue(StorageKeys.step, 2);
      var accessToken = response.response['access_token'];
      Shared.setValue(StorageKeys.accessToken, accessToken);
      var user = response.response['user'];
      Shared.setValue(StorageKeys.user, user);
      customSnackBar(
        'Login Successfully',
        'Thank you',
        snackType: SnackBarType.correct,
      );
      Get.offAllNamed(AppRoutes.home);
    }

    loading = false;
    update();
  }

  @override
  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    update();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  @override
  void showPassword() {
    if (isSeenPassword == false) {
      isSeenPassword = true;
      update();
    }
    if (isSeenPassword == true) {
      isSeenPassword = false;
      update();
    }
  }
}
