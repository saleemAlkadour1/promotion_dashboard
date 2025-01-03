// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/core/constants/size_config.dart';
import 'package:promotion_dashboard/core/functions/size.dart';
import 'package:promotion_dashboard/data/model/product_model.dart';
import 'package:promotion_dashboard/data/resource/products_data_source.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_icon_svg.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SFDataGridProducts extends StatefulWidget {
  const SFDataGridProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  State<SFDataGridProducts> createState() => _SFDataGridProductsState();
}

class _SFDataGridProductsState extends State<SFDataGridProducts> {
  late ProductsDataSource _productsDataSource;
  @override
  void initState() {
    super.initState();

    _productsDataSource = ProductsDataSource(
      products: widget.products,
      customBuildRow: (row, rowIndex) {
        final isEvenRow = rowIndex % 2 == 0;
        final color = isEvenRow ? Color(0xFFF9F9F9) : Colors.white;

        return DataGridRowAdapter(
          color: color,
          cells: row.getCells().map<Widget>((cell) {
            if (cell.columnName == 'Actions') {
              return buildActions(cell.value);
            }
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                cell.value.toString(),
                style: MyText.appStyle.fs16.wMedium.reColorText.style(context),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfDataGrid(
            gridLinesVisibility: GridLinesVisibility.none,
            headerGridLinesVisibility: GridLinesVisibility.none,
            source: _productsDataSource,
            columnWidthMode: ColumnWidthMode.fill,
            rowsPerPage: 10,
            columns: [
              GridColumn(
                columnName: 'ID',
                label: Container(
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'ID',
                      style:
                          MyText.appStyle.fs16.wBold.reColorText.style(context),
                    )),
              ),
              GridColumn(
                columnName: 'Name',
                label: Container(
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Name',
                      style:
                          MyText.appStyle.fs16.wBold.reColorText.style(context),
                    )),
              ),
              GridColumn(
                columnName: 'Type',
                label: Container(
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Type',
                      style:
                          MyText.appStyle.fs16.wBold.reColorText.style(context),
                    )),
              ),
              GridColumn(
                columnName: 'Actions',
                label: Container(
                    color: AppColors.white,
                    alignment: Alignment.center,
                    child: Text(
                      'Actions',
                      style:
                          MyText.appStyle.fs16.wBold.reColorText.style(context),
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
              delegate: _productsDataSource,
              pageCount:
                  (widget.products.length / _productsDataSource.rowsPerPage)
                      .ceilToDouble(),
              onPageNavigationStart: (pageIndex) {
                final startIndex = pageIndex * _productsDataSource.rowsPerPage;
                _productsDataSource.buildPaginatedData(startIndex: startIndex);
              },
            ),
          ],
        ),
      ],
    );
  }
}

Widget buildActions(ProductModel product) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CustomIconSvg(path: Assets.imagesSvgEdit, size: 20),
      const SizedBox(
        width: 8,
      ),
      CustomIconSvg(path: Assets.imagesSvgDelete, size: 20),
      const SizedBox(
        width: 8,
      ),
      CustomIconSvg(path: Assets.imagesSvgDownload, size: 20),
      const SizedBox(
        width: 8,
      ),
      CustomIconSvg(path: Assets.imagesSvgEye, size: 16),
      const SizedBox(
        width: 8,
      ),
      CustomIconSvg(path: Assets.imagesSvgMenuCircleVertical, size: 20),
    ],
  );
}
