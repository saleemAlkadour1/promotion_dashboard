import 'package:flutter/material.dart';
import 'package:get/get.dart';

customSnackBar(
  String text,
  String message, {
  SnackBarType snackType = SnackBarType.correct,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
}) {
  if (text.isEmpty) return;
  // Close any open SnackBars
  Get.closeAllSnackbars();

  // Define snackbar color and icon
  late Color snackbarColor;
  late Widget icon;

  switch (snackType) {
    case SnackBarType.correct:
      snackbarColor = const Color(0xFF67C17F);
      icon = const Icon(
        Icons.check_circle_rounded,
        color: Colors.white,
        size: 24,
      );
      break;

    case SnackBarType.info:
      snackbarColor = Colors.green;
      icon = const Icon(
        Icons.info_sharp,
        color: Colors.white,
        size: 24,
      );
      break;

    case SnackBarType.error:
      snackbarColor = const Color(0xFFE82832);
      icon = Container(
        width: 21,
        height: 21,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close,
          color: snackbarColor,
          size: 17,
        ),
      );
      break;
  }

  // Show Snackbar
  Get.snackbar(
    '',
    '',
    titleText: Row(
      children: [
        icon,
        const SizedBox(width: 12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
    snackPosition: snackPosition,
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    padding: const EdgeInsets.all(12),
    backgroundColor: snackbarColor,
    colorText: Colors.white,
    messageText: const SizedBox(),
    dismissDirection: DismissDirection.horizontal,
    duration: const Duration(seconds: 3),
    borderRadius: 8,
  );
}

enum SnackBarType { correct, info, error }
