import 'package:flutter/material.dart';
import 'package:promotion_dashboard/widgets/custom_dawer.dart';

class DashboardDesktopLayout extends StatelessWidget {
  const DashboardDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CustomDawer(),
        ),
        // Expanded(
        //   flex: 3,
        //   child: Container(),
        // ),
        // Expanded(
        //   flex: 1,
        //   child: Container(),
        // ),
      ],
    );
  }
}
