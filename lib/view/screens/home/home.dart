import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/general/home_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/size_config.dart';
import 'package:promotion_dashboard/view/widgets/general/app_bar/app_bar_mobile.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/custom_dawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.screenColor,
        appBar: MediaQuery.sizeOf(context).width <= SizeConfig.tablet
            ? const AppBarMobile()
            : null,
        drawer: MediaQuery.sizeOf(context).width <= SizeConfig.tablet
            ? const CustomDawer()
            : null,
        body: Row(
          children: [
            MediaQuery.sizeOf(context).width > SizeConfig.tablet
                ? const Expanded(
                    child: CustomDawer(),
                  )
                : const SizedBox(),
            Expanded(
              flex: 4,
              child: controller.screens[controller.selectedIndex],
            ),
          ],
        ),
      );
    });
  }
}
