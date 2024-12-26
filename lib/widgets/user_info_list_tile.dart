import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';

class UserInfoListTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  const UserInfoListTile(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.color_FAFAFA,
      elevation: 0,
      child: ListTile(
        leading: SvgPicture.asset(imagePath),
        title: Text(
          title,
          style: MyText.appStyle.fs16.wSemiBold.reColorText.style(context),
        ),
        subtitle: Text(
          subtitle,
          style: MyText.appStyle.fs12.wRegular.reColorLightGray.style(context),
        ),
      ),
    );
  }
}
