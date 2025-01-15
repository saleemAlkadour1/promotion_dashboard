import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/transactions/transactions_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/data/data_grid_sources/transactions_data_source.dart';
import 'package:promotion_dashboard/data/model/home/transactions/transaction_model.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_icon_svg.dart';
import 'package:promotion_dashboard/view/widgets/general/responsive_sf_data_pager.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SFDataGridTransactions extends StatelessWidget {
  const SFDataGridTransactions({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsManagementControllerImp>(
        builder: (controller) {
      TransactionsDataSource transactionsDataSource = TransactionsDataSource(
        transactions: controller.filteredTrnsactions!,
        custombuildRow: (row, index) {
          final color = index % 2 == 0 ? const Color(0xFFF9F9F9) : Colors.white;
          String type = controller.transactions![index].type;
          return DataGridRowAdapter(
            color: color,
            cells: row.getCells().map<Widget>((cell) {
              if (cell.columnName == 'Actions' &&
                  cell.value is TransactionModel) {
                final transaction = cell.value as TransactionModel;
                type = transaction.type;
              }
              if (cell.columnName == 'Actions') {
                return Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIcon(
                          path: Assets.imagesSvgEye,
                          size: 16,
                          onTap: () {
                            if (cell.columnName == 'Actions' &&
                                cell.value is TransactionModel) {
                              final transaction =
                                  cell.value as TransactionModel;
                              controller
                                  .showTransactionDetailsDialog(transaction.id);
                            }
                          },
                        ),
                      ],
                    ));
              }
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cell.value.toString(),
                  style: MyText.appStyle.fs16.wMedium
                      .reCustomColor(
                          type == 'out' ? AppColors.green : AppColors.red)
                      .responsiveStyle(context),
                ),
              );
            }).toList(),
          );
        },
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SfDataGrid(
              gridLinesVisibility: GridLinesVisibility.none,
              headerGridLinesVisibility: GridLinesVisibility.none,
              source: transactionsDataSource,
              columnWidthMode: MediaQuery.sizeOf(context).width <= 475
                  ? ColumnWidthMode.auto
                  : ColumnWidthMode.fill,
              columnSizer: ColumnSizer(),
              rowsPerPage: 10,
              columns: [
                GridColumn(
                  columnName: 'ID',
                  label: Container(
                      color: AppColors.white,
                      alignment: Alignment.center,
                      child: Text(
                        'ID',
                        style: MyText.appStyle.fs16.wBold.reColorText
                            .responsiveStyle(context),
                      )),
                ),
                GridColumn(
                  columnName: 'User Name',
                  label: Container(
                      color: AppColors.white,
                      alignment: Alignment.center,
                      child: Text(
                        'User Name',
                        style: MyText.appStyle.fs16.wBold.reColorText
                            .responsiveStyle(context),
                      )),
                ),
                GridColumn(
                  columnName: 'Amount',
                  label: Container(
                      color: AppColors.white,
                      alignment: Alignment.center,
                      child: Text(
                        'Amount',
                        style: MyText.appStyle.fs16.wBold.reColorText
                            .responsiveStyle(context),
                      )),
                ),
                GridColumn(
                  columnName: 'Type',
                  label: Container(
                      color: AppColors.white,
                      alignment: Alignment.center,
                      child: Text(
                        'Type',
                        style: MyText.appStyle.fs16.wBold.reColorText
                            .responsiveStyle(context),
                      )),
                ),
                GridColumn(
                  columnName: 'Actions',
                  label: Container(
                      color: AppColors.white,
                      alignment: Alignment.center,
                      child: Text(
                        'Actions',
                        style: MyText.appStyle.fs16.wBold.reColorText
                            .responsiveStyle(context),
                      )),
                ),
              ],
            ),
          ),
          ResponsiveSfDataPager(
              dataSource: transactionsDataSource,
              buildPaginatedData: (startIndex) {
                transactionsDataSource.buildPaginatedData(
                    startIndex: startIndex);
              },
              rowsPerPage: 10,
              length: controller.transactions!.length),
        ],
      );
    });
  }
}
