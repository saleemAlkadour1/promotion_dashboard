import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/size_config.dart';
import 'package:promotion_dashboard/view/screens/home.dart';
import 'package:promotion_dashboard/view/screens/products.dart';
import 'package:promotion_dashboard/view/widgets/general/drawer/custom_dawer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const PromotionDashboard(),
    ),
  );
}

class PromotionDashboard extends StatelessWidget {
  const PromotionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: Home(),
    );
  }
}
