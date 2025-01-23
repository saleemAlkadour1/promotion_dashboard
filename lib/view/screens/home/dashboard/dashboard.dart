import 'package:flutter/material.dart';
import 'package:promotion_dashboard/view/widgets/general/adaptive_layout.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/dashboard_layouts/dashboard_desktop_layout.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/dashboard_layouts/dashboard_mobile_layout.dart';
import 'package:promotion_dashboard/view/widgets/home/dashboard/dashboard_layouts/dashboard_tablet_layout.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) => const DashboardMobileLayout(),
      tabletLayout: (context) => const DashboardTabletLayout(),
      destopLayout: (context) => const DashboardDesktopLayout(),
    );
  }
}
