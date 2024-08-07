// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart';
import 'package:teameat/1_presentation/core/design/i_space_system.dart';

class DefaultSpaceSystem extends ISpaceSystem {
  /// 2
  @override
  double get xxTiny => 2;

  /// 4
  @override
  double get xTiny => 4;

  /// 8
  @override
  double get tiny => 8;

  /// 16
  @override
  double get xSmall => 12;

  @override
  double get small => 16;

  @override
  double get xBase => 20;

  @override
  double get base => 24;

  @override
  double get medium => 32;

  @override
  double get large => 48;

  @override
  double get big => 60;

  /// hSizedBox
  /// 2
  @override
  SizedBox get hXXTiny => const SizedBox(width: 2);

  /// 4
  @override
  SizedBox get hXTiny => const SizedBox(width: 4);

  /// 8
  @override
  SizedBox get hTiny => const SizedBox(width: 8);

  /// 16
  @override
  SizedBox get hXSmall => const SizedBox(width: 12);

  @override
  SizedBox get hSmall => const SizedBox(width: 16);

  @override
  SizedBox get hXBase => const SizedBox(width: 20);

  @override
  SizedBox get hBase => const SizedBox(width: 24);

  @override
  SizedBox get hMedium => const SizedBox(width: 32);

  @override
  SizedBox get hLarge => const SizedBox(width: 48);

  @override
  SizedBox get hBig => const SizedBox(width: 60);

  /// vSizedBox
  /// 2
  @override
  SizedBox get vXXTiny => const SizedBox(height: 2);

  /// 4
  @override
  SizedBox get vXTiny => const SizedBox(height: 4);

  /// 8
  @override
  SizedBox get vTiny => const SizedBox(height: 8);

  /// 16
  @override
  SizedBox get vXSmall => const SizedBox(height: 12);

  @override
  SizedBox get vSmall => const SizedBox(height: 16);

  @override
  SizedBox get vXBase => const SizedBox(height: 20);

  @override
  SizedBox get vBase => const SizedBox(height: 24);

  @override
  SizedBox get vMedium => const SizedBox(height: 32);

  @override
  SizedBox get vLarge => const SizedBox(height: 48);

  @override
  SizedBox get vBig => const SizedBox(height: 60);
}
