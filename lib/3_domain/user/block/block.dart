import 'package:freezed_annotation/freezed_annotation.dart';

part 'block.freezed.dart';
part 'block.g.dart';

enum BlockTargetType {
  user("MEMBER", "차단한 유저", "차단한 유저가 없어요"),
  curation("CURATION", "차단한 푸드로그", "차단한 푸드로그가 없어요");

  const BlockTargetType(this.code, this.title, this.noDataDescription);

  final String title;
  final String noDataDescription;

  final String code;
}

@freezed
class BlockTargetInfo with _$BlockTargetInfo {
  const factory BlockTargetInfo({
    required int id,
    required String imageUrl,
    required String title,
    String? description,
  }) = _BlockTargetInfo;

  factory BlockTargetInfo.fromJson(Map<String, Object?> json) =>
      _$BlockTargetInfoFromJson(json);
}

@freezed
class BlockTargetSearchList with _$BlockTargetSearchList {
  const factory BlockTargetSearchList({
    required BlockTargetType targetType,
    required int pageNumber,
    required int pageSize,
  }) = _BlockTargetSearchList;

  factory BlockTargetSearchList.fromJson(Map<String, Object?> json) =>
      _$BlockTargetSearchListFromJson(json);

  factory BlockTargetSearchList.empty(BlockTargetType targetType) {
    return BlockTargetSearchList(
      targetType: targetType,
      pageNumber: 0,
      pageSize: 20,
    );
  }

  static Map<String, dynamic> toStringJson(BlockTargetSearchList target) {
    final ret = <String, dynamic>{};
    ret['targetType'] = target.targetType.code;
    ret['pageNumber'] = target.pageNumber.toString();
    ret['pageSize'] = target.pageSize.toString();
    return ret;
  }
}
