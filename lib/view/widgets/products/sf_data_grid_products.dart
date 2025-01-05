// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/controller/products/sf_data_grid_products_controller.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/core/functions/size.dart';
import 'package:promotion_dashboard/data/data_grid_sources/products_data_source.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_icon_svg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SFDataGridProducts extends StatelessWidget {
  const SFDataGridProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(SfDataGridProductsControllerImp());
    return GetBuilder<SfDataGridProductsControllerImp>(builder: (controller) {
      log(MediaQuery.sizeOf(context).width.toString());
      ProductsDataSource productsDataSource = ProductsDataSource(
          custombuildRow: (row, isEvenRow) {
            final color = isEvenRow ? const Color(0xFFF9F9F9) : Colors.white;
            return DataGridRowAdapter(
              color: color,
              cells: row.getCells().map<Widget>((cell) {
                if (cell.columnName == 'Actions') {
                  return Container(
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconSvg(path: Assets.imagesSvgEdit, size: 20),
                          SizedBox(
                            width: 8,
                          ),
                          CustomIconSvg(path: Assets.imagesSvgDelete, size: 20),
                          SizedBox(
                            width: 8,
                          ),
                          CustomIconSvg(
                              path: Assets.imagesSvgDownload, size: 20),
                          SizedBox(
                            width: 8,
                          ),
                          CustomIconSvg(path: Assets.imagesSvgEye, size: 16),
                          SizedBox(
                            width: 8,
                          ),
                          CustomIconSvg(
                              path: Assets.imagesSvgMenuCircleVertical,
                              size: 20),
                        ],
                      ));
                }
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    cell.value.toString(),
                    style:
                        MyText.appStyle.fs16.wMedium.reColorText.style(context),
                  ),
                );
              }).toList(),
            );
          },
          products: controller.products);
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
                            .style(context),
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
                            .style(context),
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
                            .style(context),
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
                            .style(context),
                      )),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SfDataPager(
                itemPadding: EdgeInsets.symmetric(horizontal: width(0)),
                delegate: productsDataSource,
                pageCount: (controller.products.length /
                        productsDataSource.rowsPerPage)
                    .ceilToDouble(),
                onPageNavigationStart: (pageIndex) {
                  final startIndex = pageIndex * productsDataSource.rowsPerPage;
                  productsDataSource.buildPaginatedData(startIndex: startIndex);
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
