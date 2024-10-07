import 'dart:math';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/location_controller.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';

abstract class ItemSearchPageController extends PageController {
  SearchSimpleList get initialSearchOption;
  PagingController<int, ItemSimple> get pagingController;

  void onStoreItemCardClickHandler(int itemId);
  Future<void> refreshPage();
  void clearSearchOption();
  void beforeClearSearchOption();
  void onSearchTextCompleted(String searchText);
  Future<void> onSelectedAddressChanged(SearchableAddress? address);
  Future<void> onWithInMeterChanged(int? value);
  Future<void> onOrderChanged(Code order);
}

mixin ItemSearchPageControllerMixin on ItemSearchPageController {
  /// 상수
  final numberOfRecommendRequestItems = 1;

  /// repos
  final _storeRepo = Get.find<IStoreRepository>();
  final _itemRepo = Get.find<IStoreItemRepository>();
  final _codeRepo = Get.find<ICodeRepository>();

  /// controllers
  @override
  final PagingController<int, ItemSimple> pagingController =
      PagingController(firstPageKey: 0);
  final locationController = Get.find<LocationController>();

  /// 상태
  final _searchableAddresses = <SearchableAddress>[].obs;
  late final _searchOption = initialSearchOption.obs;
  final _orderCodes = RxList<Code>.empty();

  final _recommendedItems = <ItemSimple>[].obs;
  final _isLoading = false.obs;
  bool _isPagingLoading = false;

  /// getter
  SearchSimpleList get searchOption => _searchOption.value;

  ItemSimple? get recommendedItem =>
      // ignore: invalid_use_of_protected_member
      _recommendedItems.value.isEmpty ? null : _recommendedItems.value.first;

  int? get withInMeter => _searchOption.value.withInMeter;

  // ignore: invalid_use_of_protected_member
  List<SearchableAddress> get searchableAddresses => _searchableAddresses.value;
  SearchableAddress? get selectedAddress => searchOption.address;
  bool get loading => _isLoading.value;
  // ignore: invalid_use_of_protected_member
  List<Code> get orders => _orderCodes.value;

  @override
  void onStoreItemCardClickHandler(int itemId) {
    return react.toStoreItemDetail(itemId);
  }

  @override
  Future<void> refreshPage() async {
    _searchOption.value = searchOption.copyWith(
        pageNumber: 0, randomSeed: Random().nextInt(10000));
    pagingController.error = '';
    pagingController.refresh();
    pagingController.error = null;
  }

  @override
  void clearSearchOption() {
    beforeClearSearchOption();
    _searchOption.value = initialSearchOption;
    pagingController.refresh();
  }

  @override
  void beforeClearSearchOption() {}

  @override
  void onSearchTextCompleted(String searchText) {
    if (searchText.length == 1) {
      showError(DS.text.itemSearchPageSearchTextHint);
      return;
    }
    _searchOption.value =
        searchOption.copyWith(searchText: searchText, pageNumber: 0);
    pagingController.refresh();
  }

  @override
  Future<void> onSelectedAddressChanged(SearchableAddress? address) async {
    _searchOption.value =
        searchOption.copyWith(address: address, pageNumber: 0);
    pagingController.refresh();
  }

  @override
  Future<void> onOrderChanged(Code order) async {
    _searchOption.value = searchOption.copyWith(order: order, pageNumber: 0);
    pagingController.refresh();
  }

  @override
  Future<void> onWithInMeterChanged(int? value) async {
    if (!locationController.isInitialized) {
      _isLoading.value = true;
      await locationController.init();
      _isLoading.value = false;
    }
    if (locationController.data == null) {
      return;
    }
    final loc = locationController.data!;
    if (loc.latitude == null || loc.longitude == null) {
      showError(DS.text.locationServiceDisabled);
      return;
    }
    _searchOption.value = _searchOption.value.copyWith(
      pageNumber: 0,
      baseLocation: value == null
          ? null
          : Point(latitude: loc.latitude!, longitude: loc.longitude!),
      withInMeter: value,
    );
    pagingController.refresh();
  }

  Future<void> _loadRecommendedItem() async {
    final ret =
        await _itemRepo.findRecommendedItems(numberOfRecommendRequestItems);
    ret.fold((l) => null, (r) => _recommendedItems.value = r);
  }

  Future<void> _loadStores(int currentPageNumber) async {
    if (_isPagingLoading) return;
    _isPagingLoading = true;
    final ret = await _storeRepo.getStoreItems(_searchOption.value);
    _isPagingLoading = false;
    ret.fold((l) => showError(l.desc), (r) {
      if (r.length < _searchOption.value.pageSize) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, currentPageNumber + 1);
        _searchOption.value =
            searchOption.copyWith(pageNumber: currentPageNumber + 1);
      }
    });
  }

  void _pagingControllerStatusChangeListener(PagingStatus status) {
    if (status == PagingStatus.noItemsFound) {
      _loadRecommendedItem();
    } else {
      _recommendedItems.value = [];
    }
  }

  Future<void> _loadSearchableAddresses() async {
    final ret = await _codeRepo.getSearchableAddress();
    return ret.fold(
        (l) => showError(l.desc), (r) => _searchableAddresses.value = r);
  }

  Future<void> _loadCode() async {
    return resolve(_codeRepo.getCode(CodeKey.storeItemOrder()),
        (codes) => _orderCodes.value = codes);
  }

  @override
  void onReady() {
    pagingController.error = '';
    pagingController.refresh();
    pagingController.error = null;
    super.onReady();
  }

  @override
  Future<bool> initialLoad() async {
    _loadSearchableAddresses();
    _loadCode();
    pagingController.itemList = [];
    pagingController.addPageRequestListener(_loadStores);
    pagingController.addStatusListener(_pagingControllerStatusChangeListener);
    return true;
  }
}
