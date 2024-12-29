// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/widgets/all_expenses_header.dart';
import 'package:promotion_dashboard/widgets/all_expenses_items_list_view.dart';
import 'package:promotion_dashboard/widgets/custom_background_container.dart';

class AllExpenses extends StatelessWidget {
  const AllExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundContainer(
      child: Column(
        children: [
          AllExpensesHeader(),
          SizedBox(
            height: 16,
          ),
          AllExpensesItemsListView()
        ],
      ),
    );
  }
}
