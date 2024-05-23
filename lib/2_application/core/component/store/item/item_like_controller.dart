import 'package:get/get.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';

class ItemLikeController {
  final _itemRepo = Get.find<IStoreItemRepository>();

  final _likedItemIds = <int>{}.obs;

  // ignore: invalid_use_of_protected_member
  bool isLike(int itemId) => _likedItemIds.value.contains(itemId);

  void _like(int itemId) {
    _likedItemIds.add(itemId);
    _itemRepo.like(itemId);
  }

  void _unlike(int itemId) {
    _likedItemIds.remove(itemId);
    _itemRepo.unlike(itemId);
  }

  int toggleLike(int itemId) {
    if (_likedItemIds.contains(itemId)) {
      _unlike(itemId);
      return -1;
    } else {
      _like(itemId);
      return 1;
    }
  }

  void init() {
    // ignore: invalid_use_of_protected_member
    _likedItemIds.value = _itemRepo.findMyLikes().toSet();
  }
}
