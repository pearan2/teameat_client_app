import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/3_domain/core/local.dart';

part 'curation.freezed.dart';

part 'curation.g.dart';

@freezed
class CurationSimple with _$CurationSimple {
  const factory CurationSimple({
    required final int id,
    required final String name,
    required final String imageUrl,
    required final String oneLineIntroduce,
    required final DateTime createdAt,
    required final int itemId,
    required final bool isItemActivated,
  }) = _CurationSimple;

  factory CurationSimple.fromJson(Map<String, Object?> json) =>
      _$CurationSimpleFromJson(json);
}

@freezed
class CurationDetail with _$CurationDetail {
  const factory CurationDetail({
    required final int id,
    required final String name,
    required final String imageUrl,
    required final String oneLineIntroduce,
    required final String introduce,
    required final List<String> itemImageUrls,
    required final List<String> storeImageUrls,
    required final DateTime createdAt,
    int? itemId,
    bool? isItemActivated,
  }) = _CurationDetail;

  factory CurationDetail.fromJson(Map<String, Object?> json) =>
      _$CurationDetailFromJson(json);
}

@freezed
class CurationCreateRequest with _$CurationCreateRequest {
  const factory CurationCreateRequest({
    required final Local localInfo,
    required final String name,
    required final String oneLineIntroduce,
    required final String introduce,
    required final List<String> itemImageUrls,
    required final List<String> storeImageUrls,
  }) = _CurationCreateRequest;

  factory CurationCreateRequest.fromJson(Map<String, Object?> json) =>
      _$CurationCreateRequestFromJson(json);
}
