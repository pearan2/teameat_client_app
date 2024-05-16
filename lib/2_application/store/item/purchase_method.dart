import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_method.freezed.dart';

@freezed
class PurchaseMethod with _$PurchaseMethod {
  const factory PurchaseMethod({
    required String method,
  }) = _PurchaseMethod;

  factory PurchaseMethod.card() => const PurchaseMethod(method: '신용/체크카드');
  factory PurchaseMethod.naver() => const PurchaseMethod(method: '네이버페이');
  factory PurchaseMethod.kakao() => const PurchaseMethod(method: '카카오페이');
  factory PurchaseMethod.toss() => const PurchaseMethod(method: '토스페이');
}
