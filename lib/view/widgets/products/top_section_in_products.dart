import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';

class TopSectionInProducts extends StatelessWidget {
  const TopSectionInProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 32,
        ),
        Text(
          'Products',
          style: MyText.appStyle.fs24.wBold.reColorText.style(context),
        )
      ],
    );
  }
}
