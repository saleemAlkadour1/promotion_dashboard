import 'dart:io';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class ContactsData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get({required int indexPage}) async {
    var response = await apiService.get(
      EndPoints.contact.contacts,
      params: {
        'page': indexPage,
      },
    );
    return response;
  }

  Future<ApiResponse> show(int id) async {
    var response = await apiService.get(
      EndPoints.contact.contact,
      pathVariables: {
        'id': id,
      },
      params: {},
    );
    return response;
  }

  Future<ApiResponse> create(
    Map name,
    String url,
    File icon,
    String color,
  ) async {
    var response = await apiService.post(
      EndPoints.contact.contacts,
      data: {
        'name': name,
        'url': url,
        'color': color,
      },
      files: {
        'icon': icon,
      },
    );
    return response;
  }

  Future<ApiResponse> update(
    int id,
    Map? name,
    String? url,
    File? icon,
    String? color,
  ) async {
    var response = await apiService.post(
      EndPoints.contact.contact,
      pathVariables: {
        'id': id,
      },
      data: {
        'name': name,
        'url': url,
        'color': color,
      },
      files: icon != null
          ? {
              'icon': icon,
            }
          : null,
    );
    return response;
  }

  Future<ApiResponse> delete(int id) async {
    var response = await apiService.delete(
      EndPoints.contact.contact,
      pathVariables: {'id': id},
    );
    return response;
  }
}
