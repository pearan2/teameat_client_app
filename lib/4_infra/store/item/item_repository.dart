import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class StoreItemRepository extends IStoreItemRepository {
  final _conn = Get.find<IConnection>();
  final _pref = Get.find<SharedPreferences>();
  final _recentItemKey = 'recentItemLocalDataKey';
  final _recentItemMaxCount = 10;
  final _likeItemKey = 'likeItemLocalDataKey';
  final _numberOfLikeItemsPerPage = 10;

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

  Future<bool> _saveLikes(List<int> likes) async {
    return _pref.setStringList(
        _likeItemKey, likes.map((e) => e.toString()).toList());
  }

  @override
  List<int> findMyLikes() {
    final likes = _pref.getStringList(_likeItemKey);
    if (likes == null) {
      return <int>[];
    } else {
      return likes.map((e) => int.parse(e)).toList();
    }
  }

  @override
  void like(int id) {
    final likes = findMyLikes();
    if (likes.contains(id)) {
      return;
    }
    likes.insert(0, id);
    _saveLikes(likes);
  }

  @override
  void unLike(int id) {
    final likes = findMyLikes();
    likes.removeWhere((e) => e == id);
    _saveLikes(likes);
  }

  @override
  Future<Either<Failure, List<ItemSimple>>> findLikeItems(
      int pageNumber) async {
    try {
      final likes = findMyLikes();
      int start = pageNumber * _numberOfLikeItemsPerPage;
      int end = (pageNumber + 1) * _numberOfLikeItemsPerPage;
      if (start > likes.length) {
        return right(<ItemSimple>[]);
      }
      if (end > likes.length) {
        end = likes.length;
      }

      const path = '/api/store/item/list';
      final ids = likes.sublist(start, end);
      final ret =
          await _conn.get(path, {'itemIds': ids.map((e) => e.toString())});

      return ret.fold((l) => left(l), (r) {
        final items =
            (r as Iterable).map((json) => ItemSimple.fromJson(json)).toList();
        final sortedItems = <ItemSimple>[];
        for (final id in ids) {
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
}
