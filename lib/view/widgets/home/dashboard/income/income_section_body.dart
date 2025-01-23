// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/size_config.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/income/detailed_income_chart.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/income/income_chart.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/income/income_details.dart';

class IncomeSectionBody extends StatelessWidget {
  const IncomeSectionBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return width >= SizeConfig.desktop && width < 1660
        ? Expanded(
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DetailedIncomeChart(),
          ))
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: IncomeChart()),
              Expanded(flex: 2, child: IncomeDetails()),
            ],
          );
  }
}
