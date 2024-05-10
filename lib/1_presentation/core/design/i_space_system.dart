import 'package:flutter/material.dart';

abstract class ISpaceSystem {
  /// 2
  double get xxTiny;

  /// 4
  double get xTiny;

  /// 8
  double get tiny;

  /// 12
  double get xSmall;

  /// 16
  double get small;

  /// 20
  double get xBase;

  /// 24
  double get base;

  /// 32
  double get medium;

  /// 48
  double get large;

  /// 2
  SizedBox get hXXTiny;

  /// 4
  SizedBox get hXTiny;

  /// 8
  SizedBox get hTiny;

  /// 12
  SizedBox get hXSmall;

  /// 16
  SizedBox get hSmall;

  /// 20
  SizedBox get hXBase;

  /// 24
  SizedBox get hBase;

  /// 32
  SizedBox get hMedium;

  /// 48
  SizedBox get hLarge;

  /// 2
  SizedBox get vXXTiny;

  /// 4
  SizedBox get vXTiny;

  /// 8
  SizedBox get vTiny;

  /// 12
  SizedBox get vXSmall;

  /// 16
  SizedBox get vSmall;

  /// 20
  SizedBox get vXBase;

  /// 24
  SizedBox get vBase;

  /// 32
  SizedBox get vMedium;

  /// 48
  SizedBox get vLarge;
}
