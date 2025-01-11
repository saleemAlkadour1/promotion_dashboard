import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackBarType { correct, info, warning, error }

enum SnackBarPosition { topStart, topEnd, bottomStart, bottomEnd }

enum SnackBarAnimationDirection {
  leftToRight,
  rightToLeft,
  topToBottom,
  bottomToTop
}

void customSnackBar(
  String title,
  String message, {
  SnackBarType snackType = SnackBarType.correct,
  SnackBarPosition snackPosition = SnackBarPosition.topEnd,
  SnackBarAnimationDirection animationDirection =
      SnackBarAnimationDirection.leftToRight,
  bool shouldReverseAnimationOnLocaleChange = true,
  bool shouldReservePositionOnLocaleChange = true,
  Duration duration = const Duration(seconds: 3),
}) {
  if (title.isEmpty) return;

  // إغلاق أي إشعارات مفتوحة
  Get.closeAllSnackbars();

  // عرض الإشعار المخصص
  Get.dialog(
    _SnackBarDialog(
      title: title,
      message: message,
      snackType: snackType,
      snackPosition: snackPosition,
      animationDirection: animationDirection,
      shouldReverseOnLocaleChange: shouldReverseAnimationOnLocaleChange,
      shouldPreservePositionOnLocaleChange:
          !shouldReservePositionOnLocaleChange,
      duration: duration,
    ),
    barrierDismissible: true,
    barrierColor: Colors.transparent,
  );
}

class _SnackBarDialog extends StatefulWidget {
  final String title;
  final String message;
  final SnackBarType snackType;
  final SnackBarPosition snackPosition;
  final SnackBarAnimationDirection animationDirection;
  final bool shouldReverseOnLocaleChange;
  final bool shouldPreservePositionOnLocaleChange;
  final Duration duration;

  const _SnackBarDialog({
    required this.title,
    required this.message,
    required this.snackType,
    required this.snackPosition,
    required this.animationDirection,
    required this.shouldReverseOnLocaleChange,
    required this.shouldPreservePositionOnLocaleChange,
    required this.duration,
    Key? key,
  }) : super(key: key);

  @override
  _SnackBarDialogState createState() => _SnackBarDialogState();
}

class _SnackBarDialogState extends State<_SnackBarDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Color snackbarColor;
  late Widget icon;

  @override
  void initState() {
    super.initState();

    // تحديد لون الإشعار والأيقونة بناءً على النوع
    switch (widget.snackType) {
      case SnackBarType.correct:
        snackbarColor = const Color(0xFF67C17F);
        icon = const Icon(
          Icons.check_circle_rounded,
          color: Colors.white,
          size: 24,
        );
        break;

      case SnackBarType.info:
        snackbarColor = Colors.blueAccent;
        icon = const Icon(
          Icons.info_rounded,
          color: Colors.white,
          size: 24,
        );
        break;

      case SnackBarType.warning:
        snackbarColor = Colors.orange;
        icon = const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 24,
        );
        break;
      case SnackBarType.error:
        snackbarColor = const Color(0xFFE82832);
        icon = const Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 24,
        );
        break;
    }

    // إعداد المتحكم بالأنيميشن
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // إعداد حركة الأنيميشن بناءً على الاتجاه واللغة
    final isRTL =
        Get.locale?.languageCode == 'ar' || Get.locale?.languageCode == 'he';

    _offsetAnimation = Tween<Offset>(
      begin: _getBeginOffset(
          widget.animationDirection, isRTL, widget.shouldReverseOnLocaleChange),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    // إغلاق الإشعار تلقائيًا بعد الفترة المحددة
    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => Get.back());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // تحديد إذا كانت اللغة RTL
    final isRTL =
        Get.locale?.languageCode == 'ar' || Get.locale?.languageCode == 'he';
    final alignment = _getAlignment(widget.snackPosition, isRTL);

    return Align(
      alignment: alignment,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: snackbarColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxWidth: 320),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      if (widget.message.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            widget.message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Offset _getBeginOffset(
      SnackBarAnimationDirection direction, bool isRTL, bool shouldReverse) {
    if (!shouldReverse) {
      // إذا لم تكن هناك رغبة بعكس الاتجاه بناءً على اللغة
      switch (direction) {
        case SnackBarAnimationDirection.leftToRight:
          return const Offset(-1, 0);
        case SnackBarAnimationDirection.rightToLeft:
          return const Offset(1, 0);
        case SnackBarAnimationDirection.topToBottom:
          return const Offset(0, -1);
        case SnackBarAnimationDirection.bottomToTop:
          return const Offset(0, 1);
      }
    }

    // إذا كان هناك رغبة بعكس الاتجاه بناءً على اللغة
    switch (direction) {
      case SnackBarAnimationDirection.leftToRight:
        return isRTL ? const Offset(-1, 0) : const Offset(1, 0);
      case SnackBarAnimationDirection.rightToLeft:
        return isRTL ? const Offset(1, 0) : const Offset(-1, 0);
      case SnackBarAnimationDirection.topToBottom:
        return const Offset(0, -1);
      case SnackBarAnimationDirection.bottomToTop:
        return const Offset(0, 1);
    }
  }

  Alignment _getAlignment(SnackBarPosition position, bool isRTL) {
    if (widget.shouldPreservePositionOnLocaleChange) {
      // حافظ على الموقع كما هو
      switch (position) {
        case SnackBarPosition.topStart:
          return Alignment.topLeft;
        case SnackBarPosition.topEnd:
          return Alignment.topRight;
        case SnackBarPosition.bottomStart:
          return Alignment.bottomLeft;
        case SnackBarPosition.bottomEnd:
          return Alignment.bottomRight;
      }
    }

    // عكس الموقع بناءً على اللغة
    switch (position) {
      case SnackBarPosition.topStart:
        return isRTL ? Alignment.topRight : Alignment.topLeft;
      case SnackBarPosition.topEnd:
        return isRTL ? Alignment.topLeft : Alignment.topRight;
      case SnackBarPosition.bottomStart:
        return isRTL ? Alignment.bottomRight : Alignment.bottomLeft;
      case SnackBarPosition.bottomEnd:
        return isRTL ? Alignment.bottomLeft : Alignment.bottomRight;
    }
  }
}
