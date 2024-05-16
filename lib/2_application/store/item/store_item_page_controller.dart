import 'package:get/get.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class StoreItemPageController extends PageController {
  final _storeItemRepo = Get.find<IStoreItemRepository>();

  final _item = ItemDetail.empty().obs;
  final _buyQuantity = 1.obs;

  ItemDetail get item => _item.value;
  int get buyQuantity => _buyQuantity.value;
  int get totalPrice => buyQuantity * item.price;

  final int itemId;
  StoreItemPageController({required this.itemId});

  void onBuyQuantityChanged(int newValue) {
    if (newValue < 1 || newValue > 99) {
      return;
    }
    _buyQuantity.value = newValue;
  }

  void onBuyClickHandler() {
    react.toItemPurchase({item: buyQuantity});
  }

  Future<void> _loadStoreItemInfo() async {
    final ret = await _storeItemRepo.findById(itemId);
    return ret.fold((l) => react.back(), (r) => _item.value = r);
  }

  @override
  Future<bool> initialLoad() async {
    await _loadStoreItemInfo();
    return true;
  }
}
