import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/4_infra/core/likable_repository.dart';

class StoreItemRepository extends IStoreItemRepository<ItemSimple>
    with LikableRepositoryMixin<ItemSimple> {
  final _conn = Get.find<IConnection>();
  final _pref = Get.find<SharedPreferences>();
  final _recentItemKey = 'recentItemLocalDataKey';
  final _recentItemMaxCount = 10;

  @override
  Future<Either<Failure, ItemDetail>> findById(int id) async {
    try {
      final path = '/api/store/item/$id';
      final ret = await _conn.get(path, null);
      return ret.fold((l) => left(l), (r) {
        _addRecentSeeItemId(id);
        return right(ItemDetail.fromJson(r as JsonMap));
      });
    } catch (e) {
      return left(const Failure.fetchStoreItemFail(
          '상품 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  List<String> _getRecentSeeItemIds() {
    final ids = _pref.getStringList(_recentItemKey);
    return ids ?? [];
  }

  void _addRecentSeeItemId(int id) {
    final ids = _getRecentSeeItemIds();
    final alreadyExistsIdx = ids.indexOf(id.toString());

    /// 이미 들어있다는 뜻
    if (alreadyExistsIdx >= 0) {
      ids.removeAt(alreadyExistsIdx);
    }

    ids.insert(0, id.toString());
    if (ids.length > _recentItemMaxCount) {
      ids.removeLast();
    }
    _pref.setStringList(_recentItemKey, ids);
  }

  @override
  Future<Either<Failure, List<ItemSimple>>> findRecentSeeItems() async {
    try {
      const path = '/api/store/item/list';
      final ids = _getRecentSeeItemIds();
      final ret = await _conn.get(path, {'itemIds': ids});

      return ret.fold((l) => left(l), (r) {
        final items =
            (r as Iterable).map((json) => ItemSimple.fromJson(json)).toList();
        final sortedItems = <ItemSimple>[];
        for (final idString in ids) {
          final id = int.parse(idString);
          for (final item in items) {
            if (item.id == id) {
              sortedItems.add(item);
            }
          }
        }
        return right(sortedItems);
      });
    } catch (e) {
      return left(const Failure.fetchStoreItemFail(
          '상품 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<Failure, List<ItemSimple>>> findRecommendedItems(
      int numberOfItems) async {
    try {
      const path = '/api/store/item/recommended';
      final ids = _getRecentSeeItemIds();
      final ret = await _conn.get(
          path, {'itemIds': ids, 'numberOfItems': numberOfItems.toString()});
      return ret.fold(
          (l) => left(l),
          (r) => right((r as Iterable)
              .map((json) => ItemSimple.fromJson(json))
              .toList()));
    } catch (e) {
      return left(const Failure.fetchStoreItemFail(
          '상품 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<Either<dynamic, Object>> Function(List<int> ids) get dataLoader =>
      (ids) => _conn.get(
          '/api/store/item/list', {'itemIds': ids.map((e) => e.toString())});

  @override
  String get key => 'itemLikeLocalDateKey';

  @override
  String get likeLoadPath => '/api/member/like/store-item';

  @override
  String Function(int id) get likeCallbackPathBuilder =>
      (id) => '/api/store/item/like/$id';

  @override
  String Function(int id) get unlikeCallbackPathBuilder =>
      (id) => '/api/store/item/unlike/$id';

  @override
  ItemSimple Function(JsonMap json) get dataResolver => ItemSimple.fromJson;

  @override
  int get numberOfLikeDatasPerPage => 10;
}
