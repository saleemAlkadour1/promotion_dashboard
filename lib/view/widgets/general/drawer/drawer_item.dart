import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    this.onTap,
    required this.isActive,
    this.imagePath,
    this.activeIconColor,
    this.inActiveIconColor,
    required this.title,
    this.isSvg = true,
    this.icon,
  });
  final String title;
  final String? imagePath;
  final Color? activeIconColor;
  final Color? inActiveIconColor;
  final Function()? onTap;
  final bool isActive;
  final bool? isSvg;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: isSvg == true
              ? SvgPicture.asset(
                  imagePath!,
                  width: 20,
                  height: 20,
                  colorFilter: isActive
                      ? ColorFilter.mode(
                          activeIconColor ?? AppColors.color_4EB7F2,
                          BlendMode.srcIn)
                      : ColorFilter.mode(
                          inActiveIconColor ?? AppColors.color_064061,
                          BlendMode.srcIn),
                )
              : Icon(
                  icon,
                  size: 20,
                  color: isActive
                      ? (activeIconColor ?? AppColors.color_4EB7F2)
                      : (inActiveIconColor ?? AppColors.color_064061),
                ),
        ),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              title,
              style: isActive
                  ? MyText.appStyle.fs16.wBold.reColor_4EB7F2
                      .responsiveStyle(context)
                  : MyText.appStyle.fs16.wMedium.reColorText
                      .responsiveStyle(context),
            ),
          ),
        ),
        trailing: isActive
            ? Container(
                width: 3.27,
                color: AppColors.color_4EB7F2,
              )
            : null,
      ),
    );
  }
}
