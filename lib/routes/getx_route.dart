import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/view/screens/categories/create_category.dart';
import 'package:promotion_dashboard/view/screens/categories/show_category.dart';
import 'package:promotion_dashboard/view/screens/categories/update_category.dart';

List<GetPage<dynamic>>? getPages = [
  // GetPage(name: '/', page: () => const Onbording(), middlewares: [
  //   MyMiddleWare(),
  // ]),
  GetPage(name: AppRoutes.category, page: () => const Category()),

  GetPage(name: AppRoutes.showCategory, page: () => const ShowCategory()),
  GetPage(name: AppRoutes.updateCategory, page: () => const UpdateCategory()),
];
