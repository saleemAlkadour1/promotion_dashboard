// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
// import 'package:promotion_dashboard/core/constants/routes.dart';
// import 'package:promotion_dashboard/core/constants/storage_keys.dart';

// class MyMiddleWare extends GetMiddleware {
//   @override
//   int? get priority => 1;

//   @override
//   RouteSettings? redirect(String? route) {
//     //MyServices.initialServices();
//     int step = Shared.getValue(StorageKeys.step, initialVAlue: 1);
//     switch (step) {
//       case 0:
//         return null;
//       case 1:
//         return RouteSettings(name: AppRoutes.login);
//       case 2:
//         return RouteSettings(name: AppRoutes.home);
//     }
//     return null;
//   }
// }

// enum StepNumber {
//   login(1),
//   home(2);

//   final int number;
//   const StepNumber(this.number);
// }
