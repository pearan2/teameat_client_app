import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';

part 'order.g.dart';

@freezed
class GroupBuying with _$GroupBuying {
  const factory GroupBuying({
    required final int id,
    required final String creatorProfileImageUrl,
    required final String creatorNickname,
    required final DateTime willBeClosedAt,
  }) = _GroupBuying;

  factory GroupBuying.fromJson(Map<String, Object?> json) =>
      _$GroupBuyingFromJson(json);
}

@freezed
class Order with _$Order {
  const factory Order({
    required final String orderId,
    required final String name,
    required final String memberEmail,
    required final String memberSocialId,
    required final int totalAmount,
    required final int originalTotalAmount,
    required final String userCode,
    required final String pg,
  }) = _Order;

  factory Order.fromJson(Map<String, Object?> json) => _$OrderFromJson(json);
}

@freezed
class ItemIdAndQuantity with _$ItemIdAndQuantity {
  const factory ItemIdAndQuantity({
    required final int itemId,
    required final int quantity,
  }) = _ItemIdAndQuantity;

  factory ItemIdAndQuantity.fromJson(Map<String, Object?> json) =>
      _$ItemIdAndQuantityFromJson(json);
}

@freezed
class RegisterOrderDto with _$RegisterOrderDto {
  const factory RegisterOrderDto({
    required final List<ItemIdAndQuantity> itemIdAndQuantities,
    int? groupBuyingId,
    int? couponId,
  }) = _RegisterOrderDto;

  factory RegisterOrderDto.fromJson(Map<String, Object?> json) =>
      _$RegisterOrderDtoFromJson(json);
}
