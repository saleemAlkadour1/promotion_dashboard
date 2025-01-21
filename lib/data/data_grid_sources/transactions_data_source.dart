import 'package:promotion_dashboard/data/model/home/transactions/transaction_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TransactionsDataSource extends DataGridSource {
  TransactionsDataSource(
      {required this.custombuildRow,
      required List<TransactionModel> transactions}) {
    _transactions = transactions;

    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, int index) custombuildRow;

  List<TransactionModel> _transactions = [];

  List<DataGridRow> dataGridRows = [];

  void buildPaginatedDataGridRows() {
    dataGridRows = _transactions
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
}
