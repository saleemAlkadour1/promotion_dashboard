import 'package:promotion_dashboard/data/model/home/ads/ad_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AdsDataSource extends DataGridSource {
  AdsDataSource({
    required this.custombuildRow,
    required List<AdModel> ads,
  }) {
    _ads = ads;

    buildPaginatedDataGridRows();
  }

  final DataGridRowAdapter Function(DataGridRow row, bool isEvenRow)
      custombuildRow;
  List<AdModel> _ads = [];

  List<DataGridRow> dataGridRows = [];

  void buildPaginatedDataGridRows() {
    dataGridRows = _ads
        .map<DataGridRow>((ad) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'ID', value: ad.id.toString()),
              DataGridCell<String>(
                  columnName: 'Start date', value: ad.startDate.toString()),
              DataGridCell<String>(
                  columnName: 'End date', value: ad.endDate.toString()),
              DataGridCell<String>(
                  columnName: 'Active', value: ad.isActive ? 'Yes' : 'No'),
              DataGridCell<AdModel>(columnName: 'Actions', value: ad),
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
