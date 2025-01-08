import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class ProductData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get() async {
    var response = await apiService.get(
      EndPoints.store.products,
      params: {},
    );
    return response;
  }
}
