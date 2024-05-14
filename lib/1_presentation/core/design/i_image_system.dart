import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class IImageSystem {
  Image get splashBackground;
  SvgPicture get mainIconWithText;
  Image get nearbyMeIcon;
}
