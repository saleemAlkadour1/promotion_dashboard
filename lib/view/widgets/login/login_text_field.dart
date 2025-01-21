import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_icon.dart';

class LoginTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final String? hintText;
  final bool isPassword;
  final Color? fillColor;
  final bool readOnly;
  final TextEditingController controller;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final bool isSeen;
  final void Function()? onTapEye;

  const LoginTextField({
    super.key,
    this.prefixIcon,
    this.hintText,
    this.isPassword = false,
    this.fillColor,
    this.readOnly = false,
    required this.controller,
    this.hintStyle,
    this.validator,
    required this.isSeen,
    this.onTapEye,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TextFormField(
        textDirection: TextDirection.ltr,
        validator: validator,
        controller: controller,
        readOnly: readOnly,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        obscureText: isPassword ? !isSeen : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? const Color(0xFFF5F5F5),
          prefixIcon: prefixIcon,
          hintText: hintText,
          hintStyle:
              hintStyle ?? MyText.appStyle.fs13.wMedium.reColorLightGray.style,
          hintMaxLines: 1,
          suffix: isPassword
              ? MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onTapEye,
                    child: CustomIcon(
                      path: isSeen
                          ? Assets.imagesSvgOpenedEye
                          : Assets.imagesSvgClosedEye,
                      size: 15,
                    ),
                  ),
                )
              : null,
          border: customBorder(),
          enabledBorder: customBorder(),
          disabledBorder: customBorder(),
          focusedBorder: customBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder customBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.color_064061),
    );
  }
}
