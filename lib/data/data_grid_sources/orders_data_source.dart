import 'package:promotion_dashboard/data/model/home/orders/order_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrdersDataSource extends DataGridSource {
  OrdersDataSource(
      {required this.custombuildRow, required List<OrderModel> orders}) {
    _orders = orders;

    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;

  List<OrderModel> _orders = [];

  List<DataGridRow> dataGridRows = [];

  void buildPaginatedDataGridRows() {
    dataGridRows = _orders
        .map<DataGridRow>((order) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'ID', value: order.id.toString()),
              DataGridCell<String>(
                  columnName: 'User name', value: order.user.firstName),
              DataGridCell<String>(
                  columnName: 'Type', value: order.product.type),
              DataGridCell<String>(columnName: 'Status', value: order.status),
              DataGridCell<String>(
                  columnName: 'Category', value: order.product.category.nameEn),
              DataGridCell<OrderModel>(columnName: 'Actions', value: order),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    bool isEvenRow = rows.indexOf(row) % 2 == 0;

    return custombuildRow(row, isEvenRow);
  }
}
