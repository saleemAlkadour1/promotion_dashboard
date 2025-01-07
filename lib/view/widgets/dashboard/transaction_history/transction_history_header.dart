import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';

class TransctionHistoryHeader extends StatelessWidget {
  const TransctionHistoryHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Transaction History',
          style: MyText.appStyle.fs20.wSemiBold.wSemiBold.reColorText
              .responsiveStyle(context),
        ),
        Text(
          'See all',
          style: MyText.appStyle.fs16.wRegular.reColor_4EB7F2
              .responsiveStyle(context),
        )
      ],
    );
  }
}
