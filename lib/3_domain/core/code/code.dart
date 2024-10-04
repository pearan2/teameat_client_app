import 'package:freezed_annotation/freezed_annotation.dart';

part 'code.freezed.dart';

part 'code.g.dart';

extension CategoryCodeExtension on Code {
  String localImageUrl(int idx) =>
      'assets/image/icon/category/category_$idx.png';

  String networkImageUrl(int idx) =>
      'https://teameat-prod-read-public.s3.ap-northeast-2.amazonaws.com/base/category_$idx.png';
}

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
    return const Code(code: 'ALL', title: '전체');
  }

  factory Code.orderEmpty() {
    return const Code(code: 'RECENT', title: '최신순');
  }

  factory Code.itemOrderManyLike() {
    return const Code(code: 'MANY_LIKE', title: '좋아요 많은 순');
  }

  factory Code.itemHighDiscountRatio() {
    return const Code(code: 'HIGH_DISCOUNT_RATIO', title: '할인율 높은 순');
  }
}

@freezed
class CodeKey with _$CodeKey {
  const factory CodeKey({required String key}) = _CodeKey;

  factory CodeKey.curationFilter() => const CodeKey(key: 'CURATION_FILTER');
  factory CodeKey.storeSearchCategory() =>
      const CodeKey(key: 'STORE_SEARCH_CATEGORY');
  factory CodeKey.storeHashTag() => const CodeKey(key: 'STORE_HASHTAG');
  factory CodeKey.voucherFilter() => const CodeKey(key: 'VOUCHER_FILTER');
  factory CodeKey.voucherOrder() => const CodeKey(key: 'VOUCHER_ORDER');
  factory CodeKey.curationOrder() => const CodeKey(key: 'CURATION_ORDER');
  factory CodeKey.storeItemOrder() => const CodeKey(key: 'STORE_ITEM_ORDER');
  factory CodeKey.storeItemSellType() =>
      const CodeKey(key: 'STORE_ITEM_SELL_TYPE');

  static List<CodeKey> findAll() {
    return [
      CodeKey.curationFilter(),
      CodeKey.storeSearchCategory(),
      CodeKey.storeHashTag(),
      CodeKey.voucherFilter(),
      CodeKey.voucherOrder(),
      CodeKey.curationOrder(),
      CodeKey.storeItemOrder(),
      CodeKey.storeItemSellType(),
    ];
  }
}
