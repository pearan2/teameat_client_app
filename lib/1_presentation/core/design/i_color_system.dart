import 'package:flutter/widgets.dart';

abstract class IColorSystem {
  /// 0xFF0086FF
  Color get primary700;

  /// 0xFF356BF7
  Color get primary600;

  /// 0xFF8DCBFF
  Color get primary500;

  /// 0xFFE3F2FF
  Color get secondary900;

  /// 0xFFFD5353
  Color get secondary700;

  /// 0xFFF44E00
  Color get secondary500;

  /// 0xFFFFF8F1
  Color get secondary300;

  Color get point500;

  /// 0xFF000000
  Color get background900;

  /// 0xFF1C1C1E
  Color get background800;

  /// 0xFF292929
  Color get background700;

  /// 0xFF4D4D4D
  Color get background600;

  /// 0xFF767676
  Color get background500;

  /// 0xFFB5B5B5
  Color get background400;

  /// 0xFFDDDDDD
  Color get background300;

  /// 0xFFD9D9D9
  Color get background200;

  /// 0xFFEDEDED
  Color get background100;

  /// 0xFFFFFFFF
  Color get background000;
}
