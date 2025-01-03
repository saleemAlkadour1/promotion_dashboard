// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/dashboard/quick_invoice/latest_transaction_list_view.dart';

class LatestTransaction extends StatelessWidget {
  const LatestTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latest Transaction',
          style: MyText.appStyle.fs16.wMedium.reColorText.style(context),
        ),
        SizedBox(
          height: 12,
        ),
        LatestTransactionListView(),
      ],
    );
  }
}
