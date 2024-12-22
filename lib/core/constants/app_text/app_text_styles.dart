// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:promotion_dashboard/core/constants/app_text/text_colors.dart';
import 'package:promotion_dashboard/core/constants/app_text/font_weight_enum.dart';

const TextStyle _baseStyle = TextStyle(
  fontFamily: MyText._fontFamily,
  fontWeight: FontWeight.w400,
  fontSize: 16,
  color: TextColors.text,
  height: 1,
  backgroundColor: null,
);

class MyText {
  static const String _fontFamily = 'Montserrat';
  static const double _bodyFontSize = 16;
  final TextStyle _style;

  TextStyle style(BuildContext context) => _style.copyWith(
        fontSize: getResponsiveFontSize(
          context,
          fontSize: (_style.fontSize ?? _bodyFontSize),
        ),
      );
  // TextStyle get style =>
  //     _style.copyWith(fontSize: getResponsiveFontSize(context, fontSize: (_style.fontSize ?? _bodyFontSize)));

  static String get fontFamily => _fontFamily;

  const MyText._(this._style);

  //region Text size variations ( Typography ). //Not used here
  // static MyText h1 = const MyText._(_baseStyle).wBold.xxxxl;
  // static MyText h2 = const MyText._(_baseStyle).wBold.xxl;
  // static MyText h3 = const MyText._(_baseStyle).wSemiBold.xl;
  // static MyText h4 = const MyText._(_baseStyle).wBold.ll;
  // static MyText h5 = const MyText._(_baseStyle).wSemiBold.l;
  // static MyText h6 = const MyText._(_baseStyle).wSemiBold.m;
  // static MyText body = const MyText._(_baseStyle).wLight.m;
  // static MyText subtitle = const MyText._(_baseStyle).wRegular.xs;
  // static MyText btn = const MyText._(_baseStyle).wBold.m;
  // static MyText textBtn = const MyText._(_baseStyle).wBold.xs;
  static MyText appStyle = const MyText._(_baseStyle); //This is Used

//region Spacing variations

  //Application Defentions
  MyText get fs30 => MyText._(_style.copyWith(fontSize: 30));
  MyText get fs29 => MyText._(_style.copyWith(fontSize: 29));
  MyText get fs28 => MyText._(_style.copyWith(fontSize: 28));
  MyText get fs27 => MyText._(_style.copyWith(fontSize: 27));
  MyText get fs26 => MyText._(_style.copyWith(fontSize: 26));
  MyText get fs25 => MyText._(_style.copyWith(fontSize: 25));
  MyText get fs24 => MyText._(_style.copyWith(fontSize: 24));
  MyText get fs23 => MyText._(_style.copyWith(fontSize: 23));
  MyText get fs22 => MyText._(_style.copyWith(fontSize: 22));
  MyText get fs21 => MyText._(_style.copyWith(fontSize: 21));
  MyText get fs20 => MyText._(_style.copyWith(fontSize: 20));
  MyText get fs19 => MyText._(_style.copyWith(fontSize: 19));
  MyText get fs18 => MyText._(_style.copyWith(fontSize: 18));
  MyText get fs17 => MyText._(_style.copyWith(fontSize: 17));
  MyText get fs16 => MyText._(_style.copyWith(fontSize: 16));
  MyText get fs15 => MyText._(_style.copyWith(fontSize: 15));
  MyText get fs14 => MyText._(_style.copyWith(fontSize: 14));
  MyText get fs13 => MyText._(_style.copyWith(fontSize: 13));
  MyText get fs12 => MyText._(_style.copyWith(fontSize: 12));
  MyText get fs11 => MyText._(_style.copyWith(fontSize: 11));
  MyText get fs10 => MyText._(_style.copyWith(fontSize: 10));
  MyText get fs9 => MyText._(_style.copyWith(fontSize: 9));
  MyText get fs8 => MyText._(_style.copyWith(fontSize: 8));
  MyText get fs7 => MyText._(_style.copyWith(fontSize: 7));
  MyText get fs6 => MyText._(_style.copyWith(fontSize: 6));
  MyText get fs5 => MyText._(_style.copyWith(fontSize: 5));
  MyText get fs4 => MyText._(_style.copyWith(fontSize: 4));
  MyText get fs3 => MyText._(_style.copyWith(fontSize: 3));
  MyText get fs2 => MyText._(_style.copyWith(fontSize: 2));
  MyText get fs1 => MyText._(_style.copyWith(fontSize: 1));
  //Custom font size
  MyText customSize(num value) =>
      MyText._(_style.copyWith(fontSize: value.toDouble()));

  //region Font weight variations
  MyText get wThin =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.thin.weight));

  MyText get wThinItalic =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.thinItalic.weight));

  MyText get wExtraLight =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.extraLight.weight));

  MyText get wExtraLightItalic => MyText._(
      _style.copyWith(fontWeight: FontWeightEnum.extraLightItalic.weight));

  MyText get wLight =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.light.weight));

  MyText get wLightItalic =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.lightItalic.weight));

  MyText get wRegular =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.regular.weight));

  MyText get wRegularItalic => MyText._(
      _style.copyWith(fontWeight: FontWeightEnum.regularItalic.weight));

  MyText get wMedium =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.medium.weight));

  MyText get wMediumItalic =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.mediumItalic.weight));

  MyText get wSemiBold =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.semiBold.weight));

  MyText get wSemiBoldItalic => MyText._(
      _style.copyWith(fontWeight: FontWeightEnum.semiBoldItalic.weight));

  MyText get wBold =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.bold.weight));

  MyText get wBoldItalic =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.boldItalic.weight));

  MyText get wExtraBold =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.extraBold.weight));

  MyText get wExtraBoldItalic => MyText._(
      _style.copyWith(fontWeight: FontWeightEnum.extraBoldItalic.weight));

  MyText get wBlack =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.black.weight));

  MyText get wBlackItalic =>
      MyText._(_style.copyWith(fontWeight: FontWeightEnum.blackItalic.weight));

  //region App colors

  //Application defenations

  MyText get reColorText => MyText._(_style.copyWith(color: TextColors.text));
  MyText get reColorWhite => MyText._(_style.copyWith(color: TextColors.white));
  MyText get reColorLightGray =>
      MyText._(_style.copyWith(color: TextColors.lightGray));
  MyText get reColor_208CC8 =>
      MyText._(_style.copyWith(color: TextColors.color_208CC8));
  MyText get reColor_4EB7F2 =>
      MyText._(_style.copyWith(color: TextColors.color_4EB7F2));
  MyText get reColor_7DD97B =>
      MyText._(_style.copyWith(color: TextColors.color_7DD97B));
  MyText get reColor_FAFAFA =>
      MyText._(_style.copyWith(color: TextColors.color_FAFAFA));
  MyText get reColor_F3735E =>
      MyText._(_style.copyWith(color: TextColors.color_F3735E));

//Custom color
  MyText reCustomColor(Color color) => MyText._(_style.copyWith(color: color));
  MyText reColorIf(bool condition, Color color) =>
      MyText._(_style.copyWith(color: condition ? color : null));

//endregion

  //Opacity
  MyText withOpacity(double opacityValue) {
    return MyText._(
      _style.copyWith(
        color: _style.color!.withOpacity(opacityValue),
      ),
    );
  }

  MyText customLetterSpacing(num value) =>
      MyText._(_style.copyWith(letterSpacing: value.toDouble()));

  MyText customHeight(num value) =>
      MyText._(_style.copyWith(height: value.toDouble()));
}

//Function to responsive font size according platform
double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;
  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;
  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}
