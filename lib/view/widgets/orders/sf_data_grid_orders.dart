import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/orders/orders_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/data/data_grid_sources/orders_data_source.dart';
import 'package:promotion_dashboard/data/model/home/orders/order_model.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_icon_svg.dart';
import 'package:promotion_dashboard/view/widgets/general/responsive_sf_data_pager.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SFDataGridOrders extends StatelessWidget {
  const SFDataGridOrders({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersManagementControllerImp>(builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.filteredOrders.isEmpty,
      );
      if (res.isValid) {
        return res.response!;
      }
      OrdersDataSource ordersDataSource = OrdersDataSource(
        orders: controller.filteredOrders,
        custombuildRow: (row, isEvenRow) {
          final color = isEvenRow ? const Color(0xFFF9F9F9) : Colors.white;
          return DataGridRowAdapter(
            color: color,
            cells: row.getCells().map<Widget>((cell) {
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
                                cell.value is OrderModel) {
                              final order = cell.value as OrderModel;
                              controller.showOrderDetailsDialog(order.id);
                            }
                          },
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ));
              }
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cell.value.toString(),
                  style: MyText.appStyle.fs16.wMedium.reColorText
                      .responsiveStyle(context),
                ),
              );
            }).toList(),
          );
        },
      );
      return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SfDataGrid(
                  gridLinesVisibility: GridLinesVisibility.none,
                  headerGridLinesVisibility: GridLinesVisibility.none,
                  source: ordersDataSource,
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
                      columnName: 'User name',
                      label: Container(
                          color: AppColors.white,
                          alignment: Alignment.center,
                          child: Text(
                            'User name',
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
                      columnName: 'Status',
                      label: Container(
                          color: AppColors.white,
                          alignment: Alignment.center,
                          child: Text(
                            'Status',
                            style: MyText.appStyle.fs16.wBold.reColorText
                                .responsiveStyle(context),
                          )),
                    ),
                    GridColumn(
                      columnName: 'Category',
                      label: Container(
                          color: AppColors.white,
                          alignment: Alignment.center,
                          child: Text(
                            'Category',
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
                  dataSource: ordersDataSource,
                  onPageNavigationStart: (startIndex) {
                    controller.loading = true;
                    controller.update();
                  },
                  onPageNavigationEnd: (startIndex) {
                    controller.loading = false;
                    controller.update();
                  },
                  rowsPerPage: 10,
                  total: controller.orders.length),
            ],
          ),
          if (controller.loading)
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.color_4EB7F2,
              ),
            )
        ],
      );
    });
  }
}
