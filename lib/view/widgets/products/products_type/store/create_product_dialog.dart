import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_type/store/store_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class CreateProductDialog extends StatelessWidget {
  const CreateProductDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreControllerImp>(builder: (controller) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create prouct',
                  style: MyText.appStyle.fs16.wBold
                      .reCustomColor(Colors.black)
                      .style,
                ),
                const SizedBox(height: 16.0),
                Column(
                  children: List.generate(controller.values.length, (index) {
                    final item = controller.values[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text("Label: ${item['label']}"),
                        subtitle: Text("Value: ${item['value']}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.deleteDynamicValue(index),
                        ),
                      ),
                    );
                  }),
                ),
                controller.values.isNotEmpty
                    ? const Divider()
                    : const SizedBox(),
                CustomTextField(
                  label: 'Label',
                  controller: controller.labelController,
                ),
                const SizedBox(height: 8.0),
                CustomTextField(
                  label: 'Value',
                  controller: controller.valueController,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () {
                    controller.addDynamicValue();
                  },
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                  label: Text(
                    'Add item',
                    style: MyText.appStyle.fs14.wMedium.reColorWhite.style,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.color_4EB7F2,
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                        title: 'Cancel',
                        height: 40,
                        backgroundColor: AppColors.white,
                        textColor: AppColors.color_45AFEA,
                        onPressed: () {
                          Get.back();
                        }),
                    const SizedBox(
                      width: 20,
                    ),
                    CustomButton(
                      title: 'Create prouct',
                      height: 40,
                      onPressed: controller.createProduct,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
