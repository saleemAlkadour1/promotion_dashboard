// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/dashboard_layouts/dashboard_mobile_layout.dart';

class DashboardTabletLayout extends StatelessWidget {
  const DashboardTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 32,
        ),
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: DashboardMobileLayout(),
            )),
        SizedBox(
          width: 32,
        ),
      ],
    );
  }
}
