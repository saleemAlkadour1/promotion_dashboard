// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  const CustomTextField({super.key, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              MyText.appStyle.fs16.wRegular.reColorLightGray.style(context),
          fillColor: AppColors.color_FAFAFA,
          filled: true,
          contentPadding: EdgeInsets.all(20),
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder()),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.color_FAFAFA,
      ),
    );
  }
}
