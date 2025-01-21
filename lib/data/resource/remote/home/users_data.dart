import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class UsersData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get({required int pageIndex}) async {
    var response = await apiService.get(
      EndPoints.user.users,
      params: {'page': pageIndex},
    );
    return response;
  }

  Future<ApiResponse> getUser(int id) async {
    var response = await apiService.get(
      EndPoints.user.user,
      pathVariables: {
        'id': id,
      },
      params: {},
    );
    return response;
  }

  Future<ApiResponse> getMyProfile() async {
    var response = await apiService.get(
      EndPoints.user.myProfile,
      params: {},
    );
    return response;
  }
}
