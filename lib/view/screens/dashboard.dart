import 'package:flutter/material.dart';
import 'package:promotion_dashboard/widgets/adaptive_layout.dart';
import 'package:promotion_dashboard/widgets/dashboard_desktop_layout.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (context) => const SizedBox(),
        tabletLayout: (context) => const SizedBox(),
        destopLayout: (context) => const DashboardDesktopLayout(),
      ),
    );
  }
}
