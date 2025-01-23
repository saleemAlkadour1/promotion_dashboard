import 'package:get/get.dart';
import 'package:promotion_dashboard/data/model/general/paganiation_data_model.dart';
import 'package:promotion_dashboard/data/model/home/transactions/transaction_model.dart';
import 'package:promotion_dashboard/data/resource/remote/home/transactions_data.dart';
import 'package:promotion_dashboard/view/widgets/home/transactions/transactions_details_dialog.dart';

abstract class TransactionsManagementController extends GetxController {
  String? typeValue = 'All';
  Future<void> getTransactionsData({required int pageIndex});
  Future<void> showTransaction(int id);
  void updateTypeValue(String value);
  void filterTransactions();
}

class TransactionsManagementControllerImp
    extends TransactionsManagementController {
  bool loading = false;
  TransactionModel? transactionModel;
  TransactionsData transactionsData = TransactionsData();
  List<TransactionModel> transactions = [];
  List<TransactionModel> filteredTrnsactions = [];
  late PaganationDataModel paganationDataModel;

  @override
  void onInit() {
    super.onInit();
    getTransactionsData(pageIndex: 1);
    filterTransactions();
  }

  @override
  Future<void> getTransactionsData({required int pageIndex}) async {
    loading = true;
    update();
    var response = await transactionsData.get(pageIndex: pageIndex);
    if (response.isSuccess) {
      transactions = List.generate(response.data.length,
          (index) => TransactionModel.fromJson(response.data[index]));
      paganationDataModel = PaganationDataModel.fromJson(response.body['meta']);
      filterTransactions();

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

  @override
  void updateTypeValue(String value) {
    typeValue = value;
    filterTransactions();
    update();
  }

  @override
  void filterTransactions() {
    if (typeValue == 'All') {
      filteredTrnsactions = transactions;
    } else {
      filteredTrnsactions = transactions
          .where((transaction) => transaction.type == typeValue!.toLowerCase())
          .toList();
    }
  }
}
