import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/data/model/all_expensess_item_model.dart';
import 'package:promotion_dashboard/widgets/all_expenses_item_header.dart';

class InActiveAllExpansessItem extends StatelessWidget {
  const InActiveAllExpansessItem({
    super.key,
    required this.itemModel,
  });

  final AllExpensessItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.color_F1F1F1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AllExpensesItemHeader(
            imagePath: itemModel.imagePath,
          ),
          const SizedBox(
            height: 34,
          ),
          Text(
            itemModel.title,
            style: MyText.appStyle.fs16.wBold.reColorText.style(context),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            itemModel.date,
            style:
                MyText.appStyle.fs14.wRegular.reColorLightGray.style(context),
          ),
          const SizedBox(
            height: 34,
          ),
          Text(
            itemModel.price,
            style: MyText.appStyle.fs24.wSemiBold.reColor_4EB7F2.style(context),
          )
        ],
      ),
    );
  }
}

class ActiveAllExpansessItem extends StatelessWidget {
  const ActiveAllExpansessItem({
    super.key,
    required this.itemModel,
  });

  final AllExpensessItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: ShapeDecoration(
        color: AppColors.color_4EB7F2,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.color_F1F1F1),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AllExpensesItemHeader(
            imagePath: itemModel.imagePath,
            color: AppColors.white,
            imageBackgroundColor:
                AppColors.white.withOpacity(0.10000000149011612),
          ),
          const SizedBox(
            height: 34,
          ),
          Text(
            itemModel.title,
            style: MyText.appStyle.fs16.wBold.reColorWhite.style(context),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            itemModel.date,
            style: MyText.appStyle.fs14.wRegular.reColor_FAFAFA.style(context),
          ),
          const SizedBox(
            height: 34,
          ),
          Text(
            itemModel.price,
            style: MyText.appStyle.fs24.wSemiBold.reColorWhite.style(context),
          )
        ],
      ),
    );
  }
}