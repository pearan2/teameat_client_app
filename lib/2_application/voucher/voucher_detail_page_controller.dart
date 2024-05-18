import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/voucher/i_voucher_repository.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class VoucherDetailPageController extends PageController {
  final _voucherRepo = Get.find<IVoucherRepository>();

  final int voucherId;

  final _voucher = VoucherDetail.empty().obs;

  VoucherDetail get voucher => _voucher.value;

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
