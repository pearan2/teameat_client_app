import 'package:teameat/3_domain/core/i_search_history_repository.dart';
import 'package:teameat/4_infra/core/search_history_repository_mixin.dart';

class CurationSearchHistoryRepository extends ISearchHistoryRepository
    with SearchHistoryRepositoryMixin {
  @override
  String get searchHistoryKey => 'curationSearchHistoryKey';
}
