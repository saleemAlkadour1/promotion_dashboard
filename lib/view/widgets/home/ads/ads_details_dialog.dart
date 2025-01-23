import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/functions/error_image.dart';
import 'package:promotion_dashboard/core/functions/format_date.dart';
import 'package:promotion_dashboard/data/model/home/ads/ad_model.dart';

class AdDetailsDialog extends StatelessWidget {
  const AdDetailsDialog({
    super.key,
    required this.adModel,
  });

  final AdModel adModel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
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
                const Text(
                  'Ad Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
            const Divider(color: Colors.grey),
            const SizedBox(height: 8),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabelValueRow('ID', adModel.id.toString(), context),
                    buildLabelValueRow('Start Date',
                        formatDate(adModel.startDate.toString()), context),
                    buildLabelValueRow('End Date',
                        formatDate(adModel.endDate.toString()), context),
                    buildLabelValueRow(
                        'Is Active', adModel.isActive ? 'Yes' : 'No', context),
                    buildLabelValueRow('Created At',
                        formatDate(adModel.createdAt.toString()), context),
                    buildLabelValueRow('Updated At',
                        formatDate(adModel.updatedAt.toString()), context),
                    buildLabelValueRow(
                        'Link URL', adModel.linkUrl ?? 'No link url', context),
                    const SizedBox(height: 12),
                    Text(
                      'Image:',
                      style: MyText.appStyle.fs18.wBold.reColorText
                          .responsiveStyle(context),
                    ),
                    const SizedBox(height: 12),

                    // Image Section
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: adModel.image,
                        width: double.infinity,
                        height: 200, // Adjust the height based on design
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.color_4EB7F2,
                            ),
                          ),
                        ),
                        errorWidget: myErrorWidget,
                      ),
                    ),
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
  Widget buildLabelValueRow(
    String label,
    String value,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

// Helper Method for Label-Value Rows
Widget buildLabelValueRow(
  String label,
  String value,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ),
  );
}
