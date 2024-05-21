import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class VoucherUsedPageController extends PageController {
  final VoucherDetail voucher;

  final int usedQuantity;

  VoucherUsedPageController(
      {required this.voucher, required this.usedQuantity});
}
