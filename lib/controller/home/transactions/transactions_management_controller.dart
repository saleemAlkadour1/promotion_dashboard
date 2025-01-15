import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/home/transactions/transaction_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/transactions_data.dart';
import 'package:promotion_dashboard/view/widgets/transactions/transactions_details_dialog.dart';

abstract class TransactionsManagementController extends GetxController {
  Future<void> getTransactionsData();
  Future<void> showTransaction(int id);
}

class TransactionsManagementControllerImp
    extends TransactionsManagementController {
  bool loading = false;
  TransactionModel? transactionModel;
  TransactionsData transactionsData = TransactionsData();
  List<TransactionModel>? transactions;
  @override
  void onInit() {
    super.onInit();
    getTransactionsData();
  }

  @override
  Future<void> getTransactionsData() async {
    loading = true;
    update();
    var response = await transactionsData.get();
    if (response.isSuccess) {
      transactions = List.generate(response.data.length,
          (index) => TransactionModel.fromJson(response.data[index]));
      update();
    }
    loading = false;

    update();
  }

  @override
  Future<void> showTransaction(int id) async {
    loading = true;
    update();
    Get.parameters.clear();
    var response = await transactionsData.getTransaction(id);
    if (response.isSuccess) {
      transactionModel = TransactionModel.fromJson(response.data);
    }

    loading = false;
    update();
  }

  void showTransactionDetailsDialog(int id) async {
    await showTransaction(id);
    if (transactionModel != null) {
      Get.dialog(
        TransactionDetailsDialog(
          transactionModel: transactionModel!,
        ),
      );
      update();
    }
  }
}
