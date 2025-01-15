// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/general/drawer_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/view/screens/home/categories/categories_management.dart';
import 'package:promotion_dashboard/view/screens/home/chats/chats.dart';
import 'package:promotion_dashboard/view/screens/home/dashboard/dashboard.dart';
import 'package:promotion_dashboard/view/screens/home/orders/orders_management.dart';
import 'package:promotion_dashboard/view/screens/home/products/products_management.dart';
import 'package:promotion_dashboard/view/screens/home/transactions/transactions_management.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/drawer_item.dart';
import 'package:promotion_dashboard/view/widgets/general/user_info_list_tile.dart';

class CustomDawer extends StatelessWidget {
  const CustomDawer({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(DrawerControllerImp());
    return GetBuilder<DrawerControllerImp>(builder: (controller) {
      return Container(
        width: MediaQuery.sizeOf(context).width * 0.7,
        color: AppColors.white,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 12,
              ),
            ),
            SliverToBoxAdapter(
              child: UserInfoListTile(
                color: AppColors.white,
                userModel: controller.user!,
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  DrawerItem(
                    title: 'Dashboard',
                    imagePath: Assets.imagesSvgDashboard,
                    isActive:
                        controller.selectedIndex == DrawerItems.dashboard.value
                            ? true
                            : false,
                    onTap: () {
                      controller.updateIndex(DrawerItems.dashboard.value);
                    },
                  ),
                  DrawerItem(
                    title: 'Categories',
                    imagePath: Assets.imagesSvgCategories,
                    isActive: controller.selectedIndex ==
                            DrawerItems.categoriesManagement.value
                        ? true
                        : false,
                    onTap: () {
                      controller
                          .updateIndex(DrawerItems.categoriesManagement.value);
                    },
                  ),
                  DrawerItem(
                    title: 'Products',
                    imagePath: Assets.imagesSvgProducts,
                    isActive: controller.selectedIndex ==
                            DrawerItems.productsManagement.value
                        ? true
                        : false,
                    onTap: () {
                      controller
                          .updateIndex(DrawerItems.productsManagement.value);
                    },
                  ),
                  DrawerItem(
                    title: 'Orders',
                    imagePath: Assets.imagesSvgCart,
                    isActive:
                        controller.selectedIndex == DrawerItems.orders.value
                            ? true
                            : false,
                    onTap: () {
                      controller.updateIndex(DrawerItems.orders.value);
                    },
                  ),
                  DrawerItem(
                    title: 'Transactions',
                    imagePath: Assets.imagesSvgTransaction,
                    isActive: controller.selectedIndex ==
                            DrawerItems.transactions.value
                        ? true
                        : false,
                    onTap: () {
                      controller.updateIndex(DrawerItems.transactions.value);
                    },
                  ),
                  DrawerItem(
                    title: 'Notifications',
                    imagePath: Assets.imagesSvgNotifications,
                    isActive: controller.selectedIndex ==
                            DrawerItems.notifications.value
                        ? true
                        : false,
                    onTap: () {
                      controller.updateIndex(DrawerItems.notifications.value);
                    },
                  ),
                  DrawerItem(
                    title: 'Chats',
                    imagePath: Assets.imagesSvgChats,
                    isActive:
                        controller.selectedIndex == DrawerItems.chats.value
                            ? true
                            : false,
                    onTap: () {
                      controller.updateIndex(DrawerItems.chats.value);
                    },
                  ),
                  DrawerItem(
                    title: 'FQA',
                    imagePath: Assets.imagesSvgFqa,
                    isActive: controller.selectedIndex == DrawerItems.faq.value
                        ? true
                        : false,
                    onTap: () {
                      controller.updateIndex(DrawerItems.faq.value);
                    },
                  ),
                  DrawerItem(
                    title: 'Settings',
                    imagePath: Assets.imagesSvgSettings,
                    isActive:
                        controller.selectedIndex == DrawerItems.settings.value
                            ? true
                            : false,
                    onTap: () {
                      controller.updateIndex(DrawerItems.settings.value);
                    },
                  ),
                  DrawerItem(
                    title: 'Logout',
                    imagePath: Assets.imagesSvgLogout,
                    isActive: false,
                    activeIconColor: AppColors.red,
                    inActiveIconColor: AppColors.red,
                    onTap: () async {
                      await controller.logout();
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

enum DrawerItems {
  dashboard(0, Dashboard()),
  categoriesManagement(1, CategoriesManagement()),
  productsManagement(2, ProductsManagement()),
  orders(3, OrdersManagement()),
  transactions(4, TransactionsManagement()),
  chats(5, Chats()),
  notifications(6, SizedBox()),
  faq(7, SizedBox()),
  settings(8, SizedBox());

  final int value;
  final Widget screen;
  const DrawerItems(this.value, this.screen);
}
