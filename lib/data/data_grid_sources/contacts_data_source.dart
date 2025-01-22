import 'package:promotion_dashboard/data/model/home/contacts/contact_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ContactsDataSource extends DataGridSource {
  ContactsDataSource({
    required this.custombuildRow,
    required List<ContactModel> contacts,
  }) {
    _contacts = contacts;

    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;
  List<ContactModel> _contacts = [];

  List<DataGridRow> dataGridRows = [];

  void buildPaginatedDataGridRows() {
    dataGridRows = _contacts
        .map<DataGridRow>((contact) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'ID', value: contact.id.toString()),
              DataGridCell<String>(columnName: 'Name', value: contact.name.en),
              DataGridCell<String>(columnName: 'URL', value: contact.url),
              DataGridCell<ContactModel>(columnName: 'Actions', value: contact),
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
}
