import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreLikePageController extends PageController {
  final _storeRepo = Get.find<IStoreRepository>();

  final PagingController<int, StoreSimple> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _loadStores(int pageNumber) async {
    final ret = await _storeRepo.findLikeData(pageNumber);
    return ret.fold((l) => showError(l.desc), (r) {
      if (r.isEmpty) {
        pagingController.appendLastPage(r as List<StoreSimple>);
      } else {
        pagingController.appendPage(r as List<StoreSimple>, pageNumber + 1);
      }
    });
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
    pagingController.addPageRequestListener(_loadStores);
    return super.initialLoad();
  }
}
