import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/widgets/custom_background_container.dart';
import 'package:promotion_dashboard/widgets/my_cards_section.dart';
import 'package:promotion_dashboard/widgets/transction_history.dart';

class MyCardsAndTransactionHistorySection extends StatelessWidget {
  const MyCardsAndTransactionHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomBackgroundContainer(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          MyCardsSection(),
          Divider(
            color: AppColors.color_F1F1F1,
            height: 40,
          ),
          TransctionHistory(),
        ],
      ),
    );
  }
}
