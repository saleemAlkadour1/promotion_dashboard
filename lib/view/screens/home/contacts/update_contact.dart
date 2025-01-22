import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/contacts/update_contact_controller.dart';
import 'package:promotion_dashboard/core/classes/validator.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/functions/error_image.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/view/screens/home/contacts/create_contact.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_image_picker.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class UpdateContact extends StatelessWidget {
  const UpdateContact({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateContactControllerImp());
    return GetBuilder<UpdateContactControllerImp>(
      builder: (controller) {
        var res = HandlingDataView(
          loading: controller.loading,
          dataIsEmpty: controller.contactModel == null,
        );
        if (res.isValid) {
          return res.response!;
        }
        return Scaffold(
          backgroundColor: AppColors.screenColor,
          appBar: AppBar(
            backgroundColor: AppColors.color_F7F9FA,
            elevation: 0,
            scrolledUnderElevation: 0,
            shadowColor: AppColors.transparent,
            title: Text(
              'Update contact',
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

                    Row(
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
                        const SizedBox(width: 16),
                        Text(
                          'Selected Color: ${controller.selectedColor.value.toRadixString(16).toUpperCase()}',
                          style: MyText.appStyle.fs14.wRegular.style,
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                    controller.isImageFind == true
                        ? SizedBox(
                            width: 100,
                            height: 100,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.contactModel!.icon,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: myErrorWidget,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.isImageFind = false;
                                        controller.image = null;
                                        controller.update();
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.edit,
                                          color: AppColors.black,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : CustomImagePicker(
                            images: [
                              if (controller.image != null) controller.image!,
                            ],
                            onAddImage: controller.pickImage,
                            onRemoveImage: (file) {
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
                            await controller.updateContact();
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
