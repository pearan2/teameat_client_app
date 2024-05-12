import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';

part 'item.g.dart';

@freezed
class ItemSimple with _$ItemSimple {
  const factory ItemSimple({
    required int id,
    required String name,
    required String imageUrl,
    required int originalPrice,
    required int price,
    required String sellType,
    DateTime? currentGroupBuyingWillBeEndedAt,
  }) = _ItemSimple;

  factory ItemSimple.fromJson(Map<String, Object?> json) =>
      _$ItemSimpleFromJson(json);
}
