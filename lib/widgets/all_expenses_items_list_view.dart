import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/data/model/all_expensess_item_model.dart';
import 'package:promotion_dashboard/widgets/all_expenses_item.dart';

class AllExpensesItemsListView extends StatefulWidget {
  const AllExpensesItemsListView({super.key});

  @override
  State<AllExpensesItemsListView> createState() =>
      _AllExpensesItemsListViewState();
}

class _AllExpensesItemsListViewState extends State<AllExpensesItemsListView> {
  final List<AllExpensessItemModel> items = const [
    AllExpensessItemModel(
      imagePath: Assets.imagesSvgBalance,
      title: 'Balance',
      date: 'April 2022',
      price: r'$20,129',
    ),
    AllExpensessItemModel(
      imagePath: Assets.imagesSvgIncome,
      title: 'Income',
      date: 'April 2022',
      price: r'$20,129',
    ),
    AllExpensessItemModel(
      imagePath: Assets.imagesSvgExpenses,
      title: 'Expenses',
      date: 'April 2022',
      price: r'$20,129',
    ),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      // children: items
      //     .map((e) => Expanded(child: AllExpensessItem(itemModel: e)))
      //     .toList(),
      children: items.asMap().entries.map((e) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (selectedIndex != e.key) {
                selectedIndex = e.key;
                setState(() {});
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: e.key == 1 ? 12 : 0),
              child: AllExpensesItem(
                itemModel: e.value,
                isSelected: selectedIndex == e.key,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
