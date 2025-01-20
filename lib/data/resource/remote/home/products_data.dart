import 'dart:io';

import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class ProductsData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get({required int pageIndex}) async {
    var response = await apiService.get(
      EndPoints.store.products,
      pathVariables: {},
      params: {
        'page': pageIndex,
      },
    );
    return response;
  }

  Future<ApiResponse> create(
      {required Map names,
      required Map descriptions,
      required bool visible,
      required int productCategoryId,
      required String type,
      required num purchasePrice,
      required num salePrice,
      bool? numberly,
      required String source,
      required List<File> images,
      num? min,
      num? max,
      required bool available,
      String? serverName,
      Map<String, dynamic>? serverData,
      List? inputs}) async {
    var response = await apiService.post(
      EndPoints.store.products,
      data: {
        'name': names,
        'description': descriptions,
        'visible': visible ? 1 : 0,
        'product_display_method': 'GridView',
        'product_category_id': productCategoryId,
        'type': type,
        'purchase_price': purchasePrice,
        'sale_price': salePrice,
        'numberly': (numberly ?? false) ? 1 : 0,
        'source': source.toLowerCase(),
        'min': min,
        'max': max,
        'available': available ? 1 : 0,
        'server_name': serverName,
        'data': serverData,
        'inputs': inputs,
      },
      files: {'images': images},
    );
    return response;
  }

  Future<ApiResponse> show(id) async {
    var response = await apiService.get(
      EndPoints.store.product,
      params: {},
      pathVariables: {
        'id': id,
      },
    );
    return response;
  }

  Future<ApiResponse> update({
    required int id,
    required Map names,
    required Map descriptions,
    required bool visible,
    required int productCategoryId,
    required num purchasePrice,
    required num salePrice,
    bool? numberly,
    required String source,
    // required List<File> images,
    num? min,
    num? max,
    required bool available,
  }) async {
    var response = await apiService.post(
      EndPoints.store.product,
      pathVariables: {'id': id},
      data: {
        'name': names,
        'description': descriptions,
        'visible': visible ? 1 : 0,
        'product_display_method': 'GridView',
        'product_category_id': productCategoryId,
        'purchase_price': purchasePrice,
        'sale_price': salePrice,
        'numberly': (numberly ?? false) ? 1 : 0,
        'source': source.toLowerCase(),
        'min': min,
        'max': max,
        'available': available ? 1 : 0,
      },
      // files: {'images': images},
    );
    return response;
  }

  Future<ApiResponse> getStore(productId) async {
    var response = await apiService.get(EndPoints.store.productItems, params: {
      'product_id': productId,
    });
    return response;
  }

  Future<ApiResponse> showProductStore(int id) async {
    var response =
        await apiService.get(EndPoints.store.productItem, pathVariables: {
      'id': id,
    });
    return response;
  }

  Future<ApiResponse> createStore({
    required int productId,
    required bool visible,
    required List values,
  }) async {
    var response = await apiService.post(EndPoints.store.productItems, data: {
      'visible': visible ? 1 : 0,
      'product_id': productId,
      'values': values,
    });
    return response;
  }

  Future<ApiResponse> updateStore({
    required int productId,
    required bool visible,
    required List values,
  }) async {
    var response =
        await apiService.post(EndPoints.store.productItem, pathVariables: {
      'id': productId
    }, data: {
      'visible': visible ? 1 : 0,
      'values': values,
    });
    return response;
  }

  Future<ApiResponse> deleteStore(int id) async {
    var response = await apiService.delete(
      EndPoints.store.productItem,
      pathVariables: {'id': id},
    );
    return response;
  }

  Future<ApiResponse> delete(int id) async {
    var response = await apiService
        .delete(EndPoints.store.product, pathVariables: {'id': id});
    return response;
  }
}
