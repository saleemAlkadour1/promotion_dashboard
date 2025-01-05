import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';

class AppBarDesktpAndTablet extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarDesktpAndTablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
