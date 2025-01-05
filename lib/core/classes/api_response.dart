import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/core/constants/storage_keys.dart';
import 'package:promotion_dashboard/core/functions/print.dart';

class ApiResponse {
  final bool success;
  final int? statusCode;
  final String? url;
  final dynamic data;
  final Map<String, dynamic>? params;
  final dynamic body;
  final String? message;
  final dynamic response;

  ApiResponse({
    required this.success,
    this.statusCode,
    this.url,
    this.params,
    this.body,
    this.data,
    this.message,
    this.response,
  });

  factory ApiResponse.fromResponse(dynamic response) {
    return ApiResponse(
      success: response.data['success'] == true,
      statusCode: response.statusCode,
      url: response.requestOptions.uri.toString(),
      body: response.data,
      data: response.statusCode == 422
          ? response.data['errors']
          : response.data['data'],
      params: response.requestOptions.queryParameters,
      message: response.data.containsKey('message')
          ? response.data['message']
              .toString()
              .replaceAll('(and 1 more error)', '')
          : null,
      response: response.data,
    );
  }

  bool get isSuccess => success && statusCode != null && statusCode! < 400;

  @override
  String toString() {
    if (kDebugMode) {
      printDebug("=========== Inputes ===========");
      printDebug("Url: $url");
      printDebug("params: ${params ?? {}}");
      printDebug("body: ${body ?? {}}");
      printDebug("=========== Outputs ===========");
      printDebug("success: $success");
      printDebug("Status Code: $statusCode");
      printDebug("data: $data");
      printDebug("message: $message");
    }

    int step = Shared.getValue(StorageKeys.step);
    if (step == 2 && statusCode == 401) {
      Shared.clear();
      Shared.setValue(StorageKeys.step, 1);
      Get.offAndToNamed(AppRoutes.login);
    }

    String dataAsString =
        'ApiResponse(success: $success, statusCode: $statusCode, url: $url, params: $params, body: $body, message: $message, data: $data)';
    return dataAsString;
  }
}
