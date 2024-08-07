import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/get.dart';

class StorePageController extends PageController {
  final _storeRepo = Get.find<IStoreRepository>();

  final int storeId;

  late final store = StoreDetail.empty().wrap(_loadStore);

  StorePageController({required this.storeId});

  Future<Either<Failure, StoreDetail>> _loadStore() async {
    final ret = await _storeRepo.getStoreDetail(storeId);
    ret.fold((l) {
      Get.back();
      showError(l.desc);
    }, (r) => {});
    return ret;
  }

  @override
  Future<bool> initialLoad() async {
    return true;
  }
}
