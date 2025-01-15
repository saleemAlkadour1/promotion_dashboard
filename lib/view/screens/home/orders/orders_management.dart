import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/orders/orders_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';
import 'package:promotion_dashboard/view/widgets/orders/sf_data_grid_orders.dart';

class OrdersManagement extends StatelessWidget {
  const OrdersManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersManagementControllerImp());
    return GetBuilder<OrdersManagementControllerImp>(builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.orders == null,
      );
      if (res.isValid) {
        return res.response!;
      }
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
                  'Orders',
                  style: MyText.appStyle.fs24.wBold.reColorText
                      .responsiveStyle(context),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomTextField(
                          controller: TextEditingController(), label: 'Search'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Expanded(
                  child: SFDataGridOrders(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
