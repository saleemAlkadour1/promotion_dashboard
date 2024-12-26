import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/core/functions/size.dart';
import 'package:promotion_dashboard/data/model/drawer_item_model.dart';
import 'package:promotion_dashboard/widgets/drawer_item.dart';

class DrawerItemsListView extends StatefulWidget {
  const DrawerItemsListView({
    super.key,
  });

  @override
  State<DrawerItemsListView> createState() => _DrawerItemsListViewState();
}

class _DrawerItemsListViewState extends State<DrawerItemsListView> {
  final List<DrawerItemModel> items = const [
    DrawerItemModel(title: 'Dashboard', imagePath: Assets.imagesSvgDashboard),
    DrawerItemModel(
        title: 'My Transaction', imagePath: Assets.imagesSvgMyTransctions),
    DrawerItemModel(title: 'Statistics', imagePath: Assets.imagesSvgStatistics),
    DrawerItemModel(
        title: 'Wallet Account', imagePath: Assets.imagesSvgWalletAccount),
    DrawerItemModel(
        title: 'My Investments', imagePath: Assets.imagesSvgMyInvestments),
  ];
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (activeIndex != index) {
              setState(() {
                activeIndex = index;
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: height(20),
            ),
            child: DrawerItem(
              drawerItemModel: items[index],
              isActive: activeIndex == index,
            ),
          ),
        );
      },
    );
  }
}
