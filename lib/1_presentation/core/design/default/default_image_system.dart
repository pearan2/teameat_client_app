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
  Image get mainIconXsm => Image.asset(
        'assets/image/main_icon_no_bg.png',
        height: 16,
        width: 24,
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
  Image get iconLike => Image.asset(
        'assets/image/icon/like.png',
        height: 36,
        width: 36,
      );

  @override
  Image get iconLikeClicked => Image.asset(
        'assets/image/icon/like_liked.png',
        height: 36,
        width: 36,
      );

  @override
  SvgPicture get iconLikeBorder => SvgPicture.asset(
        'assets/image/icon/like_border.svg',
        height: 31,
        width: 31,
      );

  @override
  SvgPicture get iconLikeBorderClicked => SvgPicture.asset(
        'assets/image/icon/like_border_liked.svg',
        height: 31,
        width: 31,
      );

  @override
  SvgPicture get rightArrow => SvgPicture.asset(
        'assets/image/icon/right_arrow.svg',
        height: 24,
        width: 24,
      );
  @override
  Image get dangolPick => Image.asset(
        'assets/image/icon/dangol_pick.png',
        width: 44,
        height: 44,
      );
  @override
  SvgPicture get addImage => SvgPicture.asset(
        'assets/image/icon/add_image_icon.svg',
        height: 24,
        width: 24,
      );

// sell type icon
  @override
  SvgPicture get quantityLimit => SvgPicture.asset(
        'assets/image/icon/sell_type/quantity_limit.svg',
        height: 16,
        width: 16,
      );

  @override
  SvgPicture get timeLimit => SvgPicture.asset(
        'assets/image/icon/sell_type/time_limit.svg',
        height: 16,
        width: 16,
      );

  @override
  Image get communityBanner1 => Image.asset(
        'assets/image/banner/community_banner_1.png',
        height: 330,
        width: 1536,
        fit: BoxFit.fitHeight,
      );

  @override
  Image get curationGuide => Image.asset(
        'assets/image/curation/curation_guide.jpg',
        fit: BoxFit.fitWidth,
      );
  @override
  Image get curationGuideAppBar => Image.asset(
        'assets/image/curation/curation_guide_app_bar.png',
        fit: BoxFit.fitHeight,
      );
}
