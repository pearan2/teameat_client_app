import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/design/i_image_system.dart';

class DefaultImageSystem extends IImageSystem {
  @override
  Image get splashBackground => Image.asset(
        'assets/image/splash_background.png',
        width: double.infinity,
        fit: BoxFit.fitWidth,
      );

  /// main icon
  @override
  SvgPicture get mainIconWithText => SvgPicture.asset(
        'assets/image/main_icon_with_text.svg',
        height: 24,
        width: 140,
      );

  @override
  Image get mainIconSm => Image.asset(
        'assets/image/main_icon_no_bg.png',
        height: 24,
        width: 36,
      );

  @override
  Image get mainLargeIconNoBg =>
      Image.asset('assets/image/main_icon_no_bg.png');

  @override
  Image get mainMediumIconNoBg =>
      Image.asset('assets/image/main_icon_no_bg.png',
          width: 55.36, height: 36.22);

  ///
  @override
  Image get nearbyMeIcon => Image.asset(
        'assets/image/nearby_me.png',
        height: 12,
        width: 12,
      );

  @override
  Image get kakaoLogo => Image.asset(
        'assets/image/sns_logo_kakao.png',
        width: 24,
        height: 24,
      );

  @override
  Image get appleLogo => Image.asset(
        'assets/image/sns_logo_apple.png',
        width: 24,
        height: 24,
      );

  @override

  /// Todo 추후 검은색 받아서 변경
  SvgPicture get iconHome => SvgPicture.asset(
        'assets/image/icon/bottom/home.svg',
        height: 24,
        width: 24,
        color: DS.color.background800,
      );

////// bottom icons //////

  @override
  SvgPicture get bottomIconHome => SvgPicture.asset(
        'assets/image/icon/bottom/home.svg',
        height: 20,
        width: 20,
      );

  @override
  SvgPicture get bottomIconHomeClicked => SvgPicture.asset(
        'assets/image/icon/bottom/home_clicked.svg',
        height: 20,
        width: 20,
      );

  @override
  SvgPicture get bottomIconUser => SvgPicture.asset(
        'assets/image/icon/bottom/profile.svg',
        height: 20,
        width: 20,
      );

  @override
  SvgPicture get bottomIconUserClicked => SvgPicture.asset(
        'assets/image/icon/bottom/profile_clicked.svg',
        height: 20,
        width: 20,
      );

  @override
  SvgPicture get bottomIconVoucher => SvgPicture.asset(
        'assets/image/icon/bottom/inventory.svg',
        height: 20,
        width: 20,
      );

  @override
  SvgPicture get bottomIconVoucherClicked => SvgPicture.asset(
        'assets/image/icon/bottom/inventory_clicked.svg',
        height: 20,
        width: 20,
      );

  @override
  SvgPicture get bottomIconCommunity => SvgPicture.asset(
        'assets/image/icon/bottom/community.svg',
        height: 20,
        width: 20,
      );

  @override
  SvgPicture get bottomIconCommunityClicked => SvgPicture.asset(
        'assets/image/icon/bottom/community_clicked.svg',
        height: 20,
        width: 20,
      );

///////////////////////////

  @override
  SvgPicture get store => SvgPicture.asset(
        'assets/image/icon/store_icon.svg',
        width: 24,
        height: 24,
      );

  @override
  SvgPicture get location => SvgPicture.asset(
        'assets/image/icon/address_icon.svg',
        width: 24,
        height: 24,
      );

  @override
  SvgPicture get clock => SvgPicture.asset(
        'assets/image/icon/clock_icon.svg',
        width: 24,
        height: 24,
      );

  @override
  SvgPicture get phone => SvgPicture.asset(
        'assets/image/icon/phone_icon.svg',
        width: 24,
        height: 24,
      );

  @override
  SvgPicture get up => SvgPicture.asset(
        'assets/image/icon/up.svg',
        width: 24,
        height: 24,
      );

  @override
  Image get customerService => Image.asset(
        'assets/image/customer_service.png',
        width: 251,
        height: 282,
      );

  @override
  Image get markerBackground => Image.asset(
        'assets/image/map_marker.png',
        height: 41,
        width: 32,
      );

  /// icon
  @override
  SvgPicture get iconSearch => SvgPicture.asset(
        'assets/image/icon/search_icon.svg',
        height: 16,
        width: 16,
      );

  @override
  SvgPicture get bookmark => SvgPicture.asset(
        'assets/image/icon/bookmark.svg',
        height: 20,
        width: 16,
      );

  @override
  SvgPicture get bookmarkClicked => SvgPicture.asset(
        'assets/image/icon/bookmark_marked.svg',
        height: 20,
        width: 16,
      );

  @override
  SvgPicture get iconLike => SvgPicture.asset(
        'assets/image/icon/like.svg',
        height: 31,
        width: 31,
      );

  @override
  SvgPicture get iconLikeClicked => SvgPicture.asset(
        'assets/image/icon/like_liked.svg',
        height: 31,
        width: 31,
      );
}
