import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class StoreItemLikePageController extends PageController {
  final _itemRepo = Get.find<IStoreItemRepository>();

  final PagingController<int, ItemSimple> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _loadItems(int pageNumber) async {
    final ret = await _itemRepo.findLikeData(pageNumber);
    return ret.fold((l) => showError(l.desc), (r) {
      if (r.isEmpty) {
        pagingController.appendLastPage([]);
      } else {
        pagingController.appendPage(r as List<ItemSimple>, pageNumber + 1);
      }
    });
  }

  @override
  void dispose() {
    pagingController.removePageRequestListener(_loadItems);
    pagingController.dispose();
    super.dispose();
  }

  @override
  Future<bool> initialLoad() {
    pagingController.addPageRequestListener(_loadItems);
    return super.initialLoad();
  }
}