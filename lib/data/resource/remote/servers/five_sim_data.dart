import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class FiveSimData {
  ApiService apiService = Get.find();
  Future<ApiResponse> getProducts() async {
    var response =
        await apiService.get(EndPoints.server.productsFiveSim, params: {});
    return response;
  }

  Future<ApiResponse> getCountriesAndOperators(String product) async {
    var response = await apiService
        .get(EndPoints.server.countriesAndOperators, pathVariables: {
      'product': product,
    }, params: {});
    return response;
  }
}
