import 'package:promotion_dashboard/data/model/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductsDataSource extends DataGridSource {
  ProductsDataSource(
      {required this.customBuildRow, required List<ProductModel> products}) {
    _products = products;
    buildPaginatedData();
  }

  final DataGridRowAdapter Function(DataGridRow, int) customBuildRow;
  late List<ProductModel> _products;
  List<DataGridRow> paginatedRows = [];
  int rowsPerPage = 10;

  // تحديث البيانات لتصبح حسب الصفحة
  void buildPaginatedData({int startIndex = 0}) {
    paginatedRows = _products
        .skip(startIndex)
        .take(rowsPerPage)
        .map<DataGridRow>((product) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'ID', value: product.id),
              DataGridCell<String>(columnName: 'Name', value: product.name),
              DataGridCell<String>(columnName: 'Type', value: product.type),
              DataGridCell<ProductModel>(columnName: 'Actions', value: product),
            ]))
        .toList();
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => paginatedRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final int rowIndex = paginatedRows.indexOf(row);
    return customBuildRow(row, rowIndex);
  }
}
