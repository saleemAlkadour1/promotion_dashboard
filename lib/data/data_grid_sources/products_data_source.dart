// ignore_for_file: prefer_const_constructors

import 'package:promotion_dashboard/data/model/home/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductsDataSource extends DataGridSource {
  ProductsDataSource(
      {required this.custombuildRow, required List<ProductModel> products}) {
    _products = products;
    buildPaginatedData();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;
  late List<ProductModel> _products;
  List<DataGridRow> paginatedRows = [];
  int rowsPerPage = 10;

  void buildPaginatedData({int startIndex = 0}) {
    paginatedRows = _products
        .skip(startIndex)
        .take(rowsPerPage)
        .map<DataGridRow>((product) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'ID', value: product.id.toString()),
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
    bool isEvenRow = rows.indexOf(row) % 2 == 0;

    return custombuildRow(row, isEvenRow);
  }
}
