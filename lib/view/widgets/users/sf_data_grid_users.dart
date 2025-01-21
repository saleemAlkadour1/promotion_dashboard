import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/users/users_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/core/widgets/handling_data_view.dart';
import 'package:promotion_dashboard/data/data_grid_sources/users_data_source.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_icon.dart';
import 'package:promotion_dashboard/view/widgets/general/responsive_sf_data_pager.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SFDataGridUsers extends StatelessWidget {
  const SFDataGridUsers({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersManagementControllerImp>(builder: (controller) {
      var res = HandlingDataView(
        loading: controller.loading,
        dataIsEmpty: controller.users.isEmpty,
      );
      if (res.isValid) {
        return res.response!;
      }
      UsersDataSource usersDataSource = UsersDataSource(
        users: controller.filteredUsers,
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
                            // if (cell.columnName == 'Actions' &&
                            //     cell.value is OrderModel) {
                            //   final order = cell.value as OrderModel;
                            //   controller.showOrderDetailsDialog(order.id);
                            // }
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
                child: Builder(builder: (context) {
                  var res = HandlingDataView(
                    loading: controller.loading,
                    dataIsEmpty: controller.filteredUsers.isEmpty,
                  );
                  if (res.isValid) {
                    return res.response!;
                  }
                  return SfDataGrid(
                    gridLinesVisibility: GridLinesVisibility.none,
                    headerGridLinesVisibility: GridLinesVisibility.none,
                    source: usersDataSource,
                    columnWidthMode: MediaQuery.sizeOf(context).width <= 475
                        ? ColumnWidthMode.auto
                        : ColumnWidthMode.fill,
                    columnSizer: ColumnSizer(),
                    rowsPerPage: controller.paganationDataModel.perPage,
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
                        columnName: 'Name',
                        label: Container(
                            color: AppColors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Name',
                              style: MyText.appStyle.fs16.wBold.reColorText
                                  .responsiveStyle(context),
                            )),
                      ),
                      GridColumn(
                        columnName: 'Role',
                        label: Container(
                            color: AppColors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Role',
                              style: MyText.appStyle.fs16.wBold.reColorText
                                  .responsiveStyle(context),
                            )),
                      ),
                      GridColumn(
                        columnName: 'Email',
                        label: Container(
                            color: AppColors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Email',
                              style: MyText.appStyle.fs16.wBold.reColorText
                                  .responsiveStyle(context),
                            )),
                      ),
                      GridColumn(
                        columnName: 'Phone',
                        label: Container(
                            color: AppColors.white,
                            alignment: Alignment.center,
                            child: Text(
                              'Phone',
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
                  );
                }),
              ),
              ResponsiveSfDataPager(
                  dataSource: usersDataSource,
                  onPageNavigationStart: (pageIndex) {},
                  onPageNavigationEnd: (pageIndex) async {
                    await controller.getUsersData(pageIndex: pageIndex + 1);
                    controller.update();
                  },
                  rowsPerPage: controller.paganationDataModel.perPage,
                  total: controller.paganationDataModel.total),
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
