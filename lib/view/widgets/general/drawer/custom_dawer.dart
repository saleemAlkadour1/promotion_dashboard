// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/drawer_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/core/constants/size_config.dart';
import 'package:promotion_dashboard/data/model/drawer_item_model.dart';
import 'package:promotion_dashboard/data/model/user_info_model.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/active_and_inactive_drawer_item.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/drawer_items_list_view.dart';
import 'package:promotion_dashboard/view/widgets/general/size.dart';
import 'package:promotion_dashboard/view/widgets/general/user_info_list_tile.dart';

class CustomDawer extends StatelessWidget {
  const CustomDawer({super.key, required this.onIndexSelected});
  final Function(int) onIndexSelected;

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
              child: UserInfoListTile(
                  color: AppColors.white,
                  userInfoModel: UserInfoModel(
                      imagePath: Assets.imagesSvgAvatar1,
                      title: 'Saleem Alkadour',
                      subTitle: 'saleem8@gmail.com')),
            ),
            DrawerItemsListView(
              activeIndex: controller.activeIndex,
              onIndexSelected: (index) {
                controller.updateIndex(index);
                onIndexSelected(index);
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  InActiveDrawerItem(
                    drawerItemModel: DrawerItemModel(
                      title: 'Setting system',
                      imagePath: Assets.imagesSvgSettings,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InActiveDrawerItem(
                    drawerItemModel: DrawerItemModel(
                      title: 'Logout account',
                      imagePath: Assets.imagesSvgLogout,
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
