import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/core/classes/internet_connectivity_service.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetConnectivityService());
    Get.put(
      ApiService(
        baseUrl: EndPoints.baseApi,
        connectivityService: Get.find(),
        defaultHeaders: {
          'Accept': 'application/json',
        },
      ),
    );
  }
}
