import 'package:freezed_annotation/freezed_annotation.dart';

part 'searchable_address.freezed.dart';

part 'searchable_address.g.dart';

extension SearchableAddressExtension on SearchableAddress {
  String toFullAddress() {
    String ret = siDo;
    if (siGunGu.isNotEmpty) {
      ret += ' $siGunGu';
    }
    if (eupMyeonDong.isNotEmpty) {
      ret += ' $eupMyeonDong';
    }
    return ret;
  }

  String toLongLabel() {
    String ret = siDo;
    if (siGunGu.isNotEmpty) {
      ret += ' $siGunGu';
    }
    if (eupMyeonDong.isNotEmpty) {
      ret += ' $eupMyeonDong';
    }
    if (alias.isNotEmpty) {
      ret += ' ($alias)';
    }
    return ret;
  }

  String toShortLabel() {
    String label = siDo;
    if (siGunGu.isNotEmpty) {
      label = siGunGu;
    }
    if (eupMyeonDong.isNotEmpty) {
      label = eupMyeonDong;
    }
    if (alias.isNotEmpty) {
      label += " ($alias)";
    }
    return label;
  }
}

@freezed
class SearchableAddress with _$SearchableAddress {
  const factory SearchableAddress({
    required String siDo,
    required String siGunGu,
    required String eupMyeonDong,
    required String alias,
  }) = _SearchableAddress;

  factory SearchableAddress.fromJson(Map<String, Object?> json) =>
      _$SearchableAddressFromJson(json);
}
