import 'package:get/get.dart';
import 'package:teameat/3_domain/core/i_likable_repository.dart';

class LikeController<T extends ILikableRepository> {
  final _repo = Get.find<T>();
  final _likedIds = <int>{}.obs;

  // ignore: invalid_use_of_protected_member
  bool isLike(int id) => _likedIds.value.contains(id);

  void _like(int id) {
    _likedIds.add(id);
    _repo.like(id);
  }

  void _unlike(int id) {
    _likedIds.remove(id);
    _repo.unlike(id);
  }

  int toggleLike(int id) {
    if (_likedIds.contains(id)) {
      _unlike(id);
      return -1;
    } else {
      _like(id);
      return 1;
    }
  }

  Future<void> load() async {
    // ignore: invalid_use_of_protected_member
    _likedIds.value = (await _repo.loadLikes()).toSet();
  }
}
