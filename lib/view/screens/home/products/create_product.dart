import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/create_product_controller.dart';
import 'package:promotion_dashboard/core/classes/validator.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_drop_down.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_image_picker.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class CreateProduct extends StatelessWidget {
  const CreateProduct({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreateProductControllerImp());

    return GetBuilder<CreateProductControllerImp>(builder: (controller) {
      return Scaffold(
          backgroundColor: AppColors.screenColor,
          appBar: AppBar(
              backgroundColor: AppColors.color_F7F9FA,
              elevation: 0,
              scrolledUnderElevation: 0,
              shadowColor: AppColors.transparent,
              title: Text(
                'Add product',
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
                  //Category
                  CustomDropdown(
                    label: 'Category',
                    items: controller.categoriesName.toSet().toList(),
                    onChanged: controller.updateCategoryValue,
                  ),
                  const SizedBox(height: 16.0),
                  // Type Dropdown
                  CustomDropdown(
                    label: 'Type',
                    value: controller.typeValue,
                    items: [
                      Product.live.type,
                      Product.store.type,
                      Product.manual.type,
                    ],
                    onChanged: controller.updateTypeValue,
                  ),
                  const SizedBox(height: 16.0),
                  if (controller.typeValue == Product.live.type)
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 3,
                            child: CustomDropdown(
                              label: 'Server name',
                              value: controller.serverNameValue,
                              items: const ['five_sim'],
                              onChanged: controller.updateServerNameValue,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomButton(
                            height: 50,
                            title: 'Link',
                            onPressed: () {
                              controller.link();
                            },
                          ),
                        ],
                      ),
                    ),

                  // Dynamic Values Section (Manual Type)
                  if (controller.typeValue == Product.manual.type)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.inputs.isNotEmpty)
                          Column(
                            children: List.generate(controller.inputs.length,
                                (index) {
                              final item = controller.inputs[index];
                              return Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Type: ${item['type']}"),
                                      Text(
                                          "Label English: ${item['label']['en']}"),
                                      Text(
                                          "Label Arabic: ${item['label']['ar']}"),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        controller.deleteDynamicValue(index),
                                  ),
                                ),
                              );
                            }),
                          ),
                        if (controller.inputs.isNotEmpty) const Divider(),
                        const SizedBox(height: 8.0),
                        CustomDropdown(
                          label: 'Type',
                          value: controller.typeManualLabelValue,
                          items: const [
                            'text',
                            'number',
                            'date',
                            'datetime',
                            'image',
                            'file',
                            'boolean'
                          ],
                          onChanged: controller.updateTypeManualLabelValue,
                        ),
                        const SizedBox(height: 8.0),
                        CustomTextField(
                          label: 'Label English',
                          controller: controller.labelController,
                        ),
                        const SizedBox(height: 8.0),
                        CustomTextField(
                          label: 'Label Arabic',
                          controller: controller.valueController,
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: controller.requiredValue,
                              onChanged: controller.toggleRequired,
                            ),
                            Text('required',
                                style: MyText.appStyle.fs13.wMedium
                                    .reCustomColor(AppColors.black)
                                    .style),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton.icon(
                          onPressed: controller.addDynamicValue,
                          icon: const Icon(Icons.add, color: AppColors.white),
                          label: Text(
                            'Add item',
                            style:
                                MyText.appStyle.fs14.wMedium.reColorWhite.style,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.color_4EB7F2,
                          ),
                        ),
                      ],
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
                    validator: (value) => MyValidator.validate(
                      value,
                      type: ValidatorType.price,
                      fieldName: 'The purchase price',
                    ),
                    label: 'Purchase Price',
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 16.0),

                  CustomTextField(
                    controller: controller.salePriceController,
                    validator: controller.typeValue != Product.live.type
                        ? (value) => MyValidator.validate(
                              value,
                              type: ValidatorType.price,
                              fieldName: 'The sale price',
                            )
                        : null,
                    enabled: controller.typeValue != Product.live.type
                        ? true
                        : false,
                    label: 'Sale Price',
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 16.0),
                  // Min
                  controller.typeValue != Product.live.type
                      ? CustomTextField(
                          controller: controller.minController,
                          validator: (value) => MyValidator.validate(
                            value,
                            type: ValidatorType.count,
                            fieldName: 'The min',
                          ),
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
                          validator: (value) => MyValidator.validate(
                            value,
                            type: ValidatorType.count,
                            fieldName: 'The max',
                          ),
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
                    items: const ['Internal', 'External'],
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

                  // Pick and Display Images
                  CustomImagePicker(
                    images: controller.selectedImages,
                    onAddImage: controller.pickImages,
                    onRemoveImage: controller.removeImage,
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
                        title:
                            controller.loading == true ? 'Loading...' : 'Save',
                        onPressed: controller.createProuct,
                      ),
                    ],
                  ),
                ],
              ),
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
