// ignore_for_file: prefer_const_constructors

import 'package:promotion_dashboard/data/model/home/categories/category_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CategoriesDataSource extends DataGridSource {
  CategoriesDataSource(
      {required this.custombuildRow, required List<CategoryModel> categories}) {
    _categories = categories;
    pagainatedCategories = _categories
        .getRange(0, categories.length >= 9 ? 9 : categories.length)
        .toList(growable: false);
    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;
  List<CategoryModel> _categories = [];
  List<CategoryModel> pagainatedCategories = [];

  List<DataGridRow> dataGridRows = [];
  int rowsPerPage = 10;

  void buildPaginatedDataGridRows() {
    dataGridRows = pagainatedCategories
        .map<DataGridRow>((category) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'ID', value: category.id.toString()),
              DataGridCell<String>(columnName: 'Name', value: category.name.en),
              DataGridCell<String>(
                  columnName: 'Description', value: category.description.en),
              DataGridCell<CategoryModel>(
                  columnName: 'Actions', value: category),
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
    // حساب البداية والنهاية بناءً على الصفحة الحالية وعدد الأسطر لكل صفحة
    int startIndex = newPageIndex * rowsPerPage;
    int endIndex = (startIndex + rowsPerPage)
        .clamp(0, _categories.length); // ضمان الحد الأقصى

    // إذا كانت البيانات ضمن النطاق
    if (startIndex < _categories.length) {
      pagainatedCategories =
          _categories.getRange(startIndex, endIndex).toList(growable: false);

      // تحديث الصفوف في DataGrid
      buildPaginatedDataGridRows();

      // إعلام المستمعين بتغيير البيانات
      notifyListeners();
    } else {
      // إذا لم تكن هناك بيانات صالحة في الصفحة
      pagainatedCategories = [];
    }

    return true;
  }
}
