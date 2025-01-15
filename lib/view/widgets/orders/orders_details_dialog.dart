import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/data/model/home/orders/order_model.dart';

class OrderDetailsDialog extends StatelessWidget {
  const OrderDetailsDialog({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: isMobile ? double.infinity : 600,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with close button
              _buildHeader(context),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),

              // Order Details
              _buildSectionTitle("Order Info", Icons.shopping_cart),
              _buildDetailRow("Order ID", orderModel.id.toString()),
              _buildDetailRow("Description", orderModel.description),
              _buildDetailRow("Purchase Price", orderModel.purchasePrice),
              _buildDetailRow("Sale Price", orderModel.salePrice),
              _buildDetailRow("Status", orderModel.status),
              _buildDetailRow("Created At", orderModel.createdAt),
              const SizedBox(height: 16),

              // Product Details
              _buildSectionTitle(
                  "Product Info", Icons.production_quantity_limits),
              _buildDetailRow("Product Name", orderModel.product.type),
              _buildDetailRow(
                  "Product Purchase Price", orderModel.product.purchasePrice),
              _buildDetailRow("Category", orderModel.product.category.nameEn),
              const SizedBox(height: 16),

              // User Details
              _buildSectionTitle("User Info", Icons.person),
              _buildDetailRow("User Name", orderModel.user.firstName),
              _buildDetailRow("Email", orderModel.user.email),
              _buildDetailRow("Phone", orderModel.user.phone),
              _buildDetailRow(
                  "Wallet Balance", orderModel.user.walletBalance.toString()),
              const SizedBox(height: 16),

              // Metadata Details
              if (orderModel.metadata != null &&
                  orderModel.metadata is Map) ...[
                _buildSectionTitle("Additional Info", Icons.info),
                _buildDetailRow(
                  "Server Name",
                  orderModel.metadata['server_name'] is String
                      ? orderModel.metadata['server_name']
                      : 'N/A',
                ),
                if (orderModel.metadata['data'] != null &&
                    orderModel.metadata['data'] is Map) ...[
                  _buildDetailRow(
                    "Country",
                    orderModel.metadata['data']['country'] is String
                        ? orderModel.metadata['data']['country']
                        : 'N/A',
                  ),
                  _buildDetailRow(
                    "Product",
                    orderModel.metadata['data']['product'] is String
                        ? orderModel.metadata['data']['product']
                        : 'N/A',
                  ),
                  _buildDetailRow(
                    "Operator",
                    orderModel.metadata['data']['operator'] is String
                        ? orderModel.metadata['data']['operator']
                        : 'N/A',
                  ),
                ] else
                  const SizedBox(),
              ] else
                const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Order Details",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.color_064061,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.color_064061),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
