// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/i_text_style_system.dart';

// ios 의 경우 실제 디바이스에서 글씨크기가 조금더 작다. 따라서 배율로 올려준다.
final double scaleMultiplyFactor = GetPlatform.isAndroid ? 1 : 1.075;

class DefaultTextStyleSystem extends ITextStyleSystem {
  static TextStyle get defaultStyle => const TextStyle(
        fontFamily: 'Pretendard',
        height: 1,
        letterSpacing:
            -0.2, // figma 상의 세팅은 -2% 이지만 -0.2 까지 해야 거의 일치한다 (아니 .. 0.02 해야되는거 아냐?)
      );

  /// title
  @override
  TextStyle get title1 => defaultStyle.copyWith(
      fontSize: scaleMultiplyFactor * 24, fontWeight: FontWeight.bold);
  @override
  TextStyle get title2 => defaultStyle.copyWith(
      fontSize: scaleMultiplyFactor * 22, fontWeight: FontWeight.bold);
  @override
  TextStyle get title3 => defaultStyle.copyWith(
      fontSize: scaleMultiplyFactor * 20, fontWeight: FontWeight.bold);

  /// paragraph
  @override
  TextStyle get paragraph1 =>
      defaultStyle.copyWith(fontSize: scaleMultiplyFactor * 18);
  @override
  TextStyle get paragraph2 =>
      defaultStyle.copyWith(fontSize: scaleMultiplyFactor * 16);
  @override
  TextStyle get paragraph2Long =>
      defaultStyle.copyWith(fontSize: scaleMultiplyFactor * 16, height: 1.4);
  @override
  TextStyle get paragraph3 =>
      defaultStyle.copyWith(fontSize: scaleMultiplyFactor * 14);

  /// caption
  @override
  TextStyle get caption1 =>
      defaultStyle.copyWith(fontSize: scaleMultiplyFactor * 12);
  @override
  TextStyle get caption2 =>
      defaultStyle.copyWith(fontSize: scaleMultiplyFactor * 10);
  @override
  TextStyle get caption3 =>
      defaultStyle.copyWith(fontSize: scaleMultiplyFactor * 8);
}
