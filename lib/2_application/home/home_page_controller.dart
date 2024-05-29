import 'package:flutter/widgets.dart' as wd;
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';

class HomePageController extends PageController {
  /// 상수
  final numberOfRecommendRequestItems = 1;
  final topKey = const wd.GlobalObjectKey("top-key");

  /// repos
  final _storeRepo = Get.find<IStoreRepository>();
  final _itemRepo = Get.find<IStoreItemRepository>();

  /// controllers
  final PagingController<int, StoreSimple> pagingController =
      PagingController(firstPageKey: 0);

  /// 상태
  final _searchOption = SearchStoreSimpleList.empty().obs;
  final _isNearbyMe = false.obs;
  final _recommendedItems = <ItemSimple>[].obs;

  /// getter
  bool get isNearbyMe => _isNearbyMe.value;

  SearchStoreSimpleList get searchOption => _searchOption.value;

  ItemSimple? get recommendedItem =>
      // ignore: invalid_use_of_protected_member
      _recommendedItems.value.isEmpty ? null : _recommendedItems.value.first;

  void onStoreItemCardClickHandler(int itemId) {
    return react.toStoreItemDetail(itemId);
  }

  void pageRefresh() {
    _searchOption.value = searchOption.copyWith(pageNumber: 0);
    pagingController.refresh();
  }

  void clearSearchOption() {
    _searchOption.value = SearchStoreSimpleList.empty();
    pagingController.refresh();
  }

  void onSearchTextCompleted(String searchText) {
    _searchOption.value =
        searchOption.copyWith(searchText: searchText, pageNumber: 0);
    pagingController.refresh();
  }

  /// 상태 변경 함수
  Future<void> onNearbyMeClickHandler() async {
    _isNearbyMe.value = !isNearbyMe;
  }

  Future<void> loadRecommendedItem() async {
    final ret =
        await _itemRepo.findRecommendedItems(numberOfRecommendRequestItems);
    ret.fold((l) => null, (r) => _recommendedItems.value = r);
  }

  Future<void> loadStores(int currentPageNumber) async {
    final ret = await _storeRepo.getStores(_searchOption.value);
    ret.fold((l) => showError(l.desc), (r) {
      if (r.isEmpty) {
        pagingController.appendLastPage([]);
      } else {
        pagingController.appendPage(r, currentPageNumber + 1);
        _searchOption.value =
            searchOption.copyWith(pageNumber: currentPageNumber + 1);
      }
    });
  }

  void pagingControllerStatusChangeListener(PagingStatus status) {
    if (status == PagingStatus.noItemsFound) {
      loadRecommendedItem();
    } else {
      _recommendedItems.value = [];
    }
  }

  @override
  void dispose() {
    pagingController.removePageRequestListener(loadStores);
    pagingController.removeStatusListener(pagingControllerStatusChangeListener);
    pagingController.dispose();
    super.dispose();
  }

  @override
  Future<bool> initialLoad() async {
    pagingController.addPageRequestListener(loadStores);
    pagingController.addStatusListener(pagingControllerStatusChangeListener);
    return true;
  }
}
