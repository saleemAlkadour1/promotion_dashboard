import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';

void showDeleteConfirmationDialog({
  required String title,
  required String message,
  required VoidCallback onConfirm,
}) {
  Get.defaultDialog(
    title: title,
    middleText: message,
    titleStyle:
        MyText.appStyle.fs16.wSemiBold.reCustomColor(Colors.black).style,
    confirm: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.red,
        ),
        onPressed: () {
          Get.back();
          onConfirm();
        },
        child: Text('Delete',
            style: MyText.appStyle.fs14.wSemiBold.reColorWhite.style)),
    cancel: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
        ),
        onPressed: () {
          Get.back();
        },
        child: Text(
          'Cancel',
          style:
              MyText.appStyle.fs14.wSemiBold.reCustomColor(Colors.black).style,
        )),
  );
}
