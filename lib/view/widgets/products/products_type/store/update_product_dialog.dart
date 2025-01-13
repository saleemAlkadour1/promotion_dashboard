import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_type/store/store_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class UpdateProductDialog extends StatelessWidget {
  const UpdateProductDialog({super.key});

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
                  'Edit Product',
                  style: MyText.appStyle.fs16.wBold
                      .reCustomColor(Colors.black)
                      .style,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: controller.startAddingNewValue,
                  icon: const Icon(Icons.add),
                  label: const Text("Add New Value"),
                ),
                const SizedBox(height: 16.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.values.length,
                  itemBuilder: (context, index) {
                    final item = controller.values[index];
                    final isEditing = controller.editingIndex == index;
                    final isAdding = controller.addingNewValue &&
                        index == controller.values.length - 1;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: isEditing || isAdding
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    label: 'Label',
                                    controller: controller.editLabelController,
                                  ),
                                  const SizedBox(height: 8.0),
                                  CustomTextField(
                                    label: 'Value',
                                    controller: controller.editValueController,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (isAdding) {
                                            controller.saveNewValue();
                                          } else {
                                            controller.saveEditedValue(index);
                                          }
                                        },
                                        child: const Text('Save'),
                                      ),
                                      const SizedBox(width: 8.0),
                                      ElevatedButton(
                                        onPressed: controller.cancelEdit,
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : ListTile(
                              title: Text("Label: ${item['label']}"),
                              subtitle: Text("Value: ${item['value']}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () =>
                                        controller.startEdit(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => controller
                                        .deleteDeleteDynamicValue(index),
                                  ),
                                ],
                              ),
                            ),
                    );
                  },
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
                      },
                    ),
                    const SizedBox(width: 20),
                    CustomButton(
                      title: 'Save Changes',
                      height: 40,
                      onPressed: controller.saveChanges,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
