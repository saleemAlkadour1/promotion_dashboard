//Old design
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/functions/error_image.dart';
import 'package:promotion_dashboard/data/model/home/users/user_model.dart';

class UserDetailsDialog extends StatelessWidget {
  const UserDetailsDialog({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;

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
                  'User Details',
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
            const SizedBox(height: 16),

            // User Info
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Photo
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                          border:
                              Border.all(color: Colors.blueAccent, width: 3),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            imageUrl: userModel.profilePhoto ??
                                'https://i.ibb.co/1ZDRN67/profile.jpg',
                            progressIndicatorBuilder:
                                (context, url, progress) => const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.color_4EB7F2,
                              ),
                            ),
                            errorWidget: myErrorWidget,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildLabelValueRow('Name', userModel.firstName, context),
                    buildLabelValueRow('Email', userModel.email, context),
                    buildLabelValueRow('Phone', userModel.phone, context),
                    buildLabelValueRow('Wallet Balance',
                        userModel.walletBalance.toString(), context),
                    buildLabelValueRow('Role', userModel.role, context),
                    buildLabelValueRow('Description',
                        userModel.description ?? 'No Description', context),
                    buildLabelValueRow(
                        'Approval Status',
                        userModel.approve ? 'Approved' : 'Not Approved',
                        context),
                    const SizedBox(height: 12),

                    // Dates
                    buildLabelValueRow(
                      'Code Expiry Date',
                      userModel.codeExpiryDate.toIso8601String(),
                      context,
                    ),
                    buildLabelValueRow(
                      'Created At',
                      userModel.createdAt.toIso8601String(),
                      context,
                    ),
                    buildLabelValueRow(
                      'Updated At',
                      userModel.updatedAt.toIso8601String(),
                      context,
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 3,
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
