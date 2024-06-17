import 'dart:ui';

import 'package:teameat/1_presentation/core/design/i_color_system.dart';

class DefaultColorSystem extends IColorSystem {
  /// primary
  @override
  Color get primary600 => const Color(0xFF0088FF);
  @override
  Color get primary500 => const Color(0xFF2FA6FF);

  /// secondary
  @override
  Color get secondary900 => const Color(0xFFFF7700);
  @override
  Color get secondary700 => const Color(0xFFFFA709);
  @override
  Color get secondary500 => const Color(0xFFFEC817);

  /// point
  @override
  Color get point500 => const Color(0xFFF96060);

  /// background
  @override
  Color get background800 => const Color(0xFF1C1C1E);
  @override
  Color get background700 => const Color(0xFF3C3C3F);
  @override
  Color get background600 => const Color(0xFF6F6F71);
  @override
  Color get background500 => const Color(0xFF97979A);
  @override
  Color get background400 => const Color(0xFFB7B7B9);
  @override
  Color get background300 => const Color(0xFFDADADD);
  @override
  Color get background200 => const Color(0xFFEAEAED);
  @override
  Color get background100 => const Color(0xFFF2F2F5);
  @override
  Color get background000 => const Color(0xFFFFFFFF);
}
