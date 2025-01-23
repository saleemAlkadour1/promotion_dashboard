import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/functions/error_image.dart';
import 'package:promotion_dashboard/data/model/home/contacts/contact_model.dart';

class AdDetailsDialog extends StatelessWidget {
  const AdDetailsDialog({
    super.key,
    required this.contactModel,
  });

  final ContactModel contactModel;

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
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Contact Details',
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

            // Details
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: CachedNetworkImage(
                        imageUrl: contactModel.icon,
                        width: 50,
                        height: 50, // Square shape
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.color_4EB7F2,
                          ),
                        ),
                        errorWidget: myErrorWidget,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    buildLabelValueRow(
                        'ID', contactModel.id.toString(), context),
                    buildLabelValueRow(
                        'Name (EN)', contactModel.name.en, context),
                    buildLabelValueRow(
                        'Name (AR)', contactModel.name.ar, context),
                    buildLabelValueRow('URL', contactModel.url, context),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Color: ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Color(int.tryParse(contactModel.color)!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildLabelValueRow(
                      'Created At',
                      contactModel.createdAt.toIso8601String(),
                      context,
                    ),
                    buildLabelValueRow(
                      'Updated At',
                      contactModel.updatedAt.toIso8601String(),
                      context,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
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
