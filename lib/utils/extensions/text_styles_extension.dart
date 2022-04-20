import 'dart:ui';

import 'package:khoaluan_mobile_app/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension TextStyleExtension on TextStyle {
  // Weights
  TextStyle get thin => weight(FontWeight.w100);

  TextStyle get extraLight => weight(FontWeight.w200);

  TextStyle get light => weight(FontWeight.w300);

  TextStyle get regular => weight(FontWeight.normal);

  TextStyle get medium => weight(FontWeight.w500);

  TextStyle get semiBold => weight(FontWeight.w600);

  TextStyle get bold => weight(FontWeight.w700);

  TextStyle get extraBold => weight(FontWeight.w800);

  TextStyle get black => weight(FontWeight.w900);

  TextStyle get w100 => weight(FontWeight.w100);

  TextStyle get w200 => weight(FontWeight.w200);

  TextStyle get w300 => weight(FontWeight.w300);

  TextStyle get w400 => weight(FontWeight.normal);

  TextStyle get w500 => weight(FontWeight.w500);

  TextStyle get w600 => weight(FontWeight.w600);

  TextStyle get w700 => weight(FontWeight.w700);

  TextStyle get w800 => weight(FontWeight.w800);

  TextStyle get w900 => weight(FontWeight.w900);

  TextStyle get size8 => size(8);

  TextStyle get size10 => size(10);

  TextStyle get size11 => size(11);

  TextStyle get size12 => size(12);

  TextStyle get size14 => size(14);

  TextStyle get size16 => size(16);

  TextStyle get size18 => size(18);

  TextStyle get size20 => size(20);

  TextStyle get size22 => size(22);

  TextStyle get italic => style(FontStyle.italic);

  TextStyle get underline => textDecoration(TextDecoration.underline);

  TextStyle get lineThrough => textDecoration(TextDecoration.lineThrough);

  TextStyle get overline => textDecoration(TextDecoration.overline);

  TextStyle textColor(Color v) => copyWith(color: v);

  TextStyle textBackgroundColor(Color v) => copyWith(backgroundColor: v);

  TextStyle size(double v) => copyWith(fontSize: v);

  TextStyle get fontRoboto => copyWith(fontFamily: AppStyles.Roboto);

  TextStyle get fontRobotoSlab => copyWith(fontFamily: AppStyles.RobotoSlab);

  TextStyle scale(double v) => copyWith(fontSize: fontSize! * v);

  TextStyle weight(FontWeight v) => copyWith(fontWeight: v);

  TextStyle style(FontStyle v) => copyWith(fontStyle: v);

  TextStyle letterSpace(double v) => copyWith(letterSpacing: v);

  TextStyle wordSpace(double v) => copyWith(wordSpacing: v);

  TextStyle baseline(TextBaseline v) => copyWith(textBaseline: v);

  TextStyle textHeight(double v) => copyWith(height: v);

  TextStyle textLocale(Locale v) => copyWith(locale: v);

  TextStyle textForeground(Paint v) => copyWith(foreground: v);

  TextStyle textBackground(Paint v) => copyWith(background: v);

  TextStyle textShadows(List<Shadow> v) => copyWith(shadows: v);

  TextStyle textFeatures(List<FontFeature> v) => copyWith(fontFeatures: v);

  TextStyle textDecoration(TextDecoration v,
          {Color? color, TextDecorationStyle? style, double? thickness}) =>
      copyWith(
          decoration: v,
          decorationColor: color,
          decorationStyle: style,
          decorationThickness: thickness);
}
