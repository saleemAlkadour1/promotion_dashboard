import 'dart:io';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class CategoriesData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get() async {
    var response = await apiService.get(
      EndPoints.store.categories,
      params: {},
    );
    return response;
  }

  Future<ApiResponse> show(categoryId) async {
    var response = await apiService.get(
      EndPoints.store.category,
      params: {},
      pathVariables: {
        'id': categoryId,
      },
    );
    return response;
  }

  Future<ApiResponse> create(
    Map name,
    Map description,
    String productDisplayMethod,
    bool visible,
    bool available,
    File image,
  ) async {
    var response = await apiService.post(
      EndPoints.store.categories,
      data: {
        'name': name,
        'description': description,
        'product_display_method': productDisplayMethod,
        'visible': visible ? 1 : 0,
        'available': available ? 1 : 0,
      },
      files: {
        'image': image,
      },
    );
    return response;
  }

  Future<ApiResponse> update(
    int id,
    Map name,
    Map description,
    String productDisplayMethod,
    bool visible,
    bool available,
    File? image,
  ) async {
    var response = await apiService.post(
      EndPoints.store.category,
      pathVariables: {
        'id': id,
      },
      data: {
        'name': name,
        'description': description,
        'product_display_method': productDisplayMethod,
        'visible': visible ? 1 : 0,
        'available': available ? 1 : 0,
      },
      files: image != null
          ? {
              'image': image,
            }
          : null,
    );
    return response;
  }

  Future<ApiResponse> delete(int id) async {
    var response = await apiService.delete(
      EndPoints.store.category,
      pathVariables: {'id': id},
    );
    return response;
  }
}
