import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/home/transactions/transaction_model.dart';

class TransactionDetailsDialog extends StatelessWidget {
  const TransactionDetailsDialog({
    super.key,
    required this.transactionModel,
  });
  final TransactionModel transactionModel;

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
                  'Transaction Details',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabelValueRow('Transaction ID',
                        transactionModel.id.toString(), context),
                    _buildLabelValueRow(
                        'Amount',
                        '${transactionModel.amount} ${transactionModel.currency}',
                        context),
                    _buildLabelValueRow('Type', transactionModel.type, context),
                    _buildLabelValueRow('Category ID',
                        transactionModel.categoryId.toString(), context),
                    _buildLabelValueRow(
                        'User ID', transactionModel.userId.toString(), context),
                    _buildLabelValueRow(
                        'Description', transactionModel.description, context),
                    const SizedBox(height: 12),

                    // Dates
                    _buildLabelValueRow(
                      'Created At',
                      transactionModel.createdAt.toIso8601String(),
                      context,
                    ),
                    _buildLabelValueRow(
                      'Updated At',
                      transactionModel.updatedAt.toIso8601String(),
                      context,
                    ),
                    const SizedBox(height: 12),

                    // User Info
                    const Text(
                      'User Info:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildLabelValueRow(
                      'Name',
                      transactionModel.user.firstName,
                      context,
                    ),
                    _buildLabelValueRow(
                        'Email', transactionModel.user.email, context),
                    _buildLabelValueRow(
                        'Wallet Balance',
                        transactionModel.user.walletBalance.toString(),
                        context),
                    _buildLabelValueRow(
                      'Role',
                      transactionModel.user.role,
                      context,
                    ),
                    _buildLabelValueRow(
                      'Phone',
                      transactionModel.user.phone,
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
  Widget _buildLabelValueRow(
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
