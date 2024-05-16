import 'package:get/get.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/2_application/store/item/purchase_method.dart';
import 'package:teameat/3_domain/order/i_order_repository.dart';
import 'package:teameat/3_domain/order/order.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class PurchasePageController extends PageController {
  // repo
  final _orderRepo = Get.find<IOrderRepository>();

  final Map<ItemDetail, int> items;

  // state
  final _purchaseMethod = Rxn<PurchaseMethod>();

  // getter
  PurchaseMethod? get purchaseMethod => _purchaseMethod.value;
  int get totalPrice => items.entries
      .fold(0, (prev, entry) => prev + entry.key.price * entry.value);
  List<PurchaseMethod> get purchaseMethods => [
        PurchaseMethod.card(),
        PurchaseMethod.naver(),
        PurchaseMethod.kakao(),
        PurchaseMethod.toss()
      ];

  // setter
  void onPurchaseMethodClick(PurchaseMethod newMethod) {
    _purchaseMethod.value = newMethod;
  }

  Future<void> onPurchaseClick() async {
    /// order 후 처리
    react.isEventLoading = true;
    final ret = await _orderRepo.registerOrder(RegisterOrderDto(
        itemIdAndQuantities: items.entries
            .map((e) => ItemIdAndQuantity(itemId: e.key.id, quantity: e.value))
            .toList()));
    react.isEventLoading = false;
    print(ret);
    // react.toPayment();
  }

  PurchasePageController({required this.items});
}
