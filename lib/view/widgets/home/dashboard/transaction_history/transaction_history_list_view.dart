import 'package:flutter/material.dart';
import 'package:promotion_dashboard/data/model/general/transaction_model.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/transaction_history/transaction_item.dart';

class TransactionHistoryListView extends StatelessWidget {
  const TransactionHistoryListView({super.key});
  static List<Transaction> items = [
    Transaction(
        title: 'Cash Withdrawal',
        date: '13 Apr, 2022 ',
        amount: '20,129',
        isWithdrawal: true),
    Transaction(
        title: 'Landing Page project',
        date: '13 Apr, 2022 at 3:30 PM',
        amount: '2,000',
        isWithdrawal: false),
    Transaction(
        title: 'Juni Mobile App project',
        date: '13 Apr, 2022 at 3:30 PM',
        amount: '20,129',
        isWithdrawal: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((e) => TransactionItem(transactionModel: e)).toList(),
    );
  }
}
