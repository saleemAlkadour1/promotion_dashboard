import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class OrdersData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get() async {
    var response = await apiService.get(
      EndPoints.order.orders,
      params: {},
    );
    return response;
  }

  Future<ApiResponse> getOrder(int id) async {
    var response = await apiService.get(
      EndPoints.order.order,
      pathVariables: {'id': id},
      params: {},
    );
    return response;
  }
}
