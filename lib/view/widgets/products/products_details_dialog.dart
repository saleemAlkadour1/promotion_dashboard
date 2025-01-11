import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'package:promotion_dashboard/data/model/home/product_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsDialog extends StatelessWidget {
  const ProductDetailsDialog({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Dialog(
      backgroundColor: AppColors.screenColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product',
                  style: MyText.appStyle.fs18.wBold.reColorText
                      .responsiveStyle(context),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child:
                        const Icon(Icons.close, size: 24, color: Colors.black),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Close Button

                    // Name Section
                    Text(
                      'Name:',
                      style: MyText.appStyle.fs18.wBold.reColorText
                          .responsiveStyle(context),
                    ),
                    const SizedBox(height: 8),

                    ...List.generate(myLanguages.entries.toList().length,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _buildLabelValueRow(
                            '${(myLanguages.entries.toList()[index].value['name']).toString().capitalizeFirst}',
                            productModel.name.toJson()[
                                    myLanguages.entries.toList()[index].key] ??
                                'No name',
                            context),
                      );
                    }),
                    const SizedBox(height: 12),

                    // Description Section
                    Text(
                      'Description:',
                      style: MyText.appStyle.fs18.wBold.reColorText
                          .responsiveStyle(context),
                    ),
                    const SizedBox(height: 8),

                    ...List.generate(myLanguages.entries.toList().length,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _buildLabelValueRow(
                            '${(myLanguages.entries.toList()[index].value['name']).toString().capitalizeFirst}',
                            productModel.description.toJson()[
                                    myLanguages.entries.toList()[index].key] ??
                                'No description',
                            context),
                      );
                    }),
                    const SizedBox(height: 12),

                    // Available
                    _buildLabelValueRow(
                      'Available',
                      productModel.available == true ? 'Yes' : 'No',
                      context,
                    ),
                    const SizedBox(height: 12),

                    // Visible
                    _buildLabelValueRow(
                      'Visible',
                      productModel.visible == true ? 'Yes' : 'No',
                      context,
                    ),
                    _buildLabelValueRow('Category id',
                        productModel.productCategoryId.toString(), context),
                    const SizedBox(height: 12),
                    _buildLabelValueRow('Type', productModel.type, context),
                    const SizedBox(height: 12),
                    _buildLabelValueRow('Purchase price',
                        productModel.purchasePrice.toString(), context),
                    const SizedBox(height: 12),
                    _buildLabelValueRow('Sale price',
                        productModel.salePrice.toString(), context),
                    const SizedBox(height: 12),
                    _buildLabelValueRow('Numberly',
                        productModel.numberly ? 'Yes' : 'No', context),
                    const SizedBox(height: 12),
                    _buildLabelValueRow('Source', productModel.source, context),
                    const SizedBox(height: 12),
                    _buildLabelValueRow(
                        'Min', productModel.min ?? '0', context),
                    const SizedBox(height: 12),
                    _buildLabelValueRow(
                        'Max', productModel.max ?? '0', context),

                    const SizedBox(height: 16),

                    // Image Section
                    Text(
                      'Image:',
                      style: MyText.appStyle.fs18.wBold.reColorText
                          .responsiveStyle(context),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: PageView.builder(
                            controller: pageController,
                            itemCount: productModel.images.length,
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: productModel.images[index].path,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // SmoothPageIndicator
                    Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: productModel.images.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.blue,
                          dotColor: Colors.grey,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Method for Label-Value Rows
  Widget _buildLabelValueRow(
    String label,
    String value,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label:',
            textAlign: TextAlign.start,
            style: MyText.appStyle.fs14.wMedium
                .reCustomColor(Colors.grey)
                .responsiveStyle(context)),
        const Spacer(),
        Expanded(
          child: Text(value,
              textAlign: TextAlign.end,
              style: MyText.appStyle.fs14.wMedium
                  .reCustomColor(Colors.black)
                  .responsiveStyle(context)),
        ),
      ],
    );
  }
}
