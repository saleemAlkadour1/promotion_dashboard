import 'package:flutter/material.dart';

abstract class AppColors {
  //Application definitions
  static const Color primary = Color(0xFF02BED3);
  static const Color secondry = Color(0xFF24414B);
  static const Color transparent = Colors.transparent;
  static const Color customBackground = Color(0XFFDFFEFE);
  static Color third = const Color(0xFF00749F);
  static const Color white = Color(0xffffffff);
  static Color black = const Color(0xFF000000);
  static Color grey = const Color(0xFF707070);
  static Color grey2 = const Color(0xFF707070);
  static Color lightGrey = const Color(0xFFCECECE);
  static const Color rating = Color(0xFFF3D000);
  static const Color red = Colors.red;
  static const Color text = Color(
      0xFF24414B); //This color is secondry color in the app and it is main
  static const Color lightText = Color(0xFF8D8D8D);
  static const Color xLightText = Color(0xFFA9A9A9);
  static const Color notoficationSignal = Color(0xFF00E76C);
  static const Color increase = Color(0xFF1AD598);
  static const Color decrease = Color(0xFFEA3A3D);
  static const Color green = Color(0xFF0DD106);
  static const Color customGreen = Color(0xFF1AD598);
  static const Color specialOffer = Color(0xFF9A51E0);
  static const Color blue = Colors.blue;

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
