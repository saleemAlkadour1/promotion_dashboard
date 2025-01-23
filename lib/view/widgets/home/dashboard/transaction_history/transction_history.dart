import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/transaction_history/transaction_history_list_view.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/transaction_history/transction_history_header.dart';

class TransctionHistory extends StatelessWidget {
  const TransctionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransctionHistoryHeader(),
        const SizedBox(
          height: 20,
        ),
        Text(
          '13 April 2022',
          style: MyText.appStyle.fs16.wMedium.reColorLightGray
              .responsiveStyle(context),
        ),
        const SizedBox(
          height: 16,
        ),
        const TransactionHistoryListView(),
      ],
    );
  }
}
