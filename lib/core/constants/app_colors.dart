// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

abstract class AppColors {
  //Application definitions
  static const Color color_064061 = Color(0xFF064061); //Deep Teal
  static const Color white = Color(0xFFFFFFFF); //Pure White
  static const Color color_4EB7F2 = Color(0xFF4EB7F2); //Sky Blue
  static const Color color_FAFAFA = Color(0xFFFAFAFA); //Snow White
  static const Color color_AAAAAA = Color(0xFFAAAAAA); //Light Gray
  static const Color color_F1F1F1 = Color(0xFFF1F1F1); //Soft Gray
  static const Color color_292D32 = Color(0xFF292D32); //Charcoal Black
  static const Color color_F3735E = Color(0xFFF3735E); //Coral Orange
  static const Color color_208CC8 = Color(0xFF208CC8); //Ocean Blue
  static const Color color_98DAFF = Color(0xFF98DAFF); //Baby Blue
  static const Color color_45AFEA = Color(0xFF45AFEA); //Cerulean
  static const Color black = Color(0xFF000000); //Absolute Black
  static const Color color_E8E8E8 = Color(0xFFE8E8E8); //Whisper Gray
  static const Color color_7DD97B = Color(0xFF7DD97B); // Fresh Green
  static const Color color_E2DECD = Color(0xFFE2DECD); //Sand Beige
  static const Color color_F7F9FA = Color(0xFFF7F9FA); //Mist White
  static const Color color_C4C4C4 = Color(0xFFC4C4C4); //Neutral Gray
  static const Color transparent = Colors.transparent;

  static Color customColor(Color color) => color;

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final HSLColor hsl = HSLColor.fromColor(color);
    final HSLColor hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }

  // static const Gradient colorsPrimaryGradient = LinearGradient(
  //   colors: [primary, primaryLight],
  //   begin: AlignmentDirectional.topCenter,
  //   end: AlignmentDirectional.centerEnd,
  // );
}
