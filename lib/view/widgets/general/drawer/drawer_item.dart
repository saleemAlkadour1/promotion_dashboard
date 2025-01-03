import 'package:flutter/material.dart';
import 'package:promotion_dashboard/data/model/drawer_item_model.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/active_and_inactive_drawer_item.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key, required this.drawerItemModel, required this.isActive});
  final DrawerItemModel drawerItemModel;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveDrawerItem(
            drawerItemModel: drawerItemModel,
          )
        : InActiveDrawerItem(drawerItemModel: drawerItemModel);
  }
}
