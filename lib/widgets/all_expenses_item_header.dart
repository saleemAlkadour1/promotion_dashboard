// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';

class AllExpensesItemHeader extends StatelessWidget {
  const AllExpensesItemHeader({
    super.key,
    required this.imagePath,
    this.color,
    this.imageBackgroundColor,
  });
  final String imagePath;
  final Color? color;
  final Color? imageBackgroundColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: ShapeDecoration(
            color: imageBackgroundColor ?? AppColors.color_FAFAFA,
            shape: OvalBorder(),
          ),
          child: Center(
            child: SvgPicture.asset(
              imagePath,
              colorFilter: ColorFilter.mode(
                  color ?? AppColors.color_4EB7F2, BlendMode.srcIn),
            ),
          ),
        ),
        Spacer(),
        Transform.rotate(
            angle: 1.57079633 * 2,
            child: Icon(
              Icons.arrow_back_ios_outlined,
              color: color ?? AppColors.color_064061,
            ))
      ],
    );
  }
}
