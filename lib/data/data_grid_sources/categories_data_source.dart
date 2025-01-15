// ignore_for_file: prefer_const_constructors

import 'package:promotion_dashboard/data/model/home/categories/category_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CategoriesDataSource extends DataGridSource {
  CategoriesDataSource(
      {required this.custombuildRow, required List<CategoryModel> categories}) {
    _categories = categories;
    buildPaginatedData();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;
  late List<CategoryModel> _categories;
  List<DataGridRow> paginatedRows = [];
  int rowsPerPage = 10;

  void buildPaginatedData({int startIndex = 0}) {
    paginatedRows = _categories
        .skip(startIndex)
        .take(rowsPerPage)
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
