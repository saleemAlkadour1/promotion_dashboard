import 'package:promotion_dashboard/data/model/home/orders/order_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrdersDataSource extends DataGridSource {
  OrdersDataSource(
      {required this.custombuildRow, required List<OrderModel> orders}) {
    _orders = orders;
    pagainatedOrders = _orders
        .getRange(0, orders.length >= 9 ? 9 : orders.length)
        .toList(growable: false);
    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;
  int rowsPerPage = 10;

  List<OrderModel> _orders = [];
  List<OrderModel> pagainatedOrders = [];

  List<DataGridRow> dataGridRows = [];

  void buildPaginatedDataGridRows() {
    dataGridRows = pagainatedOrders
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

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = (startIndex + rowsPerPage).clamp(0, _orders.length);

    if (startIndex < _orders.length) {
      pagainatedOrders =
          _orders.getRange(startIndex, endIndex).toList(growable: false);

      buildPaginatedDataGridRows();

      notifyListeners();
    } else {
      pagainatedOrders = [];
    }

    return true;
  }
}
