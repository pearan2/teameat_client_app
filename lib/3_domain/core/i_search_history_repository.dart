abstract class ISearchHistoryRepository {
  int get historyMaxSize => 30;
  String get searchHistoryKey;
  List<String> findHistories();
  Future<bool> memorize(String searchText);
  Future<bool> remove(String searchText);
  void clean();
}
