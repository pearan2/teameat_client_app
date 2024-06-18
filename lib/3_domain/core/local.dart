import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/3_domain/store/store.dart';

part 'local.freezed.dart';

part 'local.g.dart';

@freezed
class Local with _$Local {
  const factory Local({
    required final String title,
    required final String category,
    required final String address,
    required final String roadAddress,
    required final Point location,
    required final String storeId,
  }) = _Local;

  factory Local.fromJson(Map<String, Object?> json) => _$LocalFromJson(json);

  factory Local.empty() {
    return Local(
      title: '',
      category: '',
      address: '',
      roadAddress: '',
      location: Point.empty(),
      storeId: '',
    );
  }
}
