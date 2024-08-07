import 'package:freezed_annotation/freezed_annotation.dart';

part 'searchable_address.freezed.dart';

part 'searchable_address.g.dart';

extension SearchableAddressExtension on SearchableAddress {
  String toFullAddress() {
    return '$siDo $siGunGu $eupMyeonDong';
  }
}

@freezed
class SearchableAddress with _$SearchableAddress {
  const factory SearchableAddress({
    required String siDo,
    required String siGunGu,
    required String eupMyeonDong,
  }) = _SearchableAddress;

  factory SearchableAddress.fromJson(Map<String, Object?> json) =>
      _$SearchableAddressFromJson(json);
}
