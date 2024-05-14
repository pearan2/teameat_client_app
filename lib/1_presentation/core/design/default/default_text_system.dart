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
}
