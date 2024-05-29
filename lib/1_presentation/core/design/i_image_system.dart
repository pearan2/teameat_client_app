import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class IImageSystem {
  Image get splashBackground;
  SvgPicture get mainIconWithText;
  Image get nearbyMeIcon;

  /// main icon (logo)
  Image get mainIconSm;
  Image get mainLargeIconNoBg;
  Image get mainMediumIconNoBg;

  ///
  Image get kakaoLogo;
  Image get appleLogo;
  Image get iconHome;

  ///
  SvgPicture get bottomIconHome;
  SvgPicture get bottomIconHomeClicked;
  SvgPicture get bottomIconVoucher;
  SvgPicture get bottomIconVoucherClicked;
  SvgPicture get bottomIconUser;
  SvgPicture get bottomIconUserClicked;

  ///
  Image get storeLocation;
  Image get storeOperationInfo;
  Image get storeIntroduce;
  Image get storePhone;
  Image get customerService;
  Image get storeItemExpired;
  Image get markerBackground;

  /// icon
  SvgPicture get iconSearch;
  SvgPicture get iconLike;
  SvgPicture get iconLikeClicked;
  SvgPicture get bookmark;
  SvgPicture get bookmarkClicked;
}
