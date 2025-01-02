import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/size_config.dart';
import 'package:promotion_dashboard/widgets/adaptive_layout.dart';
import 'package:promotion_dashboard/widgets/custom_dawer.dart';
import 'package:promotion_dashboard/widgets/dashboard_desktop_layout.dart';
import 'package:promotion_dashboard/widgets/dashboard_mobile_layout.dart';
import 'package:promotion_dashboard/widgets/dashboard_tablet_layout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MediaQuery.sizeOf(context).width < SizeConfig.tablet
          ? AppBar(
              backgroundColor: AppColors.color_F7F9FA,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
            )
          : null,
      drawer: MediaQuery.sizeOf(context).width < SizeConfig.tablet
          ? const CustomDawer()
          : null,
      backgroundColor: AppColors.color_F7F9FA,
      body: AdaptiveLayout(
        mobileLayout: (context) => const DashboardMobileLayout(),
        tabletLayout: (context) => const DashboardTabletLayout(),
        destopLayout: (context) => const DashboardDesktopLayout(),
      ),
    );
  }
}
