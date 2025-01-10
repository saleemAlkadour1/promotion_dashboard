import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/functions/error_image.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';

class CategoryDetailsDialog extends StatelessWidget {
  final Map name;
  final Map description;
  final String available;
  final String visible;
  final String imageUrl;

  const CategoryDetailsDialog({
    super.key,
    required this.name,
    required this.description,
    required this.available,
    required this.visible,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.screenColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          // إضافة التمرير عند الحاجة
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: MyText.appStyle.fs18.wBold.reColorText
                        .responsiveStyle(context),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close,
                          size: 24, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(height: 16),

              // Name Section
              Text(
                'Name:',
                style: MyText.appStyle.fs18.wBold.reColorText
                    .responsiveStyle(context),
              ),
              const SizedBox(height: 8),

              ...List.generate(myLanguages.entries.toList().length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildLabelValueRow(
                      '${(myLanguages.entries.toList()[index].value['name']).toString().capitalizeFirst}',
                      name[myLanguages.entries.toList()[index].key],
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

              ...List.generate(myLanguages.entries.toList().length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildLabelValueRow(
                      '${(myLanguages.entries.toList()[index].value['name']).toString().capitalizeFirst}',
                      description[myLanguages.entries.toList()[index].key],
                      context),
                );
              }),
              const SizedBox(height: 12),

              // Available
              _buildLabelValueRow(
                'Available',
                available,
                context,
              ),
              const SizedBox(height: 12),

              // Visible
              _buildLabelValueRow(
                'Visible',
                visible,
                context,
              ),
              const SizedBox(height: 16),

              // Image Section
              Text(
                'Image:',
                style: MyText.appStyle.fs18.wBold.reColorText
                    .responsiveStyle(context),
              ),
              const SizedBox(height: 12),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: myErrorWidget,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
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
