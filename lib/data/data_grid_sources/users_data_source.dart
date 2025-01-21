import 'package:promotion_dashboard/data/model/home/users/user_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UsersDataSource extends DataGridSource {
  UsersDataSource(
      {required this.custombuildRow, required List<UserModel> users}) {
    _users = users;
    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;

  List<UserModel> _users = [];

  List<DataGridRow> dataGridRows = [];

  void buildPaginatedDataGridRows() {
    dataGridRows = _users
        .map<DataGridRow>((user) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'ID', value: user.id.toString()),
              DataGridCell<String>(columnName: 'Name', value: user.firstName),
              DataGridCell<String>(columnName: 'Role', value: user.role),
              DataGridCell<String>(columnName: 'Email', value: user.email),
              DataGridCell<String>(columnName: 'Phone', value: user.phone),
              DataGridCell<UserModel>(columnName: 'Actions', value: user),
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
