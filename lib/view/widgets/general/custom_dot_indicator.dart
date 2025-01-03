import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';

class CustomDotIndicator extends StatelessWidget {
  const CustomDotIndicator({super.key, required this.isActve});

  final bool isActve;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isActve == true ? 32 : 8,
      height: 8,
      decoration: ShapeDecoration(
        color:
            isActve == true ? AppColors.color_4EB7F2 : AppColors.color_E7E7E7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
