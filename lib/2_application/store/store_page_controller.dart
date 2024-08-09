import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/get.dart';

class StorePageController extends PageController {
  final _storeRepo = Get.find<IStoreRepository>();
  final _curationRepo = Get.find<ICurationRepository>();

  // states
  final _isLoading = false.obs;
  final int storeId;
  late final _searchOption = SearchCurationSimpleList.empty()
      .copyWith(storeId: storeId, pageSize: 5)
      .obs;
  late final PagingController<int, CurationListSimple> pagingController =
      PagingController(firstPageKey: 0);

// getter
  late final store = StoreDetail.empty().wrap(_loadStore);
  bool get isLoading => _isLoading.value;
  SearchCurationSimpleList get searchOption => _searchOption.value;

  StorePageController({required this.storeId});

  Future<Either<Failure, StoreDetail>> _loadStore() async {
    final ret = await _storeRepo.getStoreDetail(storeId);
    ret.fold((l) {
      Get.back();
      showError(l.desc);
    }, (r) => {});
    return ret;
  }

  Future<void> onShare() async {
    _isLoading.value = true;
    await Share.shareUri(
        Uri.https(Environment().linkBaseUrl, '/store/$storeId'));
    _isLoading.value = false;
  }

  Future<void> _loadCurations(int currentPageNumber) async {
    final ret = await _curationRepo.findAllCurations(searchOption);
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
  Future<bool> initialLoad() {
    pagingController.itemList = [];
    pagingController.addPageRequestListener(_loadCurations);
    return super.initialLoad();
  }
}
