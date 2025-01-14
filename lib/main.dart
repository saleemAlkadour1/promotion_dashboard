import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/bindings/initialbindings.dart';
import 'package:promotion_dashboard/core/services/services.dart';
import 'package:promotion_dashboard/routes/getx_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyServices.initialServices();

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
      initialBinding: InitialBindings(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      builder: DevicePreview.appBuilder,
      getPages: getPages,
    );
  }
}
