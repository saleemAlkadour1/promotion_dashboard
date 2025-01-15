import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:promotion_dashboard/core/functions/size.dart';

class CustomIcon extends StatelessWidget {
  final String? path;
  final double size;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  final MouseCursor? cursor;
  final bool? isSvg;
  final IconData? icon;
  const CustomIcon({
    super.key,
    this.path,
    required this.size,
    this.onTap,
    this.color,
    this.padding,
    this.cursor,
    this.isSvg = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: cursor ??
            (onTap != null ? SystemMouseCursors.click : MouseCursor.defer),
        child: Container(
          padding: padding,
          child: isSvg == true
              ? SvgPicture.asset(
                  path!,
                  width: width(size),
                  height: height(size),
                  // ignore: deprecated_member_use
                  color: color,
                )
              : Icon(
                  icon,
                  size: size,
                  color: color,
                ),
        ),
      ),
    );
  }
}
