// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/widgets/drawer_items_list_view.dart';
import 'package:promotion_dashboard/widgets/size.dart';
import 'package:promotion_dashboard/widgets/user_info_list_tile.dart';

class CustomDawer extends StatelessWidget {
  const CustomDawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          UserInfoListTile(
            imagePath: Assets.imagesSvgAvatar3,
            title: 'Lekan Okeowo',
            subtitle: 'demo@gmail.com',
          ),
          SizedBoxHeight(8),
          DrawerItemsListView()
        ],
      ),
    );
  }
}