import 'package:get/get.dart';
import 'package:promotion_dashboard/core/classes/api_response.dart';
import 'package:promotion_dashboard/core/classes/curd.dart';
import 'package:promotion_dashboard/routes/end_points.dart';

class TransactionsData {
  ApiService apiService = Get.find();
  Future<ApiResponse> get({required int pageIndex}) async {
    var response = await apiService.get(
      EndPoints.transaction.transactions,
      params: {'page': pageIndex},
    );
    return response;
  }

  Future<ApiResponse> getTransaction(int id) async {
    var response = await apiService.get(
      EndPoints.transaction.transaction,
      pathVariables: {'id': id},
      params: {},
    );
    return response;
  }
}
