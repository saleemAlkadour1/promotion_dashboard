import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/data/model/general/all_expensess_item_model.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/all_expensess/all_expenses_item_header.dart';

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
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              itemModel.title,
              style: MyText.appStyle.fs16.wBold.reColorText
                  .responsiveStyle(context),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              itemModel.date,
              style: MyText.appStyle.fs14.wRegular.reColorLightGray
                  .responsiveStyle(context),
            ),
          ),
          const SizedBox(
            height: 34,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              itemModel.price,
              style: MyText.appStyle.fs24.wSemiBold.reColor_4EB7F2
                  .responsiveStyle(context),
            ),
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
          side: const BorderSide(width: 1, color: AppColors.color_4EB7F2),
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
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              itemModel.title,
              style: MyText.appStyle.fs16.wBold.reColorWhite
                  .responsiveStyle(context),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              itemModel.date,
              style: MyText.appStyle.fs14.wRegular.reColor_FAFAFA
                  .responsiveStyle(context),
            ),
          ),
          const SizedBox(
            height: 34,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              itemModel.price,
              style: MyText.appStyle.fs24.wSemiBold.reColorWhite
                  .responsiveStyle(context),
            ),
          )
        ],
      ),
    );
  }
}
