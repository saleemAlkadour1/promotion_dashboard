import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/middleware/middleware.dart';
import 'package:promotion_dashboard/view/screens/auth/login.dart';
import 'package:promotion_dashboard/view/screens/home/categories/categories_management.dart';
import 'package:promotion_dashboard/view/screens/home/categories/create_category.dart';
import 'package:promotion_dashboard/view/screens/home/categories/update_category.dart';
import 'package:promotion_dashboard/view/screens/home/chats/chats.dart';
import 'package:promotion_dashboard/view/screens/home/dashboard/dashboard.dart';
import 'package:promotion_dashboard/view/screens/home/home.dart';
import 'package:promotion_dashboard/view/screens/home/products/create_product.dart';
import 'package:promotion_dashboard/view/screens/home/products/products_management.dart';
import 'package:promotion_dashboard/view/screens/home/products/products_type/live/servers/five_sim/select_country_and_operator.dart';
import 'package:promotion_dashboard/view/screens/home/products/products_type/live/servers/five_sim/select_product.dart';
import 'package:promotion_dashboard/view/screens/home/products/products_type/store/store.dart';
import 'package:promotion_dashboard/view/screens/home/products/update_product.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: '/',
    page: () => const Home(),
    middlewares: [
      MyMiddleWare(),
    ],
  ),
  GetPage(
      name: AppRoutes.categoriesManagement,
      page: () => const CategoriesManagement()),
  GetPage(name: AppRoutes.createCategory, page: () => const CreateCategory()),
  GetPage(name: AppRoutes.updateCategory, page: () => const UpdateCategory()),
  GetPage(
      name: AppRoutes.productsManagement,
      page: () => const ProductsManagement()),
  GetPage(name: AppRoutes.createProduct, page: () => const CreateProduct()),
  GetPage(name: AppRoutes.updateProduct, page: () => const UpdateProduct()),
  GetPage(name: AppRoutes.dashboard, page: () => const Dashboard()),
  GetPage(name: AppRoutes.chats, page: () => const Chats()),
  GetPage(name: AppRoutes.home, page: () => const Home()),
  GetPage(name: AppRoutes.login, page: () => const Login()),
  GetPage(name: AppRoutes.selectProduct, page: () => const SelectProduct()),
  GetPage(
      name: AppRoutes.selectCountryAndOperator,
      page: () => const SelectCountryAndOperator()),
  GetPage(name: AppRoutes.store, page: () => Store()),
];
