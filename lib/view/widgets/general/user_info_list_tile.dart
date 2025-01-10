import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/data/model/profile/user_model.dart';

class UserInfoListTile extends StatelessWidget {
  final UserModel userModel;
  final Color? color;

  const UserInfoListTile({
    super.key,
    this.color,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    double imageSize = 50;

    return Card(
      color: color ?? AppColors.color_FAFAFA,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0), // إضافة مسافة حول `ListTile`
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // صورة دائرية
            ClipRRect(
              borderRadius: BorderRadius.circular(imageSize / 2),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: imageSize,
                height: imageSize,
                imageUrl: 'https://i.ibb.co/1ZDRN67/profile.jpg',
                progressIndicatorBuilder: (context, url, progress) =>
                    const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.color_064061,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    Icons.error,
                    color: AppColors.red,
                    size: imageSize / 2,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16), // مسافة بين الصورة والنصوص

            // النصوص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المستخدم
                  Text(
                    userModel.firstName,
                    style: MyText.appStyle.fs16.wSemiBold.reColorText
                        .responsiveStyle(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(
                      height: 4), // مسافة بين الاسم والبريد الإلكتروني

                  // البريد الإلكتروني
                  Text(
                    userModel.email,
                    style: MyText.appStyle.fs12.wRegular.reColorLightGray
                        .responsiveStyle(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
