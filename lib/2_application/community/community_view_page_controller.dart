import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/99_util/get.dart';

class CommunityViewPageController extends GetxController {
  final _curationRepo = Get.find<ICurationRepository>();

  late final curation = CurationDetail.empty().wrap(_loadCuration);

  final int curationId;

  Future<Either<Failure, CurationDetail>> _loadCuration() {
    return _curationRepo.findById(curationId);
  }

  CommunityViewPageController(this.curationId);
}
