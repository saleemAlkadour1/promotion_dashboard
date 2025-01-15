import 'package:promotion_dashboard/data/model/home/transactions/transaction_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransactionsDataSource extends DataGridSource {
  TransactionsDataSource(
      {required this.custombuildRow,
      required List<TransactionModel> transactions}) {
    _transactions = transactions;
    buildPaginatedData();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;
  late List<TransactionModel> _transactions;
  List<DataGridRow> paginatedRows = [];
  int rowsPerPage = 10;

  void buildPaginatedData({int startIndex = 0}) {
    paginatedRows = _transactions
        .skip(startIndex)
        .take(rowsPerPage)
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
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => paginatedRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    bool isEvenRow = rows.indexOf(row) % 2 == 0;

    return custombuildRow(row, isEvenRow);
  }
}
