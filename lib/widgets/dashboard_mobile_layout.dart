import 'package:flutter/material.dart';
import 'package:promotion_dashboard/widgets/all_expensess_and_quickInvoice_section.dart';
import 'package:promotion_dashboard/widgets/income_section.dart';
import 'package:promotion_dashboard/widgets/my_cards_and_transaction_history_section.dart';

class DashboardMobileLayout extends StatelessWidget {
  const DashboardMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          AllExpensessAndQuickInvoiceSection(),
          SizedBox(
            height: 24,
          ),
          MyCardsAndTransactionHistorySection(),
          SizedBox(
            height: 24,
          ),
          IncomeSection(),
        ],
      ),
    );
  }
}
