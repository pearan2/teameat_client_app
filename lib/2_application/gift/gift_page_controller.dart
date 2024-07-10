import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/voucher/gift/gift.dart';
import 'package:teameat/3_domain/voucher/gift/i_gift_repository.dart';

class GiftPageController extends PageController {
  final _giftRepo = Get.find<IGiftRepository>();
  final pageSize = 10;

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final PagingController<int, GiftPreview> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _loadGifts(int pageNumber) async {
    final ret = await _giftRepo.findMyGiftPreview(
        pageNumber: pageNumber, pageSize: pageSize);
    return ret.fold((l) => showError(l.desc), (r) {
      if (r.length < pageSize) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, pageNumber + 1);
      }
    });
  }

  Future<void> onShare(GiftPreview gift) async {
    if (!gift.isUsable) {
      return;
    }
    _isLoading.value = true;
    await Share.shareUri(
        Uri.https(Environment().linkBaseUrl, '/gift/${gift.id}'));
    _isLoading.value = false;
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
    pagingController.addPageRequestListener(_loadGifts);
    return super.initialLoad();
  }
}
