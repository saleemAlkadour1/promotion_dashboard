import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/update_product_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/functions/error_image.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_image_picker.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class UpdateProduct extends StatelessWidget {
  const UpdateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdateProductControllerImp());

    return GetBuilder<UpdateProductControllerImp>(builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.productModel == null,
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
                'Edit product',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                CustomDropdown(
                  value: controller.categoryValue.isNotEmpty &&
                          controller.categoriesName
                              .contains(controller.categoryValue)
                      ? controller.categoryValue
                      : null,
                  label: 'Category',
                  items: controller.categoriesName.toSet().toList(),
                  onChanged: controller.updateCategoryValue,
                ),

                const SizedBox(height: 16),

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
                            controller: controller.descriptionController[index],
                            label:
                                '${(myLanguages.entries.toList()[index].value['name']).toString().capitalizeFirst}',
                          ),
                        );
                      },
                    )
                  ],
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
                CustomDropdown(
                  label: 'Avilable',
                  value: controller.availableValue,
                  items: const ['Yes', 'No'],
                  onChanged: controller.updateAvailableValue,
                ),
                const SizedBox(height: 16.0),

                // Purchase Price
                CustomTextField(
                  controller: controller.purchasePriceController,
                  label: 'Purchase Price',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),

                CustomTextField(
                  controller: controller.salePriceController,
                  label: 'Sale Price',
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                // Min
                controller.typeValue != Product.live.type
                    ? CustomTextField(
                        controller: controller.minController,
                        label: 'Min',
                        inputType: TextInputType.number,
                      )
                    : const SizedBox(),

                // Max

                SizedBox(
                    height:
                        controller.typeValue != Product.live.type ? 16.0 : 0),
                controller.typeValue != Product.live.type
                    ? CustomTextField(
                        controller: controller.maxController,
                        label: 'Max',
                        inputType: TextInputType.number,
                      )
                    : const SizedBox(),
                SizedBox(
                    height:
                        controller.typeValue != Product.live.type ? 16.0 : 0),

                // Source Dropdown
                CustomDropdown(
                  label: 'Source',
                  value: controller.sourceValue,
                  items: const ['internal', 'external'],
                  onChanged: controller.updateSourceValue,
                ),
                const SizedBox(height: 16.0),
                // Numberly Dropdown
                controller.typeValue == Product.manual.type
                    ? CustomDropdown(
                        label: 'Numberly',
                        value: controller.numberlyValue,
                        items: const ['Yes', 'No'],
                        onChanged: controller.updateNumberlyValue,
                      )
                    : const SizedBox(),
                const SizedBox(height: 16.0),

                Row(
                  children: [
                    // Pick and Display Images
                    CustomImagePicker(
                      images: controller.selectedImages,
                      onAddImage: controller.pickImages,
                      onRemoveImage: controller.removeImage,
                    ),
                    const SizedBox(width: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...List.generate(controller.oldImages.length, (index) {
                          return SizedBox(
                            width: 100,
                            height: 100,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.oldImages[index],
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
                                  top: 4,
                                  right: 4,
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.removeOldImage(
                                            controller.oldImages[index]);
                                        controller.update();
                                      },
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: AppColors.black,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16.0),

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
                          controller.cancel();
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomButton(
                      height: 50,
                      title: controller.loading == true ? 'Loading...' : 'Save',
                      onPressed: controller.updateProuct,
                    ),
                  ],
                ),
              ],
            ),
          ));
    });
  }
}

enum Product {
  live('live'),
  store('store'),
  manual('manual');

  final String type;
  const Product(this.type);
}
