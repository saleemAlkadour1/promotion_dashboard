import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/data/model/user_info_model.dart';

class UserInfoListTile extends StatelessWidget {
  final UserInfoModel userInfoModel;
  const UserInfoListTile({
    super.key,
    required this.userInfoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.color_FAFAFA,
      elevation: 0,
      child: ListTile(
        leading: SvgPicture.asset(userInfoModel.imagePath),
        title: Text(
          userInfoModel.title,
          style: MyText.appStyle.fs16.wSemiBold.reColorText.style(context),
        ),
        subtitle: Text(
          userInfoModel.subTitle,
          style: MyText.appStyle.fs12.wRegular.reColorLightGray.style(context),
        ),
      ),
    );
  }
}
