import 'package:teameat/1_presentation/core/design/i_color_system.dart';
import 'package:teameat/1_presentation/core/design/i_space_system.dart';
import 'package:teameat/1_presentation/core/design/i_text_style_system.dart';
import 'package:teameat/1_presentation/core/design/i_text_system.dart';

abstract class IDesignSystem {
  IColorSystem get cs;
  ISpaceSystem get ss;
  ITextStyleSystem get tss;
  ITextSystem get ts;
}
