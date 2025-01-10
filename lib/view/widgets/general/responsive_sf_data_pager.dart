import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ResponsiveSfDataPager extends StatelessWidget {
  const ResponsiveSfDataPager({
    super.key,
    required this.dataSource,
    required this.length,
    required this.rowsPerPage,
    required this.buildPaginatedData,
  });

  final DataGridSource dataSource;
  final int length;
  final int rowsPerPage;
  final void Function(int startIndex) buildPaginatedData;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;

        if (screenWidth < 600) {
          // إعدادات الشاشات الصغيرة
          return SfDataPager(
            itemPadding: EdgeInsets.zero,
            itemHeight: 40,
            itemWidth: 40,
            navigationItemHeight: 40,
            navigationItemWidth: 40,
            visibleItemsCount: 1,
            delegate: dataSource,
            initialPageIndex: 1,
            pageCount: _calculatePageCount(),
            onPageNavigationStart: buildPaginatedData,
          );
        } else if (screenWidth < 1000) {
          // إعدادات الشاشات المتوسطة
          return SfDataPager(
            itemPadding: EdgeInsets.zero,
            itemHeight: 50,
            itemWidth: 50,
            navigationItemHeight: 50,
            navigationItemWidth: 50,
            visibleItemsCount: 5,
            delegate: dataSource,
            initialPageIndex: 1,
            pageCount: _calculatePageCount(),
            onPageNavigationStart: buildPaginatedData,
          );
        } else {
          // إعدادات الشاشات الكبيرة
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SfDataPager(
                itemPadding: EdgeInsets.zero,
                itemHeight: 50,
                itemWidth: 50,
                navigationItemHeight: 50,
                navigationItemWidth: 50,
                visibleItemsCount: 5,
                delegate: dataSource,
                initialPageIndex: 1,
                pageCount: _calculatePageCount(),
                onPageNavigationStart: buildPaginatedData,
              ),
            ],
          );
        }
      },
    );
  }

  // حساب عدد الصفحات
  double _calculatePageCount() {
    return length < rowsPerPage ? 1 : (length / rowsPerPage).ceilToDouble();
  }
}
