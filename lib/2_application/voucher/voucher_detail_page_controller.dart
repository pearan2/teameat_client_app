import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/voucher/i_voucher_repository.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class VoucherDetailPageController extends PageController {
  final bool _isUpdated = false;

  final useVoucherPasswordMaxLength = 4;

  final _voucherRepo = Get.find<IVoucherRepository>();

  final int voucherId;

  final _voucher = VoucherDetail.empty().obs;

  final _useQuantity = RxInt(1);
  final _voucherPassword = ''.obs;

  final _isLoading = false.obs;

  void initValues() {
    _useQuantity.value = 1;
    _voucherPassword.value = '';
  }

  VoucherDetail get voucher => _voucher.value;
  int get useVoucherQuantity => _useQuantity.value;
  int get useVoucherPasswordLength => _voucherPassword.value.length;
  int get useVoucherRemainQuantity => voucher.quantity - useVoucherQuantity;
  bool get isLoading => _isLoading.value;
  bool get isUpdated => _isUpdated;

  void onUseQuantityChanged(int newQuantity) {
    if (newQuantity < 1 || newQuantity > 99) {
      return;
    }
    if (newQuantity > voucher.quantity) {
      return;
    }
    _useQuantity.value = newQuantity;
  }

  Future<void> _useVoucher() async {
    react.closeDialog();
    _isLoading.value = true;
    final ret = await _voucherRepo.useVoucher(
        voucherId,
        UseVoucher(
            storeVoucherPassword: _voucherPassword.value,
            quantity: useVoucherQuantity));
    _isLoading.value = false;
    ret.fold((l) {
      showError(l.desc);
      initValues();
    }, (r) {
      react.toVoucherUsedOffAll(
          voucher: voucher, usedQuantity: useVoucherQuantity);
    });
  }

  void onVoucherPasswordAppended(String appendedValue) {
    final newPassword = _voucherPassword.value + appendedValue;
    if (newPassword.length <= useVoucherPasswordMaxLength &&
        newPassword.isNotEmpty) {
      _voucherPassword.value = newPassword;
    }
    if (useVoucherPasswordLength == useVoucherPasswordMaxLength) {
      _useVoucher();
    }
  }

  void onVoucherPasswordReset() {
    _voucherPassword.value = '';
  }

  void onVoucherPasswordDeleteLast() {
    if (_voucherPassword.value.isEmpty) return;
    final newPassword =
        _voucherPassword.value.substring(0, _voucherPassword.value.length - 1);
    _voucherPassword.value = newPassword;
  }

  Future<void> _loadVoucher() async {
    final ret = await _voucherRepo.findById(voucherId);
    return ret.fold((l) => showError(l.desc), (r) => _voucher.value = r);
  }

  Future<void> onUseVoucherHandler() async {}

  VoucherDetailPageController({required this.voucherId});

  @override
  Future<bool> initialLoad() async {
    await _loadVoucher();
    return true;
  }
}