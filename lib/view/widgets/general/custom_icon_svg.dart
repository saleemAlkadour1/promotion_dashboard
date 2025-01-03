import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:promotion_dashboard/core/functions/size.dart';

class CustomIconSvg extends StatelessWidget {
  final String path;
  final double size;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  const CustomIconSvg({
    super.key,
    required this.path,
    required this.size,
    this.onTap,
    this.color,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        child: SvgPicture.asset(
          path,
          width: width(size),
          height: height(size),
          // ignore: deprecated_member_use
          color: color,
        ),
      ),
    );
  }
}
