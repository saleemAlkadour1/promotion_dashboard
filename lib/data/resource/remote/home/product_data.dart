import 'dart:io';

import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class ProductData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get() async {
    var response = await apiService.get(
      EndPoints.store.products,
      params: {},
    );
    return response;
  }

  Future<ApiResponse> create({
    required String name,
    required String description,
    required bool visible,
    required int productCategoryId,
    required String type,
    required num purchasePrice,
    required num salePrice,
    required bool numberly,
    required String source,
    required List<File> images,
    num? min,
    num? max,
    required bool available,
    required String serverName,
    required String productName,
    required String countryName,
    required String operatorName,
  }) async {
    var response = await apiService.post(EndPoints.store.products, data: {
      'name[en]': name,
      'description[en]': description,
      'visible': visible ? 1 : 0,
      'product_display_method': 'GridView',
      'product_category_id': productCategoryId,
      'type': type,
      'purchase_price': purchasePrice,
      'sale_price': salePrice,
      'numberly': numberly ? 1 : 0,
      'source': source,
      'min': min,
      'max': max,
      'available': available ? 1 : 0,
      'server_name': serverName,
      'data[product]': productName,
      'data[country]': countryName,
      'data[operator]': operatorName,
    }, files: {
      'images': images
    });
    return response;
  }

  Future<ApiResponse> delete(int id) async {
    var response = await apiService
        .delete(EndPoints.store.product, pathVariables: {'id': id});
    return response;
  }

  Future<ApiResponse> show(productId) async {
    var response = await apiService.get(
      EndPoints.store.product,
      params: {},
      pathVariables: {
        'id': productId,
      },
    );
    return response;
  }
}
