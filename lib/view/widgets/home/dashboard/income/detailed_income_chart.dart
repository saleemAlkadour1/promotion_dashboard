import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';

class DetailedIncomeChart extends StatefulWidget {
  const DetailedIncomeChart({super.key});

  @override
  State<DetailedIncomeChart> createState() => _DetailedIncomeChartState();
}

class _DetailedIncomeChartState extends State<DetailedIncomeChart> {
  int activeIndex = -1;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        getChartData(),
      ),
    );
  }

  PieChartData getChartData() {
    return PieChartData(
      pieTouchData: PieTouchData(
        enabled: true,
        touchCallback: (flTouchEvent, pieTouchResponse) {
          activeIndex =
              pieTouchResponse?.touchedSection?.touchedSectionIndex ?? -1;
          setState(() {});
        },
      ),
      sections: [
        PieChartSectionData(
          titlePositionPercentageOffset: activeIndex == 0 ? 1.5 : null,
          title: activeIndex == 0 ? 'Design service' : '40%',
          titleStyle: MyText.appStyle.fs16.wMedium
              .reCustomColor(
                  activeIndex == 0 ? AppColors.color_064061 : AppColors.white)
              .responsiveStyle(context),
          value: 40,
          radius: activeIndex == 0 ? 60 : 50,
          color: AppColors.color_208CC8,
        ),
        PieChartSectionData(
          titlePositionPercentageOffset: activeIndex == 1 ? 2.3 : null,
          title: activeIndex == 1 ? 'Design product' : '25%',
          titleStyle: MyText.appStyle.fs16.wMedium
              .reCustomColor(
                  activeIndex == 1 ? AppColors.color_064061 : AppColors.white)
              .responsiveStyle(context),
          value: 25,
          radius: activeIndex == 1 ? 60 : 50,
          color: AppColors.color_4EB7F2,
        ),
        PieChartSectionData(
          titlePositionPercentageOffset: activeIndex == 2 ? 1.4 : null,
          title: activeIndex == 2 ? 'Product royalti' : '20%',
          titleStyle: MyText.appStyle.fs16.wMedium
              .reCustomColor(
                  activeIndex == 2 ? AppColors.color_064061 : AppColors.white)
              .responsiveStyle(context),
          value: 20,
          radius: activeIndex == 2 ? 60 : 50,
          color: AppColors.color_064061,
        ),
        PieChartSectionData(
          titlePositionPercentageOffset: activeIndex == 3 ? 1.5 : null,
          title: activeIndex == 3 ? 'Other' : '22%',
          titleStyle: MyText.appStyle.fs16.wMedium
              .reCustomColor(
                  activeIndex == 3 ? AppColors.color_064061 : AppColors.white)
              .responsiveStyle(context),
          value: 22,
          radius: activeIndex == 3 ? 60 : 50,
          color: AppColors.color_E2DECD,
        ),
      ],
      sectionsSpace: 0,
    );
  }
}
