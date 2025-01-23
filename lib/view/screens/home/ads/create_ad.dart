import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:promotion_dashboard/controller/home/ads/create_ad_controller.dart';
import 'package:promotion_dashboard/core/classes/validator.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_image_picker.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class CreateAd extends StatelessWidget {
  const CreateAd({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateAdControllerImp());
    return GetBuilder<CreateAdControllerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.screenColor,
          appBar: AppBar(
            backgroundColor: AppColors.color_F7F9FA,
            elevation: 0,
            scrolledUnderElevation: 0,
            shadowColor: AppColors.transparent,
            title: Text(
              'Create ad',
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
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formState,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                      controller: controller.startDateController,
                      readOnly: true,
                      mouseCursor: SystemMouseCursors.click,
                      validator: (value) => MyValidator.validate(
                        value,
                        type: ValidatorType.text,
                        fieldName: 'the start date',
                      ),
                      label: 'Start date',
                      inputType: TextInputType.datetime,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2025),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          controller.startDateController.text =
                              DateFormat('yyyy-MM-dd').format(picked);
                          controller.update();
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      controller: controller.endDateController,
                      readOnly: true,
                      mouseCursor: SystemMouseCursors.click,
                      validator: (value) => MyValidator.validate(
                        value,
                        type: ValidatorType.text,
                        fieldName: 'the end date',
                      ),
                      label: 'End date',
                      inputType: TextInputType.datetime,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2025),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          controller.endDateController.text =
                              DateFormat('yyyy-MM-dd').format(picked);
                          controller.update();
                        }
                      },
                    ),
                    const SizedBox(height: 16.0),

                    CustomTextField(
                      controller: controller.linkUrlController,
                      label: 'Link url',
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: controller.activeValue,
                          onChanged: controller.toggleActive,
                        ),
                        Text('Active',
                            style: MyText.appStyle.fs13.wMedium
                                .reCustomColor(AppColors.black)
                                .style),
                      ],
                    ),
                    const SizedBox(height: 32),

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
                    const SizedBox(height: 32),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          title: 'Cancel',
                          height: 50,
                          backgroundColor: AppColors.white,
                          textColor: Colors.blue,
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        const SizedBox(width: 16),
                        CustomButton(
                          height: 50,
                          title: controller.loading == true
                              ? 'Loading...'
                              : 'Save',
                          onPressed: () async {
                            await controller.createAd();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
