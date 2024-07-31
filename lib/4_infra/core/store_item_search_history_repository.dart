import 'package:teameat/3_domain/core/i_search_history_repository.dart';
import 'package:teameat/4_infra/core/search_history_repository.dart';

class StoreItemSearchHistoryRepository extends ISearchHistoryRepository
    with SearchHistoryRepositoryMixin {
  @override
  String get searchHistoryKey => 'storeItemSearchHistoryKey';
}
