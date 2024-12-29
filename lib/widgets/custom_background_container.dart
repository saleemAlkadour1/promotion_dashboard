import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';

class CustomBackgroundContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  const CustomBackgroundContainer({
    super.key,
    this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: padding ?? const EdgeInsets.all(20),
        child: child);
  }
}
