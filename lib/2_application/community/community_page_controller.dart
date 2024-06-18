import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:teameat/99_util/get.dart';

class CommunityPageController extends PageController {
  // repos
  final _codeRepo = Get.find<ICodeRepository>();
  final _curationRepo = Get.find<ICurationRepository>();
  final _userRepo = Get.find<IUserRepository>();

  // states
  final _filterCodes = RxList<Code>.empty();
  final _searchOption = SearchCurationSimpleList.empty().obs;
  late final me = User.visitor().wrap(_userRepo.getMe);

  // controllers
  final PagingController<int, CurationSimple> pagingController =
      PagingController(firstPageKey: 0);

  // getter
  SearchCurationSimpleList get searchOption => _searchOption.value;
  List<Code> get filters => _filterCodes;

  void onCurationApplicationClicked() {
    react.toCommunityCreate();
  }

  void onFilterChanged(Code newFilter) {
    _searchOption.value =
        searchOption.copyWith(status: newFilter, pageNumber: 0);
    pagingController.refresh();
  }

  Future<void> _loadCode() async {
    return resolve(_codeRepo.getCode(CodeKey.curationFilter()),
        (codes) => _filterCodes.value = codes);
  }

  Future<void> _loadCurations(int currentPageNumber) async {
    final ret = await _curationRepo.findAll(searchOption);
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
