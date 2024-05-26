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

  @override
  Image get nearbyMeIcon => Image.asset(
        'assets/image/nearby_me.png',
        height: 12,
        width: 12,
      );

  @override
  Image get mainLargeIconNoBg =>
      Image.asset('assets/image/main_icon_no_bg.png');

  @override
  Image get mainMediumIconNoBg =>
      Image.asset('assets/image/main_icon_no_bg.png',
          width: 55.36, height: 36.22);

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
  Image get iconHome => Image.asset(
        'assets/image/icon_home.png',
        width: 24,
        height: 24,
      );

  @override
  Image get bottomIconHome => Image.asset(
        'assets/image/bottom_icon_home.png',
        width: 32,
        height: 32,
      );

  @override
  Image get bottomIconUser => Image.asset(
        'assets/image/bottom_icon_user.png',
        width: 32,
        height: 32,
      );

  @override
  Image get bottomIconVoucher => Image.asset(
        'assets/image/bottom_icon_voucher.png',
        width: 32,
        height: 32,
      );

  @override
  Image get storeIntroduce => Image.asset(
        'assets/image/store_introduce.png',
        width: 24,
        height: 24,
      );

  @override
  Image get storeLocation => Image.asset(
        'assets/image/store_location.png',
        width: 24,
        height: 24,
      );

  @override
  Image get storeOperationInfo => Image.asset(
        'assets/image/store_operation_info.png',
        width: 24,
        height: 24,
      );

  @override
  Image get storePhone => Image.asset(
        'assets/image/store_phone.png',
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
  Image get storeItemExpired => Image.asset(
        'assets/image/store_item_expire.png',
        width: 24,
        height: 24,
      );

  @override
  Image get markerBackground => Image.asset(
        'assets/image/map_marker.png',
        height: 41,
        width: 32,
      );
}
