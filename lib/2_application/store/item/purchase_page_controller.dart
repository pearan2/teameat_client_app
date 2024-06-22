import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/3_domain/order/i_order_repository.dart';
import 'package:teameat/3_domain/order/order.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class PurchasePageController extends PageController {
  // repo
  final _orderRepo = Get.find<IOrderRepository>();

  final Map<ItemDetail, int> items;
  final bool withOpenGroupBuying;
  final int? groupBuyingId;

  // state
  final _purchaseMethod = Rxn<PaymentMethod>();

  // getter
  PaymentMethod? get purchaseMethod => _purchaseMethod.value;
  int get totalPrice => items.entries
      .fold(0, (prev, entry) => prev + entry.key.price * entry.value);
  List<PaymentMethod> get purchaseMethods => [
        PaymentMethod.card(),
        // PaymentMethod.naver(), -> 웰컴페이먼츠로 변경되면서 사용불가.
        PaymentMethod.kakao(),
        PaymentMethod.toss()
      ];

  // setter
  void onPurchaseMethodClick(PaymentMethod newMethod) {
    _purchaseMethod.value = newMethod;
  }

  Future<void> onPurchaseClick() async {
    if (purchaseMethod == null) {
      showError(DS.text.pleaseSelectPaymentMethod);
      return;
    }
    resolve<Order>(
        _orderRepo.registerOrder(
          RegisterOrderDto(
              groupBuyingId: groupBuyingId,
              itemIdAndQuantities: items.entries
                  .map((e) =>
                      ItemIdAndQuantity(itemId: e.key.id, quantity: e.value))
                  .toList()),
          isGroupBuying: withOpenGroupBuying,
        ),
        (r) => react.toPaymentOff(r, purchaseMethod!));
  }

  PurchasePageController(
      {required this.items,
      required this.withOpenGroupBuying,
      this.groupBuyingId});
}
