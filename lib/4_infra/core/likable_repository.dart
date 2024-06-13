import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/core/i_likable_repository.dart';

mixin LikableRepositoryMixin<T> on ILikableRepository<T> {
  final _pref = Get.find<SharedPreferences>();
  final _conn = Get.find<IConnection>();

  @override
  void clean() {
    _saveLikes([]);
  }

  List<int> _loadLikes() {
    final stringIds = _pref.getStringList(key);
    if (stringIds == null) {
      return <int>[];
    } else {
      return stringIds.map((e) => int.parse(e)).toList();
    }
  }

  Future<bool> _saveLikes(List<int> likes) {
    final stringIds = likes.map((e) => e.toString()).toList();
    return _pref.setStringList(key, stringIds);
  }

  List<int> _insertAtFirstLikes(List<int> likes) {
    final localLikes = _loadLikes();
    likes.removeWhere((e) => localLikes.contains(e));
    localLikes.insertAll(0, likes);
    _saveLikes(localLikes);
    return localLikes;
  }

  void _likeCallback(int id) {
    _conn.patch(likeCallbackPathBuilder(id), null);
  }

  @override
  void like(int id) {
    final likes = _loadLikes();
    if (likes.contains(id)) {
      return;
    }
    likes.insert(0, id);
    _saveLikes(likes);
    _likeCallback(id);
  }

  void _unlikeCallback(int id) {
    _conn.patch(unlikeCallbackPathBuilder(id), null);
  }

  @override
  void unlike(int id) {
    final likes = _loadLikes();
    likes.removeWhere((e) => e == id);
    _saveLikes(likes);
    _unlikeCallback(id);
  }

  Future<Either<Failure, List<int>>> _loadLikesFromConn() async {
    try {
      final ret = await _conn.get(likeLoadPath, null);
      return ret.fold((l) => left(l),
          (r) => right((r as Iterable).map((e) => e as int).toList()));
    } catch (e) {
      return left(
          const Failure.fetchLikeFail('좋아요 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }

  @override
  Future<List<int>> loadLikes() async {
    final ret = await _loadLikesFromConn();
    return ret.fold((l) => _loadLikes(), (r) => _insertAtFirstLikes(r));
  }

  @override
  Future<Either<Failure, List<T>>> findLikeData(int pageNumber) async {
    try {
      final likes = _loadLikes();
      int start = pageNumber * numberOfLikeDatasPerPage;
      int end = (pageNumber + 1) * numberOfLikeDatasPerPage;
      if (start > likes.length) {
        return right(<T>[]);
      }
      if (end > likes.length) {
        end = likes.length;
      }

      final ids = likes.sublist(start, end);
      final ret = await dataLoader(ids);

      return ret.fold((l) => left(l), (r) {
        final datas = (r as Iterable)
            .map((json) => dataResolver(json) as dynamic)
            .toList();
        final sortedItems = <T>[];
        for (final id in ids) {
          for (final data in datas) {
            if (data.id == id) {
              sortedItems.add(data);
            }
          }
        }
        return right(sortedItems);
      });
    } catch (e) {
      return left(
          const Failure.fetchLikeFail('좋아요 정보를 가져오는데 실패했습니다. 잠시 후 다시 시도해주세요.'));
    }
  }
}
