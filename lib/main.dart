// ignore_for_file: prefer_const_constructors

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/view/screens/dashboard.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const PromotionDashboard(),
    ),
  );
}

class PromotionDashboard extends StatelessWidget {
  const PromotionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: Dashboard(),
    );
  }
}
