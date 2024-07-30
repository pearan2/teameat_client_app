import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
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

  // states
  late final curation = CurationListDetail.empty().wrap(_loadCuration);
  final _isLoading = false.obs;

  final int curationId;

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

  Future<void> onCurationEdit() async {}

  Future<void> onCurationDelete() async {}

  Future<void> onShare() async {}

  Future<void> onBlock() async {
    _isLoading.value = true;
    final ret = await _blockRepo.blockCuration(curationId);
    _isLoading.value = false;
    ret.fold((l) => showError(l.desc), (r) {
      react.toCurationOffAll();
      showSuccess(DS.text.blockSuccess);
    });
  }

  Future<void> onReport(String? report) async {
    _isLoading.value = true;
    final ret = await _reportRepo.reportCuration(curationId, report);
    _isLoading.value = false;
    ret.fold((l) => showError(l.desc), (r) {
      showSuccess(DS.text.blockSuccess);
    });
  }

  CurationDetailViewPageController(this.curationId);
}
