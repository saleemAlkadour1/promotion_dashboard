import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_button.dart';

class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;
  final Function(Color) onColorSelected;

  const ColorPickerDialog({
    super.key,
    required this.initialColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    Color selectedColor = initialColor;
    TextEditingController colorController = TextEditingController(
      text: '0x${selectedColor.value.toRadixString(16).toUpperCase()}',
    );
    return AlertDialog(
      title: const Text(
        'Pick a Color',
      ),
      titleTextStyle:
          MyText.appStyle.fs16.wBold.reCustomColor(AppColors.black).style,
      content: SingleChildScrollView(
        child: Column(
          children: [
            ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
                colorController.text =
                    '0x${color.value.toRadixString(16).toUpperCase()}';
              },
              colorPickerWidth: 250,
              pickerAreaHeightPercent: 0.7,
              pickerAreaBorderRadius: BorderRadius.circular(16),
              hexInputBar: true,
              hexInputController: colorController,
              enableAlpha: false,
              displayThumbColor: true,
              portraitOnly: true,
            ),
          ],
        ),
      ),
      actions: [
        CustomButton(
          title: 'Cancel',
          height: 30,
          backgroundColor: AppColors.transparent,
          textColor: AppColors.color_4EB7F2,
          shadowColor: AppColors.transparent,
          onPressed: () {
            Get.back();
          },
        ),
        CustomButton(
          title: 'Select',
          height: 30,
          onPressed: () {
            onColorSelected(selectedColor);
            Get.back();
          },
        )
      ],
    );
  }
}
