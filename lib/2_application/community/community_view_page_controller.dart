import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:teameat/99_util/get.dart';

class CommunityViewPageController extends PageController {
  final _curationRepo = Get.find<ICurationRepository>();
  final _userRepo = Get.find<IUserRepository>();

  late final curation = MyCurationDetail.empty().wrap(_loadCuration);
  late final me = User.visitor().wrap(_userRepo.getMe);

  final int curationId;

  Future<Either<Failure, MyCurationDetail>> _loadCuration() {
    return _curationRepo.findById(curationId);
  }

  CommunityViewPageController(this.curationId);
}
