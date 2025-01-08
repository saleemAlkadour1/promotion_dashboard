import 'dart:io';
import 'package:dio/dio.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/shared_preferences.dart';
import 'package:promotion_dashboard/core/constants/storage_keys.dart';
import 'package:promotion_dashboard/core/functions/print.dart';
import 'package:promotion_dashboard/core/functions/snackbar.dart';
import 'package:promotion_dashboard/core/localization/changelocale.dart';
import 'internet_connectivity_service.dart';

class ApiService {
  final Dio _dio;
  final InternetConnectivityService connectivityService;

  ApiService({
    required String baseUrl,
    required this.connectivityService,
    Map<String, String>? defaultHeaders,
  }) : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 20),
          headers: defaultHeaders ?? {},
        )) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (!connectivityService.isConnected) {
          customSnackBar("No internet connection", '',
              snackType: SnackBarType.error,
              snackPosition: SnackBarPosition.topEnd);
          return handler.reject(DioException(
            requestOptions: options,
            error: "No internet connection",
            type: DioExceptionType.cancel,
          ));
        }

        final accessToken = Shared.getValue(StorageKeys.accessToken);
        printDebug(accessToken);
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }

        options.headers['Accept-Language'] =
            LocaleController.getLocalLang().languageCode;
        options.headers['Get-Multi-Language'] = 1;

        return handler.next(options);
      },
      onResponse: (response, handler) {
        printDebug("Response: ${response.statusCode} ${response.data}");
        return handler.next(response);
      },
      onError: (error, handler) {
        printDebug("Error: ${error.message}");
        return handler.next(error);
      },
    ));
  }

  Future<ApiResponse> get(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? pathVariables,
  }) async {
    try {
      final resolvedEndpoint = _resolvePathVariables(endpoint, pathVariables);
      final response =
          await _dio.get(resolvedEndpoint, queryParameters: params);
      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      apiResponse.toString();
      return apiResponse;
    } on DioException catch (e) {
      return _handleError(e, endpoint, params: params);
    }
  }

  Future<ApiResponse> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? pathVariables,
    Map<String, dynamic>? files,
  }) async {
    try {
      final resolvedEndpoint = _resolvePathVariables(endpoint, pathVariables);
      final formData = await _prepareFormData(data, files);
      final response = await _dio.post(resolvedEndpoint, data: formData);

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      apiResponse.toString();
      return apiResponse;
    } on DioException catch (e) {
      return _handleError(e, endpoint, body: data);
    }
  }

  Future<ApiResponse> put(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? pathVariables,
  }) async {
    try {
      final resolvedEndpoint = _resolvePathVariables(endpoint, pathVariables);
      final response = await _dio.put(resolvedEndpoint, data: data);

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      apiResponse.toString();
      return apiResponse;
    } on DioException catch (e) {
      return _handleError(e, endpoint, body: data);
    }
  }

  Future<ApiResponse> delete(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? pathVariables,
  }) async {
    try {
      final resolvedEndpoint = _resolvePathVariables(endpoint, pathVariables);
      final response = await _dio.delete(resolvedEndpoint, data: data);

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      apiResponse.toString();
      return apiResponse;
    } on DioException catch (e) {
      return _handleError(e, endpoint, body: data);
    }
  }

  String _resolvePathVariables(
      String endpoint, Map<String, dynamic>? pathVariables) {
    if (pathVariables != null) {
      pathVariables.forEach((key, value) {
        endpoint = endpoint.replaceAll('{$key}', value.toString());
      });
    }
    return endpoint;
  }

  Future<FormData> _prepareFormData(
      dynamic data, Map<String, dynamic>? files) async {
    final formData = FormData.fromMap(data ?? {});

    if (files != null) {
      files.forEach((key, value) async {
        if (value is File) {
          formData.files.add(MapEntry(
            key,
            await MultipartFile.fromFile(
              value.path,
              filename: value.uri.pathSegments.last,
            ),
          ));
        } else if (value is List<File>) {
          for (var file in value) {
            formData.files.add(MapEntry(
              "$key[]",
              await MultipartFile.fromFile(
                file.path,
                filename: file.uri.pathSegments.last,
              ),
            ));
          }
        }
      });
    }

    return formData;
  }

  ApiResponse _handleError(DioException error, String endpoint,
      {Map<String, dynamic>? params, dynamic body}) {
    final statusCode = error.response?.statusCode;
    final message = error.response?.data['message'];
    error.message;

    if (message != null) {
      customSnackBar('error:', " $message", snackType: SnackBarType.error);
    }
    ApiResponse api = ApiResponse(
      success: false,
      statusCode: statusCode,
      url: endpoint,
      params: params,
      body: body,
      message: message,
    );

    api.toString();

    return api;
  }
}
