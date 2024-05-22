import 'package:teameat/1_presentation/core/design/default/default_color_system.dart';
import 'package:teameat/1_presentation/core/design/default/default_image_system.dart';
import 'package:teameat/1_presentation/core/design/default/default_space_system.dart';
import 'package:teameat/1_presentation/core/design/default/default_text_style_system.dart';
import 'package:teameat/1_presentation/core/design/default/default_text_system.dart';
import 'package:teameat/1_presentation/core/design/i_color_system.dart';
import 'package:teameat/1_presentation/core/design/i_design_system.dart';
import 'package:teameat/1_presentation/core/design/i_image_system.dart';
import 'package:teameat/1_presentation/core/design/i_space_system.dart';
import 'package:teameat/1_presentation/core/design/i_text_style_system.dart';
import 'package:teameat/1_presentation/core/design/i_text_system.dart';

class DS extends IDesignSystem {
  static void init({IDesignSystem? designSystem}) {
    final system = designSystem ?? DS.base();
    color = system.cs;
    space = system.ss;
    text = system.ts;
    textStyle = system.tss;
    image = system.ims;
  }

  static void change(DS newDesignSystem) {
    init(designSystem: newDesignSystem);
  }

  static late IColorSystem color;
  static late ISpaceSystem space;
  static late ITextSystem text;
  static late ITextStyleSystem textStyle;
  static late IImageSystem image;

  final IColorSystem colorSystem;
  final ISpaceSystem spaceSystem;
  final ITextSystem textSystem;
  final ITextStyleSystem textStyleSystem;
  final IImageSystem imageSystem;

  DS._(
      {required this.colorSystem,
      required this.spaceSystem,
      required this.textSystem,
      required this.textStyleSystem,
      required this.imageSystem});

  factory DS.base() {
    return DS._(
        colorSystem: DefaultColorSystem(),
        spaceSystem: DefaultSpaceSystem(),
        textSystem: DefaultTextSystem(),
        textStyleSystem: DefaultTextStyleSystem(),
        imageSystem: DefaultImageSystem());
  }

  @override
  IColorSystem get cs => colorSystem;

  @override
  ISpaceSystem get ss => spaceSystem;

  @override
  ITextSystem get ts => textSystem;

  @override
  ITextStyleSystem get tss => textStyleSystem;

  @override
  IImageSystem get ims => imageSystem;
}
