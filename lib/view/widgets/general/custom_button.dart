import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final Color? shadowColor;
  const CustomButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.height,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 62,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadowColor: shadowColor ?? AppColors.black,
          backgroundColor: backgroundColor ?? AppColors.color_4EB7F2,
          overlayColor: backgroundColor ?? AppColors.color_4EB7F2,
          foregroundColor: backgroundColor ?? AppColors.color_4EB7F2,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: MyText.appStyle.fs18.wSemiBold
              .reCustomColor(textColor ?? AppColors.white)
              .responsiveStyle(context),
        ),
      ),
    );
  }
}
