import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/data/model/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transactionModel,
  });
  final TransactionModel transactionModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.color_FAFAFA,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          transactionModel.title,
          style: MyText.appStyle.fs16.wSemiBold.reColorText
              .customHeight(2)
              .responsiveStyle(context),
        ),
        subtitle: Text(
          transactionModel.date,
          style: MyText.appStyle.fs16.wRegular.reColorLightGray
              .responsiveStyle(context),
        ),
        trailing: Text(
          r'$' + transactionModel.amount,
          style: MyText.appStyle.fs20.wSemiBold
              .reCustomColor(
                transactionModel.isWithdrawal == true
                    ? AppColors.color_F3735E
                    : AppColors.color_7DD97B,
              )
              .responsiveStyle(context),
        ),
      ),
    );
  }
}
