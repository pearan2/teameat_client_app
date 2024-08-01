import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/user/block/i_user_block_repository.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/report/i_report_repository.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:teameat/99_util/get.dart';

class CuratorSummaryViewPageController extends PageController {
  final _curationRepo = Get.find<ICurationRepository>();
  final _userRepo = Get.find<IUserRepository>();
  final _reportRepo = Get.find<IReportRepository>();
  final _blockRepo = Get.find<IUserBlockRepository>();

  late final summary = Summary.empty().wrap(_loadSummary);

  final int curatorId;

  final PagingController<int, CurationListSimple> pagingController =
      PagingController(firstPageKey: 0);
  late SearchCurationSimpleList searchOption =
      SearchCurationSimpleList.empty().copyWith(curatorId: curatorId);
  final _isLoading = false.obs;

  CuratorSummaryViewPageController(this.curatorId);

  bool get isLoading => _isLoading.value;

  Future<void> _loadCurations(int currentPageNumber) async {
    final ret = await _curationRepo.findAllCurations(searchOption);
    return ret.fold((l) => showError(l.desc), (r) {
      if (r.length < searchOption.pageSize) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, currentPageNumber + 1);
        searchOption = searchOption.copyWith(pageNumber: currentPageNumber + 1);
      }
    });
  }

  Future<Either<Failure, Summary>> _loadSummary() async {
    final ret = await _userRepo.getUserSummary(curatorId);
    ret.fold((l) {
      react.back();
      showError(DS.text.alreadyBlockedUser);
    }, (r) => {});
    return ret;
  }

  Future<void> onBlock() async {
    if (summary.value.isMe) {
      return showError(DS.text.invalidAccessPleaseContentDeveloper);
    }
    _isLoading.value = true;
    final ret = await _blockRepo.blockUser(curatorId);
    _isLoading.value = false;
    ret.fold((l) => showError(l.desc), (r) {
      react.toCurationOffAll();
      showSuccess(DS.text.blockSuccess);
    });
  }

  Future<void> onReport(String? report) async {
    if (summary.value.isMe) {
      return showError(DS.text.invalidAccessPleaseContentDeveloper);
    }
    _isLoading.value = true;
    final ret = await _reportRepo.reportUser(curatorId, report);
    _isLoading.value = false;
    ret.fold((l) => showError(l.desc), (r) {
      showSuccess(DS.text.reportSuccess);
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
