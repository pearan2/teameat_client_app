import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/3_domain/core/i_search_history_repository.dart';

mixin SearchHistoryRepositoryMixin on ISearchHistoryRepository {
  final _pref = Get.find<SharedPreferences>();

  @override
  List<String> findHistories() {
    return _pref.getStringList(searchHistoryKey) ?? [];
  }

  @override
  Future<bool> memorize(String searchText) async {
    final histories = findHistories();
    if (histories.contains(searchText)) {
      histories.remove(searchText);
    }
    final next = histories..insert(0, searchText);
    if (next.length > historyMaxSize) {
      next.removeLast();
    }
    return _pref.setStringList(searchHistoryKey, next);
  }

  @override
  Future<bool> remove(String searchText) {
    return _pref.setStringList(
        searchHistoryKey, findHistories()..remove(searchText));
  }

  @override
  void clean() {
    _pref.remove(searchHistoryKey);
  }
}
