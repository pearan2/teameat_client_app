import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teameat/0_config/environment.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/2_application/user/user_curation_page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/user/block/i_user_block_repository.dart';
import 'package:teameat/3_domain/user/report/i_report_repository.dart';
import 'package:teameat/99_util/get.dart';

class CurationDetailViewPageController extends PageController {
  // repos
  final _curationRepo = Get.find<ICurationRepository>();
  final _reportRepo = Get.find<IReportRepository>();
  final _blockRepo = Get.find<IUserBlockRepository>();

  final _empty = CurationListDetail.empty();

  // states
  late final curation =
      (simple == null ? _empty : CurationListDetail.fromSimple(simple!))
          .wrap(_loadCuration, emptyValue: _empty);
  final _isLoading = false.obs;

  final int curationId;
  final CurationListSimple? simple;

  CurationDetailViewPageController(this.curationId, {this.simple});

  // getter
  bool get isLoading => _isLoading.value;

  Future<Either<Failure, CurationListDetail>> _loadCuration() async {
    final ret = await _curationRepo.findCurationDetailById(curationId);
    ret.fold((l) {
      react.back(closeOverlays: true);
      showError(DS.text.alreadyDeletedOrBlockedCuration);
    }, (r) => {});
    return ret;
  }

  Future<void> onCurationEdit() async {
    if (!curation.value.isMine) {
      return showError(DS.text.invalidAccessPleaseContentDeveloper);
    }
    _isLoading.value = true;
    final ret = await _curationRepo.findMyCurationById(curationId);
    _isLoading.value = false;
    ret.fold((l) => showError(l.desc), (r) async {
      final needToRefresh = await react.toCurationCreate(r);
      if (needToRefresh) {
        curation.load();
      }
    });
  }

  Future<void> onCurationDelete() async {
    if (!curation.value.isMine) {
      return showError(DS.text.invalidAccessPleaseContentDeveloper);
    }
    _isLoading.value = true;
    final ret = await _curationRepo.deleteCuration(curationId);
    _isLoading.value = false;
    ret.fold((l) => showError(l.desc), (r) {
      // 내가쓴 푸드로그에서 접근한 것이라는 뜻
      if (Get.isRegistered<UserCurationPageController>()) {
        react.toUserOffAll();
        react.toUserCuration();
        showSuccess(DS.text.deleteSuccess);
      } else {
        react.toCurationOffAll();
        showSuccess(DS.text.deleteSuccess);
      }
    });
  }

  Future<void> onShare() async {
    _isLoading.value = true;
    await Share.shareUri(
        Uri.https(Environment().linkBaseUrl, '/food-log/$curationId'));
    _isLoading.value = false;
  }

  Future<void> onBlock() async {
    if (curation.value.isMine) {
      return showError(DS.text.invalidAccessPleaseContentDeveloper);
    }

    _isLoading.value = true;
    final ret = await _blockRepo.blockCuration(curationId);
    _isLoading.value = false;
    ret.fold((l) => showError(l.desc), (r) {
      react.toCurationOffAll();
      showSuccess(DS.text.blockSuccess);
    });
  }

  Future<void> onReport(String? report) async {
    if (curation.value.isMine) {
      return showError(DS.text.invalidAccessPleaseContentDeveloper);
    }

    _isLoading.value = true;
    final ret = await _reportRepo.reportCuration(curationId, report);
    _isLoading.value = false;
    ret.fold((l) => showError(l.desc), (r) {
      showSuccess(DS.text.reportSuccess);
    });
  }
}
