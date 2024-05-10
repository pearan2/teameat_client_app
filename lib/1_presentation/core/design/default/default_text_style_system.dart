// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teameat/1_presentation/core/design/i_text_style_system.dart';

class DefaultTextStyleSystem extends ITextStyleSystem {
  static TextStyle get defaultStyle => GoogleFonts.inter();

  /// title
  @override
  TextStyle get title1 =>
      defaultStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold);
  @override
  TextStyle get title2 =>
      defaultStyle.copyWith(fontSize: 22, fontWeight: FontWeight.bold);
  @override
  TextStyle get title3 =>
      defaultStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold);

  /// paragraph
  @override
  TextStyle get paragraph1 => defaultStyle.copyWith(fontSize: 18);
  @override
  TextStyle get paragraph2 => defaultStyle.copyWith(fontSize: 16);
  @override
  TextStyle get paragraph3 => defaultStyle.copyWith(fontSize: 14);

  /// caption
  @override
  TextStyle get caption1 => defaultStyle.copyWith(fontSize: 12);
  @override
  TextStyle get caption2 => defaultStyle.copyWith(fontSize: 10);
  @override
  TextStyle get caption3 => defaultStyle.copyWith(fontSize: 8);
}
