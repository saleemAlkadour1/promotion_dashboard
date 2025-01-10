import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/app_text_styles.dart';
import 'package:promotion_dashboard/core/constants/assets.dart';
import 'package:promotion_dashboard/view/widgets/general/custom_icon_svg.dart';

class LoginTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final String? hintText;
  final bool? isPassword;
  final Color? fillColor;
  final String? data;
  final bool readOnly;
  final TextEditingController controller;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final bool? isSeen;
  final void Function()? onTapEye;

  const LoginTextField({
    super.key,
    this.prefixIcon,
    this.hintText,
    this.isPassword = false,
    this.fillColor,
    this.readOnly = false,
    this.data,
    required this.controller,
    this.hintStyle,
    this.validator,
    this.isSeen = false,
    this.onTapEye,
  });

  @override
  Widget build(BuildContext context) {
    bool isSeen = false;

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
        obscureText: isPassword ??
            false, // You need to handle it through state management and I don't prefer to use StatefullWidget in the presence of Get.
        decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? const Color(0xFFF5F5F5),
            prefixIcon: prefixIcon,
            hintText: hintText,
            hintStyle: hintStyle ??
                MyText.appStyle.fs13.wMedium.reColorLightGray.style,
            hintMaxLines: 1,
            suffix: isPassword == false
                ? null
                : GestureDetector(
                    onTap: onTapEye,
                    child: isSeen == true
                        ? const CustomIconSvg(
                            path: Assets.imagesSvgAccounts,
                            size: 12,
                          )
                        : const CustomIconSvg(
                            path: Assets.imagesSvgClosedEye,
                            size: 12,
                          ),
                  ),
            border: customBorder(),
            enabledBorder: customBorder(),
            disabledBorder: customBorder(),
            focusedBorder: customBorder()),
      ),
    );
  }

  OutlineInputBorder customBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          8,
        ),
        borderSide: const BorderSide(color: AppColors.color_064061));
  }
}
