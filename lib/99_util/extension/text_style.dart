import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

extension TETextStyleExtension on TextStyle {
  TextStyle get h11 => copyWith(height: 1.1);
  TextStyle get h12 => copyWith(height: 1.2);
  TextStyle get h13 => copyWith(height: 1.3);
  TextStyle get h14 => copyWith(height: 1.4);
  TextStyle get h15 => copyWith(height: 1.5);
  TextStyle get h16 => copyWith(height: 1.6);
  TextStyle get h17 => copyWith(height: 1.7);
  TextStyle get h18 => copyWith(height: 1.8);
  TextStyle get h19 => copyWith(height: 1.9);
  TextStyle get h20 => copyWith(height: 2.0);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get point => copyWith(color: DS.color.point500);

  TextStyle get p500 => copyWith(color: DS.color.primary500);

  TextStyle get p600 => copyWith(color: DS.color.primary600);

  TextStyle get s500 => copyWith(color: DS.color.secondary500);

  TextStyle get s700 => copyWith(color: DS.color.secondary700);

  TextStyle get s900 => copyWith(color: DS.color.secondary900);

  TextStyle get b000 => copyWith(color: DS.color.background000);

  TextStyle get b100 => copyWith(color: DS.color.background100);

  TextStyle get b200 => copyWith(color: DS.color.background200);

  TextStyle get b300 => copyWith(color: DS.color.background300);

  TextStyle get b400 => copyWith(color: DS.color.background400);

  TextStyle get b500 => copyWith(color: DS.color.background500);

  TextStyle get b600 => copyWith(color: DS.color.background600);

  TextStyle get b700 => copyWith(color: DS.color.background700);

  TextStyle get b800 => copyWith(color: DS.color.background800);
}
