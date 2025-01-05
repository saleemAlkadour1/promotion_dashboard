// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/products/products_controller.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';
import 'package:promotion_dashboard/view/widgets/products/sf_data_grid_products.dart';

class ProductsDesktopLayout extends StatelessWidget {
  const ProductsDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductsControllerImp());
    return GetBuilder<ProductsControllerImp>(builder: (controller) {
      return Row(
        children: [
          const SizedBox(
            width: 32,
          ),
          Expanded(
            flex: 6,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        'Products',
                        style: MyText.appStyle.fs24.wBold.reColorText
                            .style(context),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                                title: 'Add product',
                                height: 45,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ProductDialog(),
                                  );
                                  // Get.to(AddProduct());
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        height: 500,
                        child: SFDataGridProducts(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 32,
          ),
        ],
      );
    });
  }
}

class ProductDialog extends StatefulWidget {
  @override
  _ProductDialogState createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  // Dropdown values
  String visibleValue = 'Yes';
  String typeValue = 'Live';
  String sourceValue = 'Internal';

  // Image picker
  File? _selectedImage;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // يسمح باختيار الصور فقط
    );

    if (result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double dialogWidth = MediaQuery.of(context).size.width * 0.8;
          double dialogHeight = MediaQuery.of(context).size.height * 0.9;

          return Container(
            width: dialogWidth,
            height: dialogHeight,
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Product',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),

                    // Name
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Description
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16.0),

                    // Visible
                    DropdownButtonFormField<String>(
                      value: visibleValue,
                      items: ['Yes', 'No']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          visibleValue = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Visible',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Type
                    DropdownButtonFormField<String>(
                      value: typeValue,
                      items: ['Live', 'Store']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          typeValue = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Image Selection Area
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: _selectedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Tap to pick an image",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Purchase Price
                    TextField(
                      controller: purchasePriceController,
                      decoration: InputDecoration(
                        labelText: 'Purchase Price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.0),

                    // Sale Price
                    TextField(
                      controller: salePriceController,
                      decoration: InputDecoration(
                        labelText: 'Sale Price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.0),

                    // Source
                    DropdownButtonFormField<String>(
                      value: sourceValue,
                      items: ['Internal', 'External']
                          .map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          sourceValue = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Source',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),

                    // Min
                    TextField(
                      controller: minController,
                      decoration: InputDecoration(
                        labelText: 'Min',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.0),

                    // Max
                    TextField(
                      controller: maxController,
                      decoration: InputDecoration(
                        labelText: 'Max',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.0),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Handle form submission
                              print('Form Submitted');
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
