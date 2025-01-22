import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/categories/create_category_controller.dart';
import 'package:promotion_dashboard/core/classes/validator.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_image_picker.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class CreateCategory extends StatelessWidget {
  const CreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateCategoryControllerImp());
    return GetBuilder<CreateCategoryControllerImp>(
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColors.screenColor,
            appBar: AppBar(
                backgroundColor: AppColors.color_F7F9FA,
                elevation: 0,
                scrolledUnderElevation: 0,
                shadowColor: AppColors.transparent,
                title: Text(
                  'Create category',
                  style: MyText.appStyle.fs16.wBold.reColorText.style,
                ),
                automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                    ),
                  ),
                )),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.formState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: MyText.appStyle.fs16.wBold.reColorText.style,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        ...List.generate(
                          myLanguages.entries.toList().length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CustomTextField(
                                controller: controller.nameController[index],
                                validator:
                                    (myLanguages.entries.toList()[index]).key ==
                                            'en'
                                        ? (value) => MyValidator.validate(
                                              value,
                                              type: ValidatorType.text,
                                              fieldName: 'the name',
                                            )
                                        : null,
                                label:
                                    '${(myLanguages.entries.toList()[index].value['name']).toString().capitalizeFirst}',
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Description',
                          style: MyText.appStyle.fs16.wBold.reColorText.style,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        ...List.generate(
                          myLanguages.entries.toList().length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CustomTextField(
                                controller:
                                    controller.descriptionController[index],
                                validator:
                                    (myLanguages.entries.toList()[index]).key ==
                                            'en'
                                        ? (value) => MyValidator.validate(
                                              value,
                                              type: ValidatorType.text,
                                              fieldName: 'the description',
                                            )
                                        : null,
                                label:
                                    '${(myLanguages.entries.toList()[index].value['name']).toString().capitalizeFirst}',
                              ),
                            );
                          },
                        )
                      ],
                    ),

                    const SizedBox(height: 16.0),

                    CustomDropdown(
                      label: 'Display method ',
                      value: controller.displayMethodValue,
                      items: const ['GridView', 'ListTile'],
                      onChanged: controller.updateDisplayMethodValue,
                    ),
                    const SizedBox(height: 16.0),
                    // Visible Dropdown
                    CustomDropdown(
                      label: 'Visible',
                      value: controller.visibleValue,
                      items: const ['Yes', 'No'],
                      onChanged: controller.updateVisibleValue,
                    ),
                    const SizedBox(height: 16.0),

                    // Avilable Dropdown
                    CustomDropdown(
                      label: 'Avilable',
                      value: controller.avilableValue,
                      items: const ['Yes', 'No'],
                      onChanged: controller.updateAvilableValue,
                    ),
                    const SizedBox(height: 16.0),

                    // Pick and Display Images
                    CustomImagePicker(
                      images: [
                        if (controller.image != null) controller.image!,
                      ],
                      onAddImage: controller.pickImage,
                      onRemoveImage: (p0) {
                        controller.image = null;
                        controller.update();
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomButton(
                          height: 40,
                          title: controller.loading == true
                              ? 'Loading...'
                              : 'Save',
                          onPressed: () async {
                            await controller.createCategory();
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomButton(
                            title: 'Cancel',
                            height: 40,
                            backgroundColor: AppColors.white,
                            textColor: Colors.blue,
                            onPressed: () {
                              Get.back();
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
