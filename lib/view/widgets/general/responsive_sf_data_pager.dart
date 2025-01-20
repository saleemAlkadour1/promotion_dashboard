import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ResponsiveSfDataPager extends StatelessWidget {
  const ResponsiveSfDataPager({
    super.key,
    required this.dataSource,
    required this.total,
    required this.rowsPerPage,
    this.onPageNavigationStart,
    this.onPageNavigationEnd,
  });

  final DataGridSource dataSource;
  final int total;
  final int rowsPerPage;
  final void Function(int pageIndex)? onPageNavigationStart;
  final void Function(int pageIndex)? onPageNavigationEnd;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.sizeOf(context).width;

        if (screenWidth < 600) {
          return SfDataPagerTheme(
            data: SfDataPagerThemeData(
              selectedItemColor: AppColors.color_4EB7F2,
              itemBorderRadius: BorderRadius.circular(5),
            ),
            child: SfDataPager(
              itemHeight: 40,
              itemWidth: 40,
              navigationItemHeight: 40,
              navigationItemWidth: 40,
              visibleItemsCount: 1,
              delegate: dataSource,
              pageCount: calculatePageCount(),
              onPageNavigationStart: onPageNavigationStart,
              onPageNavigationEnd: onPageNavigationEnd,
            ),
          );
        } else if (screenWidth < 1000) {
          return SfDataPagerTheme(
            data: SfDataPagerThemeData(
              selectedItemColor: AppColors.color_4EB7F2,
              itemBorderRadius: BorderRadius.circular(5),
            ),
            child: SfDataPager(
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
          );
        } else {
          // إعدادات الشاشات الكبيرة
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SfDataPagerTheme(
                data: SfDataPagerThemeData(
                  selectedItemColor: AppColors.color_4EB7F2,
                  itemBorderRadius: BorderRadius.circular(5),
                ),
                child: SfDataPager(
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
              ),
            ],
          );
        }
      },
    );
  }

  double calculatePageCount() {
    return (total / rowsPerPage).ceilToDouble();
  }
}
