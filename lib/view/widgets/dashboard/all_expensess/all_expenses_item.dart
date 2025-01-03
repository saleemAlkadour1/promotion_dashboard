// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/data/model/all_expensess_item_model.dart';
import 'package:promotion_dashboard/view/widgets/dashboard/all_expensess/inactive_and_active_all_expansess_item.dart';

class AllExpensesItem extends StatelessWidget {
  const AllExpensesItem({
    super.key,
    required this.itemModel,
    required this.isSelected,
  });
  final bool isSelected;

  final AllExpensessItemModel itemModel;
  @override
  Widget build(BuildContext context) {
    return isSelected
        ? ActiveAllExpansessItem(itemModel: itemModel)
        : InActiveAllExpansessItem(itemModel: itemModel);
  }
}
