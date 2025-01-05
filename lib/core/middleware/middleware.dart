import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/constants/storage_keys.dart';

class MyMiddleWare extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    //MyServices.initialServices();
    int step = Shared.getValue(StorageKeys.step, initialVAlue: 0);
    switch (step) {
      case 0:
        return null;
      case 1:
        return RouteSettings(name: AppRoutes.chooseLanguage);
      case 2:
        return RouteSettings(name: AppRoutes.homeScreen);
      case 3:
        return RouteSettings(name: AppRoutes.homeScreen);
    }
    return null;
  }
}
