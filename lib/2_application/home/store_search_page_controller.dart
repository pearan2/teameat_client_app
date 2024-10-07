import 'package:get/get.dart';
import 'package:teameat/2_application/core/search_page_controller_mixin.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreSearchPageController extends SearchPageController<StoreSimple>
    with SearchPageControllerMixin<StoreSimple> {
  final _storeRepo = Get.find<IStoreRepository>();
  @override
  final SearchSimpleList initialSearchOption;

  StoreSearchPageController({required this.initialSearchOption});

  @override
  DataLoader<StoreSimple> get dataLoader => _storeRepo.getStores;
}
