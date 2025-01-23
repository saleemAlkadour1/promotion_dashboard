import 'dart:io';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class AdsData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get({required int indexPage}) async {
    var response = await apiService.get(
      EndPoints.ad.ads,
      params: {
        'page': indexPage,
      },
    );
    return response;
  }

  Future<ApiResponse> show(int id) async {
    var response = await apiService.get(
      EndPoints.ad.ad,
      pathVariables: {
        'id': id,
      },
      params: {},
    );
    return response;
  }

  Future<ApiResponse> create(
    File image,
    String startDate,
    String endDate,
    bool isActive,
    String? linkUrl,
  ) async {
    var response = await apiService.post(
      EndPoints.ad.ads,
      data: {
        'start_date': startDate,
        'end_date': startDate,
        'is_active': isActive ? 1 : 0,
        'link_url': linkUrl
      },
      files: {
        'image': image,
      },
    );
    return response;
  }

  Future<ApiResponse> update(
    int id,
    File? image,
    String startDate,
    String endDate,
    bool isActive,
    String? linkUrl,
  ) async {
    var response = await apiService.post(
      EndPoints.ad.ad,
      pathVariables: {
        'id': id,
      },
      data: {
        'start_date': startDate,
        'end_date': startDate,
        'is_active': isActive ? 1 : 0,
        'link_url': linkUrl
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
      EndPoints.ad.ad,
      pathVariables: {
        'id': id,
      },
    );
    return response;
  }
}
