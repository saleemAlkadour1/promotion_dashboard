import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final Function(String) onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    item,
                    style: MyText.appStyle.fs16.wBlack.reColorText.style,
                  ),
                ),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: MyText.appStyle.fs16.wRegular.reColorText.style,
        border: buildBorder(),
        focusedBorder: buildBorder(),
      ),
      dropdownColor: Colors.white,
      focusColor: AppColors.transparent,
      iconEnabledColor: Colors.blue,
      iconDisabledColor: Colors.grey,
      icon: const Icon(
        Icons.arrow_drop_down,
        size: 30,
      ),
      style: MyText.appStyle.fs16.wBlack.reColorText.style,
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.blue,
        width: 2.0,
      ),
    );
  }
}
