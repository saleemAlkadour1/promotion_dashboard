import 'package:promotion_dashboard/data/model/home/transactions/transaction_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransactionsDataSource extends DataGridSource {
  TransactionsDataSource(
      {required this.custombuildRow,
      required List<TransactionModel> transactions}) {
    _transactions = transactions;
    pagainatedTransactions = _transactions
        .getRange(0, transactions.length >= 9 ? 9 : transactions.length)
        .toList(growable: false);
    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, int index) custombuildRow;
  int rowsPerPage = 10;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> pagainatedTransactions = [];

  List<DataGridRow> dataGridRows = [];

  void buildPaginatedDataGridRows() {
    dataGridRows = pagainatedTransactions
        .map<DataGridRow>((transaction) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'ID', value: transaction.id.toString()),
              DataGridCell<String>(
                  columnName: 'User name', value: transaction.user.firstName),
              DataGridCell<String>(
                  columnName: 'Amount',
                  value: '${transaction.amount} ${transaction.currency}'),
              DataGridCell<String>(columnName: 'Type', value: transaction.type),
              DataGridCell<TransactionModel>(
                  columnName: 'Actions', value: transaction),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    int index = rows.indexOf(row);

    return custombuildRow(row, index);
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = (startIndex + rowsPerPage).clamp(0, _transactions.length);

    if (startIndex < _transactions.length) {
      pagainatedTransactions =
          _transactions.getRange(startIndex, endIndex).toList(growable: false);

      buildPaginatedDataGridRows();

      notifyListeners();
    } else {
      pagainatedTransactions = [];
    }

    return true;
  }
}
