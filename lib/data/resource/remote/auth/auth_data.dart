import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class AuthData {
  ApiService apiService = Get.find();

  Future<ApiResponse> login(String email, String password) async {
    var response = await apiService.post(
      EndPoints.auth.login,
      data: {'email': email, 'password': password, 'role': 'admin'},
    );

    return response;
  }

  Future<ApiResponse> logout() async {
    var response = await apiService.post(EndPoints.auth.logout);
    return response;
  }
}
