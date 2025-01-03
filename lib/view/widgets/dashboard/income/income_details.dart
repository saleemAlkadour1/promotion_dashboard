import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/data/model/item_details_model.dart';
import 'package:promotion_dashboard/view/widgets/dashboard/income/item_details.dart';

class IncomeDetails extends StatelessWidget {
  const IncomeDetails({
    super.key,
  });
  static List<ItemDetailsModel> items = [
    ItemDetailsModel(
        color: AppColors.color_208CC8, title: 'Design service', value: '40%'),
    ItemDetailsModel(
        color: AppColors.color_4EB7F2, title: 'Design product', value: '25%'),
    ItemDetailsModel(
        color: AppColors.color_064061, title: 'Product royalti', value: '20%'),
    ItemDetailsModel(
        color: AppColors.color_E2DECD, title: 'Other', value: '22%'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: items
            .map(
              (e) => ItemDetails(itemDetailsModel: e),
            )
            .toList());
  }
}
