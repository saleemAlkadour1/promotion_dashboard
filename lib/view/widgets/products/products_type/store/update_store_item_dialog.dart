import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_type/store/store_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_text_field.dart';

class UpdateStoreItemDialog extends StatelessWidget {
  const UpdateStoreItemDialog({super.key});

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
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.values.length,
                  itemBuilder: (context, index) {
                    final item = controller.values[index];
                    final isDeleted = item['delete'] == 1;
                    final isEditing = controller.updateIndex == index;
                    final isAdding = controller.addingNewValue &&
                        index == controller.values.length - 1;

                    return Card(
                      color: isDeleted
                          ? AppColors.red
                          : AppColors.white.withOpacity(0.9),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: isEditing || isAdding
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    label: 'Label',
                                    controller:
                                        controller.updateLabelController,
                                  ),
                                  const SizedBox(height: 8.0),
                                  CustomTextField(
                                    label: 'Value',
                                    controller:
                                        controller.updateValueController,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: controller.cancelUpdate,
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: AppColors.red,
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        IconButton(
                                          onPressed: () {
                                            if (isAdding) {
                                              controller.saveNewValue();
                                            } else {
                                              controller
                                                  .saveUpdatedValue(index);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.done_outline,
                                            color: AppColors.color_4EB7F2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListTile(
                              title: Text(
                                "Label: ${item['label']}",
                                style: TextStyle(
                                  decorationThickness: 2,
                                  decoration: isDeleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color:
                                      isDeleted ? Colors.white : Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                "Value: ${item['value']}",
                                style: TextStyle(
                                  decorationThickness: 2,
                                  decoration: isDeleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color:
                                      isDeleted ? Colors.white : Colors.black,
                                ),
                              ),
                              trailing: !isDeleted
                                  ? Row(
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
                                              .deleteUpdateDynamicValue(index),
                                        ),
                                      ],
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        controller.values[index]
                                            .remove('delete');
                                        controller.update();
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.undo,
                                        color: AppColors.white,
                                      )),
                            ),
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: controller.startAddingNewValue,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.color_4EB7F2, elevation: 0),
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                  label: const Text(
                    "Add new item",
                    style: TextStyle(color: AppColors.white),
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
                      },
                    ),
                    const SizedBox(width: 20),
                    CustomButton(
                      title: 'Update item',
                      height: 40,
                      onPressed: controller.updateProduct,
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
