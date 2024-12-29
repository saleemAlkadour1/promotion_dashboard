import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/widgets/custom_text_field.dart';

class TitleTextField extends StatelessWidget {
  final String title;
  final String hintTextField;
  const TitleTextField(
      {super.key, required this.title, required this.hintTextField});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: MyText.appStyle.fs16.wMedium.reColorText.style(context),
        ),
        const SizedBox(
          height: 16,
        ),
        CustomTextField(
          hintText: hintTextField,
        ),
      ],
    );
  }
}
