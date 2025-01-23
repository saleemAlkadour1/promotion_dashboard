import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/ads/ads_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';
import 'package:promotion_dashboard/view/widgets/home/ads/sf_data_grid_ads.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';

class AdsManagement extends StatelessWidget {
  const AdsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AdsManagementControllerImp());
    return GetBuilder<AdsManagementControllerImp>(builder: (controller) {
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
                  'Ads',
                  style: MyText.appStyle.fs24.wBold
                      .reCustomColor(AppColors.black)
                      .responsiveStyle(context),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        label: 'Active',
                        value: controller.activeValue,
                        items: const [
                          'All',
                          'Yes',
                          'No',
                        ],
                        onChanged: controller.updateActiveValue,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      title: 'Add ad',
                      height: 45,
                      onPressed: () async {
                        await Get.toNamed(AppRoutes.createAd);
                        await controller.getAdsData(
                            pageIndex:
                                controller.paganationDataModel.currentPage);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Expanded(
                  child: SfDataGridAds(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
