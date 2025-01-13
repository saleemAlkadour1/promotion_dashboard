import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_type/store/store_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/data/model/home/products/products_type/store/product_store_model.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(StoreControllerImp());
    return GetBuilder<StoreControllerImp>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.color_F7F9FA,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            'Store',
            style: MyText.appStyle.fs16.wBold.reColorText.style,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: controller.loading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListView.builder(
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          final product = ProductStoreModel.fromJson(controller.products[index]);
                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...List.generate(
                                      product.values.length,
                                      (index) => Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('label: ${product.values[index].label}'),
                                              Text('value: ${product.values[index].value}'),
                                            ],
                                          ))
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () async {
                                      await controller.showUpdateProductDialog(product.id);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      await controller.deleteProduct(product.id);
                                      controller.getStoreItems();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          title: 'Add product',
                          height: 40,
                          onPressed: () {
                            controller.showCreateProductDialog();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
