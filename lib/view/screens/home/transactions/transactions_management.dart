import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/transactions/transactions_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';
import 'package:promotion_dashboard/view/widgets/transactions/sf_data_grid_transactions.dart';

class TransactionsManagement extends StatelessWidget {
  const TransactionsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TransactionsManagementControllerImp());
    return GetBuilder<TransactionsManagementControllerImp>(
        builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.screenColor,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transactions',
                  style: MyText.appStyle.fs24.wBold.reColorText
                      .responsiveStyle(context),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        label: 'Type',
                        value: controller.typeValue,
                        items: const [
                          'All',
                          'out',
                          'in',
                        ],
                        onChanged: controller.updateTypeValue,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                const Expanded(
                  child: SFDataGridTransactions(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
