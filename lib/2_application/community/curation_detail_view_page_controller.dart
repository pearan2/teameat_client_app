import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:teameat/99_util/get.dart';

class CurationDetailViewPageController extends PageController {
  // repos
  final _curationRepo = Get.find<ICurationRepository>();
  final _userRepo = Get.find<IUserRepository>();

  // states
  late final curation = CurationListDetail.empty().wrap(_loadCuration);
  late final me = User.visitor().wrap(_userRepo.getMe);

  final int curationId;

  Future<Either<Failure, CurationListDetail>> _loadCuration() async {
    final ret = await _curationRepo.findCurationDetailById(curationId);
    ret.fold((l) {
      react.back(closeOverlays: true);
      showError(DS.text.alreadyDeletedOrBlockedCuration);
    }, (r) => {});
    return ret;
  }

  Future<void> onShare() async {}

  CurationDetailViewPageController(this.curationId);
}
