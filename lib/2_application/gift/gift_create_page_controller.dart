import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/voucher/gift/i_gift_repository.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class GiftCreatePageController extends PageController {
  final _giftRepo = Get.find<IGiftRepository>();

  final VoucherDetail voucher;
  final int giftQuantity;
  final _isLoading = false.obs;

  final messageController = TECupertinoTextFieldController();
  bool get isLoading => _isLoading.value;

  GiftCreatePageController({required this.voucher, required this.giftQuantity});

  Future<void> onGift() async {
    messageController.text = messageController.text.trim();
    if (!messageController.checkIsValid()) {
      return;
    }
    messageController.unFocus();

    _isLoading.value = true;
    final ret = await _giftRepo.createGiftFromVoucher(
        voucherId: voucher.id,
        quantity: giftQuantity,
        message: messageController.text);
    _isLoading.value = false;
    ret.fold((l) {
      showError(l.desc);
    }, (r) {
      react.toVoucherOffAll();
      react.toGiftSuccess(giftId: r);
    });
  }
}
