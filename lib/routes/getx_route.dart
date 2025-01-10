import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/view/screens/auth/login.dart';
import 'package:promotion_dashboard/view/screens/home/categories/categories_management.dart';
import 'package:promotion_dashboard/view/screens/home/categories/create_category.dart';
import 'package:promotion_dashboard/view/screens/home/categories/show_category.dart';
import 'package:promotion_dashboard/view/screens/home/categories/update_category.dart';
import 'package:promotion_dashboard/view/screens/home/chats/chats.dart';
import 'package:promotion_dashboard/view/screens/home/dashboard/dashboard.dart';
import 'package:promotion_dashboard/view/screens/home/home.dart';
import 'package:promotion_dashboard/view/screens/home/products/create_product.dart';
import 'package:promotion_dashboard/view/screens/home/products/products_management.dart';
import 'package:promotion_dashboard/view/screens/servers/five_sim/select_product.dart';

List<GetPage<dynamic>>? getPages = [
  // GetPage(name: '/', page: () => const Home(), middlewares: [
  //   MyMiddleWare(),
  // ]),
  GetPage(
      name: AppRoutes.categoriesManagement,
      page: () => const CategoriesManagement()),
  GetPage(name: AppRoutes.createCategory, page: () => const CreateCategory()),
  GetPage(name: AppRoutes.updateCategory, page: () => const UpdateCategory()),
  GetPage(name: AppRoutes.showCategory, page: () => const ShowCategory()),
  GetPage(
      name: AppRoutes.productsManagement,
      page: () => const ProductsManagement()),
  GetPage(name: AppRoutes.createProduct, page: () => const CraeteProduct()),
  GetPage(name: AppRoutes.dashboard, page: () => const Dashboard()),
  GetPage(name: AppRoutes.chats, page: () => const Chats()),
  GetPage(name: AppRoutes.home, page: () => const Home()),
  GetPage(name: AppRoutes.login, page: () => const Login()),
  GetPage(name: AppRoutes.selectProduct, page: () => const SelectProduct()),
];
