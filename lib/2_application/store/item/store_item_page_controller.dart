import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/get.dart';

class StoreItemPageController extends PageController {
  final _storeItemRepo = Get.find<IStoreItemRepository>();
  final _itemLikeController = Get.find<LikeController<IStoreItemRepository>>();

  late final item = ItemDetail.empty().wrap(_loadStoreItemInfo);
  final _buyQuantity = 1.obs;

  int get buyQuantity => _buyQuantity.value;
  int get totalPrice => buyQuantity * item.value.price;

  late final absorbing = itemDetail != null;

  final int itemId;
  final ItemDetail? itemDetail;
  final void Function()? onApplyCuration;
  StoreItemPageController(
      {required this.itemId, this.itemDetail, this.onApplyCuration});

  void onBuyQuantityChanged(int newValue) {
    if (newValue < 1 || newValue > 99) {
      return;
    }
    _buyQuantity.value = newValue;
  }

  void onBuyClickHandler() {
    react.toItemPurchase({item.value: buyQuantity});
  }

  Future<Either<Failure, ItemDetail>> _loadStoreItemInfo() async {
    if (itemDetail != null) {
      await Future.delayed(const Duration(seconds: 1));
      return right(itemDetail!);
    }

    final ret = await _storeItemRepo.findById(itemId);
    ret.fold((l) {
      react.back(closeOverlays: true);
      showError(l.desc);
    }, (r) => {});
    return ret;
  }

  Future<void> onLikeClickHandler() async {
    final diff = await _itemLikeController.toggleLike(itemId);
    item.value = item.value
        .copyWith(numberOfLikes: item.value.numberOfLikes + (diff ?? 0));
  }

  @override
  Future<bool> initialLoad() async {
    return true;
  }
}
