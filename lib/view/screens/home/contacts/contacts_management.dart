import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/contacts/contacts_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/view/widgets/contacts/sf_data_grid_contacts.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class ContactsManagement extends StatelessWidget {
  const ContactsManagement({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ContactsManagementControllerImp());
    return GetBuilder<ContactsManagementControllerImp>(builder: (controller) {
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
                  'Contacts',
                  style: MyText.appStyle.fs24.wBold
                      .reCustomColor(AppColors.black)
                      .responsiveStyle(context),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        label: 'Search',
                        controller: controller.searchController,
                        onChanged: controller.filterContacts,
                        inputType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      title: 'Add contact',
                      height: 45,
                      onPressed: () async {
                        await Get.toNamed(AppRoutes.createContact);
                        controller.getContactsData(
                            pageIndex:
                                controller.paganationDataModel.currentPage);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Expanded(
                  child: SFDataGridContacts(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
