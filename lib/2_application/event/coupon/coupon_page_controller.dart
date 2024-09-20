import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/event/coupon/coupon.dart';
import 'package:teameat/3_domain/event/coupon/i_coupon_repository.dart';

class CouponPageController extends PageController {
  final _couponRepo = Get.find<ICouponRepository>();

  final _isLoading = false.obs;
  final _searchOption = SearchMyCoupons.empty().obs;
  final PagingController<int, Coupon> pagingController =
      PagingController(firstPageKey: 0);
  final couponIdInputController = TECupertinoTextFieldController();

  bool get isUsable => _searchOption.value.isUsable!;
  bool get isLoading => _isLoading.value;

  Future<void> _loadCoupons(int pageNumber) async {
    final ret = await _couponRepo.findMyAllCoupons(
        searchOption: _searchOption.value.copyWith(pageNumber: pageNumber));
    return ret.fold((l) => showError(l.desc), (r) {
      if (r.length < _searchOption.value.pageSize) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, pageNumber + 1);
      }
    });
  }

  Future<void> onRegisterCoupon() async {
    _isLoading.value = true;
    final ret = await _couponRepo.registerCoupon(couponIdInputController.text);
    ret.fold((l) => showError(l.desc), (r) => pagingController.refresh());
    _isLoading.value = false;
  }

  void onIsUsableChanged(bool isUsable) {
    _searchOption.value = _searchOption.value.copyWith(isUsable: isUsable);
    pagingController.refresh();
  }

  @override
  void onReady() {
    pagingController.error = '';
    pagingController.refresh();
    pagingController.error = null;
    super.onReady();
  }

  @override
  Future<bool> initialLoad() {
    pagingController.itemList = [];
    pagingController.addPageRequestListener(_loadCoupons);
    return super.initialLoad();
  }
}
