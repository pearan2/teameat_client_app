import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/2_application/core/payment/payment_method.dart';
import 'package:teameat/3_domain/event/coupon/coupon.dart';
import 'package:teameat/3_domain/event/coupon/i_coupon_repository.dart';
import 'package:teameat/3_domain/order/i_order_repository.dart';
import 'package:teameat/3_domain/order/order.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class PurchasePageController extends PageController {
  // repo
  final _orderRepo = Get.find<IOrderRepository>();
  final _couponRepo = Get.find<ICouponRepository>();

  final Map<ItemDetail, int> items;
  final bool withOpenGroupBuying;
  final int? groupBuyingId;

  // state
  final _selectedCouponId = Rxn<int>();
  final _usableCoupons = RxList<Coupon>();
  final _purchaseMethod = Rxn<PaymentMethod>();
  late final _originalPrice = items.entries
      .fold(0, (prev, entry) => prev + entry.key.price * entry.value);
  late final _totalPrice = _originalPrice.obs;

  // getter
  PaymentMethod? get purchaseMethod => _purchaseMethod.value;
  int get totalPrice => _totalPrice.value;
  int? get selectedCouponId => _selectedCouponId.value;
  // ignore: invalid_use_of_protected_member
  List<Coupon> get usableCoupons => _usableCoupons.value;

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
              couponId: selectedCouponId,
              itemIdAndQuantities: items.entries
                  .map((e) =>
                      ItemIdAndQuantity(itemId: e.key.id, quantity: e.value))
                  .toList()),
          isGroupBuying: withOpenGroupBuying,
        ),
        (r) => react.toPaymentOff(r, purchaseMethod!,
            withOpenGroupBuying ? items.keys.first.id : null,
            isForGift: true));
  }

  Future<void> _loadUsableCoupons() async {
    final ret = await _couponRepo.findMyAllCoupons(
        searchOption: SearchMyCoupons.empty());
    ret.fold((l) => showError(l.desc), (r) => _usableCoupons.value = r);
  }

  Future<void> onSelectCoupon(int newSelectedCouponId) async {
    if (selectedCouponId == newSelectedCouponId) {
      _selectedCouponId.value = null;
      _totalPrice.value = _originalPrice;
      return;
    } else {
      _selectedCouponId.value = newSelectedCouponId;
    }
    react.isEventLoading = true;
    final ret = await _couponRepo.calcCouponAppliedAmount(
        id: newSelectedCouponId, originalAmount: _originalPrice);
    react.isEventLoading = false;
    ret.fold((l) => showError(l.desc), (r) {
      _totalPrice.value = r.amount;
    });

    /// 로딩중에 계속해서 쿠폰을 변경할 경우를 대비해서 쿠폰 아이디를 다시 바꿔줌
    _selectedCouponId.value = newSelectedCouponId;
  }

  PurchasePageController(
      {required this.items,
      required this.withOpenGroupBuying,
      this.groupBuyingId});

  @override
  Future<bool> initialLoad() async {
    _loadUsableCoupons();
    return true;
  }
}
