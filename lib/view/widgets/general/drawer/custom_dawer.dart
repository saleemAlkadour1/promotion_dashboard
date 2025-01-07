// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/drawer_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/data/model/user_info_model.dart';
import 'package:promotion_dashboard/view/screens/categories_management.dart';
import 'package:promotion_dashboard/view/screens/dashboard.dart';
import 'package:promotion_dashboard/view/screens/products_management.dart';
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
                  userInfoModel: UserInfoModel(
                      imagePath: Assets.imagesSvgAvatar1,
                      title: 'Saleem Alkadour',
                      subTitle: 'saleem8@gmail.com')),
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
                    title: 'Categories management',
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
                    title: 'Products management',
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
                    title: 'Tansaction',
                    imagePath: Assets.imagesSvgTransaction,
                    isActive: controller.selectedIndex ==
                            DrawerItems.transaction.value
                        ? true
                        : false,
                    onTap: () {
                      controller.updateIndex(DrawerItems.transaction.value);
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
                    onTap: () {},
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
  transaction(3, SizedBox()),
  notifications(4, SizedBox()),
  faq(5, SizedBox()),
  settings(6, SizedBox());

  final int value;
  final Widget screen;
  const DrawerItems(this.value, this.screen);
}
