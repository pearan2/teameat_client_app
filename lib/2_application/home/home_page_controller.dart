import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';

class HomePageController extends PageController {
  /// repos
  final _storeRepo = Get.find<IStoreRepository>();

  /// controllers
  final PagingController<int, StoreSimple> pagingController =
      PagingController(firstPageKey: 0);

  /// 상태
  final _searchOption = SearchStoreSimpleList.empty().obs;
  final _isNearbyMe = false.obs;

  /// getter
  bool get isNearbyMe => _isNearbyMe.value;

  /// 상태 변경 함수
  Future<void> onNearbyMeClickHandler() async {
    _isNearbyMe.value = !isNearbyMe;
  }

  Future<void> loadStores(int currentPageNumber) async {
    final ret = await _storeRepo.getStores(_searchOption.value);
    ret.fold((l) => null, (r) {
      if (r.isEmpty) {
        pagingController.appendLastPage([]);
      }
      pagingController.appendPage(r, currentPageNumber + 1);
    });
  }

  @override
  Future<bool> initialLoad() async {
    pagingController.addPageRequestListener(loadStores);
    return true;
  }
}
