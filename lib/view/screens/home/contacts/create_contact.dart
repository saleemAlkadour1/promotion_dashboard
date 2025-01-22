import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/contacts/create_contact_controller.dart';
import 'package:promotion_dashboard/core/classes/validator.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/view/widgets/general/color_picker_dialog.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_image_picker.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class CreateContact extends StatelessWidget {
  const CreateContact({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateContactControllerImp());
    return GetBuilder<CreateContactControllerImp>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.screenColor,
          appBar: AppBar(
            backgroundColor: AppColors.color_F7F9FA,
            elevation: 0,
            scrolledUnderElevation: 0,
            shadowColor: AppColors.transparent,
            title: Text(
              'Create contact',
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
                    // Name
                    Text(
                      'Name',
                      style: MyText.appStyle.fs16.wBold.reColorText.style,
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(
                      myLanguages.entries.toList().length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16,
                          ),
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
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: controller.urlController,
                      validator: (value) => MyValidator.validate(
                        value,
                        type: ValidatorType.text,
                        fieldName: 'The url',
                      ),
                      label: 'Url',
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 16.0),

                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ColorPickerDialog(
                                    initialColor: controller.selectedColor,
                                    onColorSelected: (color) {
                                      controller.selectedColor = color;
                                      controller.update();
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: controller.selectedColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Selected Color: ${controller.selectedColor.value.toRadixString(16).toUpperCase()}',
                          style: MyText.appStyle.fs14.wRegular.style,
                        ),
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
                            await controller.createContact();
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
