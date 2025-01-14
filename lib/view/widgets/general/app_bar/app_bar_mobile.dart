import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';

class AppBarMobile extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.screenColor,
      foregroundColor: AppColors.screenColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: AppColors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: AppColors.black,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
