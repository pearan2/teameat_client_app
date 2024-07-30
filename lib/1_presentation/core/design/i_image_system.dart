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

  ///fd
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
  SvgPicture get address;
  SvgPicture get clock;
  SvgPicture get store;
  SvgPicture get phone;
  SvgPicture get up;

  ///
  Image get customerService;
  Image get markerBackground;

  /// icon
  SvgPicture get iconSearch;
  Image get iconLikeShadow;
  Image get iconLikeShadowClicked;
  SvgPicture get iconLike;
  SvgPicture get iconLikeClicked;

  SvgPicture get copy;
  Image get naverMap;

  SvgPicture get bookmark;
  SvgPicture get bookmarkClicked;
  SvgPicture leftArrowInBox({Color? color});
  SvgPicture get rightArrow;
  SvgPicture get rightArrowInBox;
  Image get dangolPick;
  SvgPicture get addImage;

  SvgPicture get location;
  SvgPicture get locationActivated;
  SvgPicture get locationLg;
  SvgPicture get map;
  SvgPicture get mapActivated;
  SvgPicture get mapLg;
  SvgPicture more(Color color);

  SvgPicture get sort;
  SvgPicture get share;

  /// sell type icon
  SvgPicture get timeLimit;
  SvgPicture get quantityLimit;

  /// banner & guide
  Image get communityBanner1;
  Image get curationGuide;

  SvgPicture get selected;
}
