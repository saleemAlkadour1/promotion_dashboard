import 'package:promotion_dashboard/data/model/home/products/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductsDataSource extends DataGridSource {
  ProductsDataSource({
    required List<ProductModel> products,
    this.custombuildRow,
    required this.rowsPerPage,
  }) {
    _products = products;
    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)?
      custombuildRow;
  final int rowsPerPage;
  List<ProductModel> _products = [];
  List<DataGridRow> dataGridRows = [];

  void buildPaginatedDataGridRows() {
    dataGridRows = _products
        .map<DataGridRow>((product) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'ID', value: product.id.toString()),
              DataGridCell<String>(columnName: 'Name', value: product.name.en),
              DataGridCell<String>(columnName: 'Type', value: product.type),
              DataGridCell<ProductModel>(columnName: 'Actions', value: product),
            ]))
        .toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    bool isEvenRow = rows.indexOf(row) % 2 == 0;

    return custombuildRow!(row, isEvenRow);
  }
}
