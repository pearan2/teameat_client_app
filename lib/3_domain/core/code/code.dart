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
    String? localAssetPath,
    List<CodeInner>? children,
  }) = _Code;

  static List<Code> getLargeCategories() {
    return const [
      Code(
          code: "S_001",
          title: "한식 분식\n고기",
          localAssetPath: 'assets/image/icon/category/category_0.png'),
      Code(
          code: "S_002",
          title: "양식 카페\n디저트",
          localAssetPath: 'assets/image/icon/category/category_1.png'),
      Code(
          code: "S_003",
          title: "중식 일식\n아시안",
          localAssetPath: 'assets/image/icon/category/category_2.png'),
      Code(
          code: "S_004",
          title: "치킨 피자\n버거",
          localAssetPath: 'assets/image/icon/category/category_3.png'),
      Code(
          code: "S_005",
          title: "술집 야식\n안주",
          localAssetPath: 'assets/image/icon/category/category_4.png'),
    ];
  }

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
