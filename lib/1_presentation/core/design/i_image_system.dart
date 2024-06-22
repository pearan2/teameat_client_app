import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

abstract class IImageSystem {
  Image get splashBackground;
  SvgPicture get mainIconWithText;
  Image get nearbyMeIcon;

  /// main icon (logo)
  Image get mainIconXsm;
  Image get mainIconSm;
  Image get mainLargeIconNoBg;
  Image get mainMediumIconNoBg;

  ///
  Image get kakaoLogo;
  Image get appleLogo;
  SvgPicture get iconHome;

  ///
  SvgPicture get bottomIconHome;
  SvgPicture get bottomIconHomeClicked;
  SvgPicture get bottomIconVoucher;
  SvgPicture get bottomIconVoucherClicked;
  SvgPicture get bottomIconCommunity;
  SvgPicture get bottomIconCommunityClicked;
  SvgPicture get bottomIconUser;
  SvgPicture get bottomIconUserClicked;

  /// store 관련 아이콘들
  SvgPicture get location;
  SvgPicture get clock;
  SvgPicture get store;
  SvgPicture get phone;
  SvgPicture get up;

  ///
  Image get customerService;
  Image get markerBackground;

  /// icon
  SvgPicture get iconSearch;
  Image get iconLike;
  Image get iconLikeClicked;
  SvgPicture get iconLikeBorder;
  SvgPicture get iconLikeBorderClicked;

  SvgPicture get bookmark;
  SvgPicture get bookmarkClicked;
  SvgPicture get rightArrow;
  Image get dangolPick;
  SvgPicture get addImage;

  /// sell type icon
  SvgPicture get timeLimit;
  SvgPicture get quantityLimit;

  /// banner
  Image get communityBanner1;
}
