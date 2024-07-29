import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/location_controller.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/store/store.dart';

class CurationPageController extends PageController {
  // repos
  final _codeRepo = Get.find<ICodeRepository>();
  final _curationRepo = Get.find<ICurationRepository>();

  // states
  final _orderCodes = RxList<Code>.empty();
  final _searchOption = SearchCurationSimpleList.empty().obs;
  bool _isLoading = false;
  final _isPageLoading = false.obs;

  // controllers
  final locationController = Get.find<LocationController>();
  final PagingController<int, CurationListSimple> pagingController =
      PagingController(firstPageKey: 0);

  // getter
  SearchCurationSimpleList get searchOption => _searchOption.value;
  List<Code> get orders => _orderCodes;
  int? get withInMeter => _searchOption.value.withInMeter;
  bool get isPageLoading => _isPageLoading.value;

  Future<void> refreshPage() async {
    _searchOption.value = searchOption.copyWith(pageNumber: 0);
    pagingController.error = '';
    pagingController.refresh();
    pagingController.error = null;
  }

  void clearSearchOption() {
    _searchOption.value = SearchCurationSimpleList.empty();
    pagingController.refresh();
  }

  void onSearchTextCompleted(String searchText) {
    _searchOption.value =
        searchOption.copyWith(searchText: searchText, pageNumber: 0);
    pagingController.refresh();
  }

  void onOrderChanged(Code newOrder) {
    _searchOption.value = searchOption.copyWith(order: newOrder, pageNumber: 0);
    pagingController.refresh();
  }

  Future<void> onWithInMeterChanged(int? value) async {
    if (!locationController.isInitialized) {
      _isPageLoading.value = true;
      await locationController.init();
      _isPageLoading.value = false;
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

  void onCurationTapHandler(int curationId) {
    react.toCurationDetail(curationId);
  }

  Future<void> _loadCode() async {
    return resolve(_codeRepo.getCode(CodeKey.curationOrder()),
        (codes) => _orderCodes.value = codes);
  }

  Future<void> _loadCurations(int currentPageNumber) async {
    if (_isLoading) return;
    _isLoading = true;
    final ret = await _curationRepo.findAllCurations(searchOption);
    _isLoading = false;
    return ret.fold((l) => showError(l.desc), (r) {
      if (r.length < searchOption.pageSize) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, currentPageNumber + 1);
        _searchOption.value =
            searchOption.copyWith(pageNumber: currentPageNumber + 1);
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
  Future<bool> initialLoad() async {
    pagingController.itemList = [];
    pagingController.addPageRequestListener(_loadCurations);
    await Future.wait([_loadCode()]);
    return true;
  }
}
