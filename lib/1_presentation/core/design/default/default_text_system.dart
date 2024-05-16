import 'package:teameat/1_presentation/core/design/i_text_system.dart';

class DefaultTextSystem extends ITextSystem {
  @override
  String get textSearcherPlaceHolder => '오늘 뭐먹지?';

  @override
  String get nearbyMe => '내 주변';

  @override
  String get itemUsageInfo => '사용 정보';

  @override
  String get yyyyMMddBasicFormat => 'yyyy년 MM월 dd일';

  @override
  String get breakTime => '브레이크타임';

  @override
  String get expiredAt => '유효기간';

  @override
  String get lastOrderTime => '라스트오더';

  @override
  String get operationTime => '영업시간';

  @override
  String get originInformation => '원산지';

  @override
  String get phone => '전화번호';

  @override
  String get buy => '구매하기';

  @override
  String get login => '로그인';

  @override
  String get teameatIntroduce1 => '팀잇은';

  @override
  String get teameatIntroduce2 => '공동구매 방식을 외식산업에 도입하려고해요.';

  @override
  String get teameatIntroduce3 => '왜 이렇게 할까요?';

  @override
  String get teameatIntroduce4 =>
      '공동구매를 통해 식당의 매출을 미리 발생시키고 회전율을 높여 소비자들이 더 저렴한 가격으로 식당을 이용할 수 있기 때문이에요!';

  @override
  String get willYouJoinUs => '새로운 외식산업의 시작! 함께 해주실래요?';

  @override
  String get trySnsJoinOrLogin => '5초만에 팀잇 로그인 하기';

  @override
  String get loginWithKakao => '카카오로 로그인';

  @override
  String get confirmToLogin => '로그인 하기';

  @override
  String get needToLoginContent => '로그인이 필요한 서비스에요. 로그인 페이지로 이동 할까요?';

  @override
  String get refuseToLogin => '더 둘러보기';

  @override
  String get purchase => '결제하기';

  @override
  String get priceFormat => '###,###,###원';

  @override
  String get purchaseItemInfo => '결제 상품 정보';

  @override
  String get purchaseMethod => '결제 수단';

  @override
  String get purchaseNotice => '이용 안내';

  @override
  String get purchasePrice => '결제 금액';

  @override
  String get quantity => '수량';

  @override
  String get quantityFormat => '수량 ##개';
}
