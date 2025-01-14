import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/home/orders/order_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/orders_data.dart';
import 'package:promotion_dashboard/view/widgets/orders/orders_details_dialog.dart';

abstract class OrdersManagementController extends GetxController {
  String? statusValue = 'All';
  Future<void> getOrdersData();
  Future<void> showOrder(int id);
  void updateStatusValue(String value);
  void filterOrders();
}

class OrdersManagementControllerImp extends OrdersManagementController {
  bool loading = false;
  OrderModel? orderModel;
  @override
  void onInit() {
    super.onInit();
    getOrdersData();
    filteredOrders = orders;
  }

  OrdersData ordersData = OrdersData();
  List<OrderModel>? orders;
  List<OrderModel>? filteredOrders;

  @override
  Future<void> getOrdersData() async {
    loading = true;
    update();
    var response = await ordersData.get();
    if (response.isSuccess) {
      orders = List.generate(response.data.length,
          (index) => OrderModel.fromJson(response.data[index]));
      filteredOrders = orders;

      update();
    }
    loading = false;

    update();
  }

  @override
  Future<void> showOrder(int id) async {
    loading = true;
    update();
    Get.parameters.clear();
    var response = await ordersData.getOrder(id);
    if (response.isSuccess) {
      orderModel = OrderModel.fromJson(response.data);
    }

    loading = false;
    update();
  }

  void showOrderDetailsDialog(int id) async {
    await showOrder(id);
    if (orderModel != null) {
      Get.dialog(
        OrderDetailsDialog(
          orderModel: orderModel!,
        ),
      );
      update();
    }
  }

  @override
  void updateStatusValue(String value) {
    statusValue = value;
    filterOrders();
    update();
  }

  @override
  void filterOrders() {
    if (statusValue == 'All') {
      filteredOrders = orders;
    } else {
      filteredOrders = orders
          ?.where((order) => order.status == statusValue!.toLowerCase())
          .toList();
    }
  }
}
