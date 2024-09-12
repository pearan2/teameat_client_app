import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/order/i_order_repository.dart';
import 'package:teameat/3_domain/order/order.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/get.dart';

class StoreItemPageController extends PageController {
  final _storeItemRepo = Get.find<IStoreItemRepository>();
  final _itemLikeController = Get.find<LikeController<IStoreItemRepository>>();
  final _orderRepo = Get.find<IOrderRepository>();

  final _isLoading = false.obs;

  late final RxWrapper<Failure, ItemDetail> item = (itemSimple == null
          ? ItemDetail.empty()
          : ItemDetail.fromSimple(itemSimple!))
      .wrap(_loadStoreItemInfo, emptyValue: ItemDetail.empty());
  late final groupBuyings =
      <GroupBuying>[].wrap(_loadGroupBuyings, autoStartLoad: false);

  final _buyQuantity = 1.obs;

  int get buyQuantity => _buyQuantity.value;
  int get totalPrice => buyQuantity * item.value.price;
  bool get isLoading => _isLoading.value;

  final int itemId;
  final ItemSimple? itemSimple;

  StoreItemPageController({required this.itemId, this.itemSimple});

  void onBuyQuantityChanged(int newValue) {
    if (newValue < 1 || newValue > 99) {
      return;
    }
    _buyQuantity.value = newValue;
  }

  void onBuyClickHandler() {
    react.toItemPurchase({item.value: buyQuantity}, withOpenGroupBuying: false);
  }

  void onOpenGroupBuyingClickHandler() {
    react.toItemPurchase({item.value: 1}, withOpenGroupBuying: true);
  }

  void onGroupBuyingSelfClickHandler() {
    react.toItemPurchase({item.value: 2}, withOpenGroupBuying: false);
  }

  void onEnterGroupBuying(int groupBuyingId) {
    react.toItemPurchase({item.value: 1},
        withOpenGroupBuying: false, groupBuyingId: groupBuyingId);
  }

  Future<void> onShareClickHandler() async {
    _isLoading.value = true;
    await Share.shareUri(Uri.https(Environment().linkBaseUrl, '/item/$itemId'));
    _isLoading.value = false;
  }

  Future<Either<Failure, ItemDetail>> _loadStoreItemInfo() async {
    final ret = await _storeItemRepo.findById(itemId);
    ret.fold((l) {
      react.back(closeOverlays: true);
      showError(l.desc);
    }, (r) {
      if (r.sellType == DS.text.groupBuying) {
        groupBuyings.load();
      }
    });
    return ret;
  }

  Future<Either<Failure, List<GroupBuying>>> _loadGroupBuyings() async {
    final ret = await _orderRepo.findGroupBuy(itemId);
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
