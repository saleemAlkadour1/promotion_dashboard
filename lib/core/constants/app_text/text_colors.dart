// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

abstract class TextColors {
  //Application definitions
  static const Color text = Color(0xFF064061);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFAAAAAA);
  static const Color color_208CC8 = Color(0xFF208CC8); //Ocean Blue
  static const Color color_4EB7F2 = Color(0xFF4EB7F2); //Sky Blue
  static const Color color_7DD97B = Color(0xFF7DD97B); //Fresh green
  static const Color color_FAFAFA = Color(0xFFFAFAFA); // Snow white
  static const Color color_F3735E = Color(0xFFF3735E); //Coral orange

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
