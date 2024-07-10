import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/voucher/gift/gift.dart';
import 'package:teameat/3_domain/voucher/gift/i_gift_repository.dart';
import 'package:teameat/99_util/get.dart';

class GiftReceivePageController extends PageController {
  final _giftRepo = Get.find<IGiftRepository>();
  final String giftId;

  final _isLoading = false.obs;

  late final gift = GiftPreview.empty().wrap(_loadGift);
  bool get isLoading => _isLoading.value;

  Future<Either<Failure, GiftPreview>> _loadGift() async {
    final ret = await _giftRepo.findGiftPreview(giftId);
    ret.fold((l) {
      react.back();
      showError(DS.text.wrongGift);
    }, (r) {
      if (!r.isUsable) {
        showError(DS.text.giftIsAlreadyUsed);
      }
    });
    return _giftRepo.findGiftPreview(giftId);
  }

  GiftReceivePageController({required this.giftId});

  Future<void> onReceiveGift() async {
    _isLoading.value = true;
    final ret = await _giftRepo.receiveGift(giftId);
    _isLoading.value = false;
    ret.fold((l) => showError(l.desc), (r) => react.toVoucherOffAll());
  }
}
