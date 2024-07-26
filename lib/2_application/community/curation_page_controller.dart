import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';

class CurationPageController extends PageController {
  // repos
  final _codeRepo = Get.find<ICodeRepository>();
  final _curationRepo = Get.find<ICurationRepository>();

  // states
  final _orderCodes = RxList<Code>.empty();
  final _searchOption = SearchCurationSimpleList.empty().obs;
  bool _isLoading = false;

  // controllers
  final PagingController<int, CurationListSimple> pagingController =
      PagingController(firstPageKey: 0);

  // getter
  SearchCurationSimpleList get searchOption => _searchOption.value;
  List<Code> get orders => _orderCodes;

  Future<void> refreshPage() async {
    _searchOption.value = searchOption.copyWith(pageNumber: 0);
    pagingController.error = '';
    pagingController.refresh();
    pagingController.error = null;
  }

  Future<void> _loadCode() async {
    return resolve(_codeRepo.getCode(CodeKey.curationOrder()),
        (codes) => _orderCodes.value = codes);
  }

  Future<void> _loadCurations(int currentPageNumber) async {
    if (_isLoading) return;
    _isLoading = true;
    final ret = await _curationRepo.findCurationList(searchOption);
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
