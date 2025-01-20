import 'package:promotion_dashboard/data/model/home/products/product_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ProductsDataSource extends DataGridSource {
  ProductsDataSource(
      {required this.custombuildRow, required List<ProductModel> products}) {
    _products = products;
    pagainatedProducts = _products
        .getRange(0, products.length >= 9 ? 9 : products.length)
        .toList(growable: false);
    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;
  int rowsPerPage = 10;

  List<ProductModel> _products = [];
  List<ProductModel> pagainatedProducts = [];
  List<DataGridRow> dataGridRows = [];

  void buildPaginatedDataGridRows() {
    dataGridRows = pagainatedProducts
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

    return custombuildRow(row, isEvenRow);
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    // حساب البداية والنهاية بناءً على الصفحة الحالية وعدد الأسطر لكل صفحة
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = (startIndex + rowsPerPage)
        .clamp(0, _products.length); // ضمان الحد الأقصى

    // إذا كانت البيانات ضمن النطاق
    if (startIndex < _products.length) {
      pagainatedProducts =
          _products.getRange(startIndex, endIndex).toList(growable: false);

      // تحديث الصفوف في DataGrid
      buildPaginatedDataGridRows();

      // إعلام المستمعين بتغيير البيانات
      notifyListeners();
    } else {
      // إذا لم تكن هناك بيانات صالحة في الصفحة
      pagainatedProducts = [];
    }

    return true;
  }
}
