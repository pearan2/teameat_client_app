import 'package:get/get.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';

class StorePageController extends PageController {
  final _storeRepo = Get.find<IStoreRepository>();

  final int storeId;

  final _store = StoreDetail.empty().obs;

  StoreDetail get store => _store.value;

  StorePageController({required this.storeId});

  Future<void> _loadStore() async {
    return resolve(_storeRepo.getStoreDetail(storeId), (s) => _store.value = s);
  }

  @override
  Future<bool> initialLoad() async {
    await _loadStore();
    return true;
  }
}
