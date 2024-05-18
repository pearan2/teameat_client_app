import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method.freezed.dart';

@freezed
class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required String method,
    required String value,
  }) = _PaymentMethod;

  factory PaymentMethod.card() =>
      const PaymentMethod(method: '신용/체크카드', value: 'card');
  factory PaymentMethod.naver() =>
      const PaymentMethod(method: '네이버페이', value: 'naverpay');
  factory PaymentMethod.kakao() =>
      const PaymentMethod(method: '카카오페이', value: 'kakaopay');
  factory PaymentMethod.toss() =>
      const PaymentMethod(method: '토스페이', value: 'tosspay');
}
