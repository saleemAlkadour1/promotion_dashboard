import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class CategoriesData {
  ApiService apiService = Get.find();
  Future<ApiResponse> getCategories() async {
    var response = await apiService.get(EndPoints.store.categoriesData);
    return response;
  }

  Future<ApiResponse> createCategory(dynamic data) async {
    var response =
        await apiService.post(EndPoints.store.createCategory, data: data);
    return response;
  }

  Future<ApiResponse> deleteCategory(int id) async {
    var response = await apiService
        .delete(EndPoints.store.deleteCategory, pathVariables: {'id': id});
    return response;
  }
}
