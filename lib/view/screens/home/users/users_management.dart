import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/users/users_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';
import 'package:promotion_dashboard/view/widgets/home/users/sf_data_grid_users.dart';

class UsersManagement extends StatelessWidget {
  const UsersManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UsersManagementControllerImp());
    return GetBuilder<UsersManagementControllerImp>(builder: (controller) {
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
                  'Users',
                  style: MyText.appStyle.fs24.wBold
                      .reCustomColor(AppColors.black)
                      .responsiveStyle(context),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        label: 'Roles',
                        value: controller.rolesValue,
                        items: const ['All', 'user', 'admin'],
                        onChanged: controller.updateRolesValue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Expanded(
                  child: SFDataGridUsers(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
