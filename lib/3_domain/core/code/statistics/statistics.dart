import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/date_time.dart';

part 'statistics.freezed.dart';

part 'statistics.g.dart';

@freezed
class StoreItemSalesStatistics with _$StoreItemSalesStatistics {
  const factory StoreItemSalesStatistics({
    required int data,
    required ItemSimple targetInfo,
  }) = _StoreItemSalesStatistics;

  factory StoreItemSalesStatistics.fromJson(Map<String, Object?> json) =>
      _$StoreItemSalesStatisticsFromJson(json);
}

@freezed
class CurationRewardStatistics with _$CurationRewardStatistics {
  const factory CurationRewardStatistics({
    required int data,
    required CurationListSimple targetInfo,
  }) = _CurationRewardStatistics;

  factory CurationRewardStatistics.fromJson(Map<String, Object?> json) =>
      _$CurationRewardStatisticsFromJson(json);
}

@freezed
class SearchList with _$SearchList {
  const factory SearchList({
    String? address,
    required int limit,
    required DateTime from,
    required DateTime to,
  }) = _SearchList;

  factory SearchList.empty() {
    return SearchList(
      address: "",
      limit: 3,
      from:
          DateTime.now().subtract(const Duration(days: 7)).firstDateOfTheWeek(),
      to: DateTime.now().subtract(const Duration(days: 7)).lastDayOfTheWeek(),
    );
  }
  factory SearchList.fromJson(Map<String, Object?> json) =>
      _$SearchListFromJson(json);

  static Map<String, dynamic> toStringJson(SearchList target) {
    final ret = <String, dynamic>{};
    if (target.address != null) ret['address'] = target.address;
    ret['limit'] = target.limit.toString();
    ret['from'] = target.from.dateString();
    ret['to'] = target.to.dateString();
    return ret;
  }
}
