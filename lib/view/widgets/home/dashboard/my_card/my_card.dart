// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/core/constants/size_config.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return AspectRatio(
      aspectRatio: 420 / 215,
      child: Container(
        padding: EdgeInsets.only(left: 31, right: 42, top: 16),
        decoration: ShapeDecoration(
          image: const DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(Assets.imagesPicturesCardBackground)),
          color: const Color(0xFF4EB7F2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                'Name card',
                style: MyText.appStyle.fs16.wRegular.reColorWhite
                    .responsiveStyle(context),
              ),
              subtitle: Text(
                'Syah Bandi',
                style: MyText.appStyle.fs20.wMedium.reColorWhite
                    .responsiveStyle(context),
              ),
              trailing: SvgPicture.asset(Assets.imagesSvgGallery),
            ),
            Expanded(child: SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '0918 8124 0042 8129',
                  style: width > SizeConfig.tablet && width <= 1392
                      ? MyText.appStyle.fs18.wSemiBold.reColorWhite
                          .responsiveStyle(context)
                      : MyText.appStyle.fs18.wSemiBold.reColorWhite
                          .responsiveStyle(context),
                ),
                Text(
                  '12/20 - 124',
                  style: MyText.appStyle.fs16.wRegular.reColorWhite
                      .responsiveStyle(context),
                ),
              ],
            ),
            SizedBox(
              height: (width > SizeConfig.desktop && width <= 1392) ? 0 : 26,
            )
          ],
        ),
      ),
    );
  }
}
//[log] 1392.0
