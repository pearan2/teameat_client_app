import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teameat/1_presentation/core/design/i_image_system.dart';

class DefaultImageSystem extends IImageSystem {
  @override
  Image get splashBackground => Image.asset(
        'assets/image/splash_background.png',
        width: double.infinity,
        fit: BoxFit.fitWidth,
      );

  @override
  SvgPicture get mainIconWithText => SvgPicture.asset(
        'assets/image/main_icon_with_text.svg',
        height: 24,
        width: 140,
      );
}
