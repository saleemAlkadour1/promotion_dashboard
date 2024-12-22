import 'package:flutter/material.dart';

enum FontWeightEnum {
  thin('thin', FontWeight.w100),
  thinItalic('thin-italic', FontWeight.w100),
  extraLight('extra-light', FontWeight.w200),
  extraLightItalic('extra-light-italic', FontWeight.w200),
  light('light', FontWeight.w300),
  lightItalic('light-italic', FontWeight.w300),
  regular('regular', FontWeight.w400),
  regularItalic('regular-italic', FontWeight.w400),
  medium('medium', FontWeight.w500),
  mediumItalic('medium-italic', FontWeight.w500),
  semiBold('semi-bold', FontWeight.w600),
  semiBoldItalic('semi-bold-italic', FontWeight.w600),
  bold('bold', FontWeight.w700),
  boldItalic('bold-italic', FontWeight.w700),
  extraBold('extra-bold', FontWeight.w800),
  extraBoldItalic('extra-bold-italic', FontWeight.w800),
  black('black', FontWeight.w900),
  blackItalic('black-italic', FontWeight.w900),
  ;

  final String key;
  final FontWeight weight;

  static const FontWeightEnum defaultWeight = regular;

  const FontWeightEnum(this.key, this.weight);

  factory FontWeightEnum.normal() => regular;
}
