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
    // استدعاء قيمة الخطوة المخزنة
    int step = Shared.getValue(StorageKeys.step, initialVAlue: 1);

    // التحقق من قيمة الخطوة وإعادة التوجيه
    switch (step) {
      case 0:
        return null; // السماح بالدخول إلى الصفحة
      case 1:
        return RouteSettings(name: AppRoutes.login); // التوجيه لتسجيل الدخول
      case 2:
        return RouteSettings(name: AppRoutes.home); // التوجيه للصفحة الرئيسية
    }

    return null; // السماح بالدخول إذا لم تنطبق أي شروط
  }
}
// enum StepNumber {
//   login(1),
//   home(2);

//   final int number;
//   const StepNumber(this.number);
// }
