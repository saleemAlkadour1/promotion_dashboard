import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ResponsiveSfDataPager extends StatelessWidget {
  const ResponsiveSfDataPager({
    super.key,
    required this.dataSource,
    required this.length,
    required this.rowsPerPage,
    required this.onPageNavigationStart,
    required this.onPageNavigationEnd,
  });

  final DataGridSource dataSource;
  final int length;
  final int rowsPerPage;
  final void Function(int pageIndex) onPageNavigationStart;
  final void Function(int pageIndex) onPageNavigationEnd;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;

        if (screenWidth < 600) {
          return SfDataPager(
            itemPadding: EdgeInsets.zero,
            itemHeight: 40,
            itemWidth: 40,
            navigationItemHeight: 40,
            navigationItemWidth: 40,
            visibleItemsCount: 1,
            delegate: dataSource,
            pageCount: calculatePageCount(),
            onPageNavigationStart: onPageNavigationStart,
            onPageNavigationEnd: onPageNavigationEnd,
          );
        } else if (screenWidth < 1000) {
          return SfDataPager(
            itemPadding: EdgeInsets.zero,
            itemHeight: 50,
            itemWidth: 50,
            navigationItemHeight: 50,
            navigationItemWidth: 50,
            visibleItemsCount: 5,
            delegate: dataSource,
            pageCount: calculatePageCount(),
            onPageNavigationStart: onPageNavigationStart,
            onPageNavigationEnd: onPageNavigationEnd,
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
                pageCount: calculatePageCount(),
                onPageNavigationStart: onPageNavigationStart,
                onPageNavigationEnd: onPageNavigationEnd,
              ),
            ],
          );
        }
      },
    );
  }

  double calculatePageCount() {
    return (length / rowsPerPage).ceilToDouble();
  }
}


// length < rowsPerPage ? 1 : 