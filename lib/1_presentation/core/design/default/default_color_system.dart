import 'dart:ui';

import 'package:teameat/1_presentation/core/design/i_color_system.dart';

class DefaultColorSystem extends IColorSystem {
  /// primary
  @override
  Color get primary500 => const Color(0xFF0086FF);
  @override
  Color get primary400 => const Color(0xFF356BF7);

  /// secondary
  @override
  Color get secondary600 => const Color(0xFFF44E00);
  @override
  Color get secondary500 => const Color(0xFFFD5353);
  @override
  Color get secondary400 => const Color(0xFFF44E00);

  /// point
  @override
  Color get point500 => const Color(0xFF60B259);

  /// background
  @override
  Color get background800 => const Color(0xFF000000);
  @override
  Color get background700 => const Color(0xFF292929);
  @override
  Color get background600 => const Color(0xFF4D4D4D);
  @override
  Color get background500 => const Color(0xFF767676);
  @override
  Color get background400 => const Color(0xFFB5B5B5);
  @override
  Color get background300 => const Color(0xFFDDDDDD);
  @override
  Color get background200 => const Color(0xFFD9D9D9);
  @override
  Color get background100 => const Color(0xFFEDEDED);
  @override
  Color get background000 => const Color(0xFFFFFFFF);
}
