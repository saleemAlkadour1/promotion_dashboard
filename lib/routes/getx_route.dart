import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/view/screens/categories/category.dart';

List<GetPage<dynamic>>? getPages = [
  // GetPage(name: '/', page: () => const Onbording(), middlewares: [
  //   MyMiddleWare(),
  // ]),
  GetPage(name: AppRoutes.category, page: () => const Category()),
];
