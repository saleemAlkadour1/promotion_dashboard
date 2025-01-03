import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/data/model/drawer_item_model.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/drawer_item.dart';

class DrawerItemsListView extends StatelessWidget {
  const DrawerItemsListView({
    super.key,
    required this.onIndexSelected,
    required this.activeIndex,
  });
  final Function(int) onIndexSelected;
  final int activeIndex;
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

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onIndexSelected(index);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
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
