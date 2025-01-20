import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class NotificationsData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get() async {
    var response = await apiService.get(
      EndPoints.notification.notifications,
      params: {},
    );
    return response;
  }

  Future<ApiResponse> delete(int id) async {
    var response = await apiService.delete(
      EndPoints.notification.notification,
      pathVariables: {'id': id},
    );
    return response;
  }

  Future<ApiResponse> markAsRead(int id) async {
    var response = await apiService.post(
      EndPoints.notification.markAsRead,
      pathVariables: {'id': id},
    );
    return response;
  }
}
