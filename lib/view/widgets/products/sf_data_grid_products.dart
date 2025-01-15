import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/home/products/products_management_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/core/constants/routes.dart';
import 'package:promotion_dashboard/data/data_grid_sources/products_data_source.dart';
import 'package:promotion_dashboard/data/model/home/products/product_model.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_icon_svg.dart';
import 'package:promotion_dashboard/view/widgets/general/responsive_sf_data_pager.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SFDataGridProducts extends StatelessWidget {
  const SFDataGridProducts({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsManagementControllerImp>(builder: (controller) {
      ProductsDataSource productsDataSource = ProductsDataSource(
        products: controller.products!,
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
                        CustomIconSvg(
                          path: Assets.imagesSvgEdit,
                          size: 20,
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        CustomIconSvg(
                          path: Assets.imagesSvgDelete,
                          size: 20,
                          onTap: () async {
                            if (cell.columnName == 'Actions' &&
                                cell.value is ProductModel) {
                              final category = cell.value as ProductModel;
                              await controller.deleteProduct(category.id);
                            }
                          },
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        CustomIconSvg(
                          path: Assets.imagesSvgEye,
                          size: 16,
                          onTap: () {
                            if (cell.columnName == 'Actions' &&
                                cell.value is ProductModel) {
                              final product = cell.value as ProductModel;
                              controller.showProductDetailsDialog(product.id);
                            }
                          },
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        if (cell.value.type == 'store')
                          CustomIconSvg(
                            path: Assets.imagesSvgBalance,
                            size: 16,
                            onTap: () {
                              if (cell.columnName == 'Actions' &&
                                  cell.value is ProductModel) {
                                final product = cell.value as ProductModel;
                                Get.toNamed(AppRoutes.store, parameters: {
                                  'id': product.id.toString(),
                                });
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
                  style: MyText.appStyle.fs16.wMedium.reColorText
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
              source: productsDataSource,
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
                  columnName: 'Visible',
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
              dataSource: productsDataSource,
              buildPaginatedData: (startIndex) {
                productsDataSource.buildPaginatedData(startIndex: startIndex);
              },
              rowsPerPage: 10,
              length: controller.products!.length),
        ],
      );
    });
  }
}
