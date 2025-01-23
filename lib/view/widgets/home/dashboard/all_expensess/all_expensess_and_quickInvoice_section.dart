import 'package:flutter/material.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/all_expensess/all_expenses.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/quick_invoice/quick_invoice.dart';

class AllExpensessAndQuickInvoiceSection extends StatelessWidget {
  const AllExpensessAndQuickInvoiceSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
        AllExpenses(),
        SizedBox(
          height: 24,
        ),
        QuickInvoice(),
      ],
    );
  }
}
