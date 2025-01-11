import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/bindings/initialbindings.dart';
import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
import 'package:promotion_dashboard/core/constants/storage_keys.dart';
import 'package:promotion_dashboard/core/services/services.dart';
import 'package:promotion_dashboard/routes/getx_route.dart';
import 'package:promotion_dashboard/view/screens/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyServices.initialServices();
  Shared.setValue(StorageKeys.accessToken,
      '39|Kr3ZNxwGvGu2EEoNjTICbSmZhYPj9J9Cr8MhpdcQab5a72de');
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
