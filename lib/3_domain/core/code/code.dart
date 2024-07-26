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

  factory Code.empty() {
    return const Code(code: 'ALL', title: 'All');
  }

  factory Code.orderEmpty() {
    return const Code(code: 'RECENT', title: 'Recent');
  }
}

@freezed
class CodeKey with _$CodeKey {
  const factory CodeKey({required String key}) = _CodeKey;

  factory CodeKey.curationFilter() => const CodeKey(key: 'CURATION_FILTER');
  factory CodeKey.storeCategory() => const CodeKey(key: 'STORE_CATEGORY');
  factory CodeKey.storeHashTag() => const CodeKey(key: 'STORE_HASHTAG');
  factory CodeKey.voucherFilter() => const CodeKey(key: 'VOUCHER_FILTER');
  factory CodeKey.voucherOrder() => const CodeKey(key: 'VOUCHER_ORDER');
  factory CodeKey.curationOrder() => const CodeKey(key: 'CURATION_ORDER');
}
