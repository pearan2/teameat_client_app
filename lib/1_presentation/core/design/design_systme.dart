import 'package:teameat/1_presentation/core/design/default/default_color_system.dart';
import 'package:teameat/1_presentation/core/design/default/default_space_system.dart';
import 'package:teameat/1_presentation/core/design/default/default_text_style_system.dart';
import 'package:teameat/1_presentation/core/design/default/default_text_system.dart';
import 'package:teameat/1_presentation/core/design/i_color_system.dart';
import 'package:teameat/1_presentation/core/design/i_design_system.dart';
import 'package:teameat/1_presentation/core/design/i_space_system.dart';
import 'package:teameat/1_presentation/core/design/i_text_style_system.dart';
import 'package:teameat/1_presentation/core/design/i_text_system.dart';

class DS extends IDesignSystem {
  static DS? _ds;
  static DS get _instance {
    _ds ??= DS.base();
    return _ds!;
  }

  static void change(DS newDesignSystem) {
    _ds = newDesignSystem;
  }

  static IColorSystem getColor() => _instance.colorSystem;
  static ITextSystem getText() => _instance.textSystem;
  static ITextStyleSystem getTextStyle() => _instance.textStyleSystem;
  static ISpaceSystem getSpace() => _instance.spaceSystem;

  final IColorSystem colorSystem;
  final ISpaceSystem spaceSystem;
  final ITextSystem textSystem;
  final ITextStyleSystem textStyleSystem;

  DS._(
      {required this.colorSystem,
      required this.spaceSystem,
      required this.textSystem,
      required this.textStyleSystem});

  factory DS.base() {
    return DS._(
        colorSystem: DefaultColorSystem(),
        spaceSystem: DefaultSpaceSystem(),
        textSystem: DefaultTextSystem(),
        textStyleSystem: DefaultTextStyleSystem());
  }

  @override
  IColorSystem get cs => colorSystem;

  @override
  ISpaceSystem get ss => spaceSystem;

  @override
  ITextSystem get ts => textSystem;

  @override
  ITextStyleSystem get tss => textStyleSystem;
}
