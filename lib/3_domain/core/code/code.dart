import 'package:freezed_annotation/freezed_annotation.dart';

part 'code.freezed.dart';

part 'code.g.dart';

@freezed
class CodeInner with _$CodeInner {
  const factory CodeInner({
    required String code,
    required String title,
  }) = _CodeInner;

  factory CodeInner.fromJson(Map<String, Object?> json) =>
      _$CodeInnerFromJson(json);
}

@freezed
class Code with _$Code {
  const factory Code({
    required String code,
    required String title,
    List<CodeInner>? children,
  }) = _Code;

  factory Code.fromJson(Map<String, Object?> json) => _$CodeFromJson(json);
}

@freezed
class CodeKey with _$CodeKey {
  const factory CodeKey({required String key}) = _CodeKey;

  factory CodeKey.storeCategory() => const CodeKey(key: 'STORE_CATEGORY');
  factory CodeKey.storeHashTag() => const CodeKey(key: 'STORE_HASHTAG');
}
