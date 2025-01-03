// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_background_container.dart';
import 'package:promotion_dashboard/view/widgets/dashboard/quick_invoice/latest_transaction.dart';
import 'package:promotion_dashboard/view/widgets/dashboard/quick_invoice/quick_invoice_form.dart';
import 'package:promotion_dashboard/view/widgets/dashboard/quick_invoice/quick_invoice_header.dart';

class QuickInvoice extends StatelessWidget {
  const QuickInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundContainer(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuickInvoiceHeader(),
          SizedBox(
            height: 36,
          ),
          LatestTransaction(),
          Divider(
            color: AppColors.color_F1F1F1,
            height: 48,
          ),
          QuickInvoiceForm(),
        ],
      ),
    );
  }
}
