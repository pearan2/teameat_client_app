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
  SvgPicture address({double? size});
  SvgPicture clock({double? size});
  SvgPicture get store;
  SvgPicture phone({double? size, Color? color});

  ///
  Image get customerService;
  Image get markerBackground;

  /// icon
  SvgPicture searchLg({Color? color});
  SvgPicture search({double? size, Color? color});
  SvgPicture get searchSm;
  Image get iconLikeShadow;
  Image get iconLikeShadowClicked;
  SvgPicture get iconLike;
  SvgPicture get iconLikeClicked;
  SvgPicture close({double? size, Color? color});
  SvgPicture get closeLg;
  SvgPicture get closeSm;

  SvgPicture get copy;
  Widget get naverMap;

  SvgPicture get bookmark;
  SvgPicture get bookmarkClicked;
  SvgPicture leftArrowInBox({Color? color});
  SvgPicture rightArrow({double? size, Color? color});
  SvgPicture get rightArrowInBox;
  SvgPicture upArrow({double? size, Color? color});
  SvgPicture downArrow({double? size, Color? color});
  SvgPicture get addImage;

  SvgPicture get locationSm;
  SvgPicture get locationSmWhite;
  SvgPicture get location;
  SvgPicture get locationActivated;
  SvgPicture get locationLg;
  SvgPicture get map;
  SvgPicture get mapActivated;
  SvgPicture get mapLg;
  SvgPicture more(Color color);
  SvgPicture forkAndKnife({Color? color, double? size});

  SvgPicture get sort;
  SvgPicture get share;

  /// sell type icon
  SvgPicture groupBuying({Color? color, double? size});
  SvgPicture timeLimit({Color? color, double? size});
  SvgPicture quantityLimit({Color? color, double? size});

  /// banner & guide
  Image get communityBanner1;
  Image get curationGuide;
  SvgPicture get reward;

  SvgPicture get selected;

  // pay logo
  Image get kakaopayLogo;
  Image get tosspayLogo;

  /// item usage
  SvgPicture get itemUsageInventoryIcon;
  SvgPicture get itemUsageQrCodeIcon;
  SvgPicture get itemUsageMobileIcon;
  SvgPicture get itemUsageGiftIcon;

  /// teameat pacman
  Image get pacman;
}
