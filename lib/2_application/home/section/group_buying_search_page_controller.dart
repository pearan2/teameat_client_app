import 'package:get/get.dart';
import 'package:teameat/2_application/core/item_search_page_controller_mixin.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';

class GroupBuyingSearchPageController extends SearchPageController<ItemSimple>
    with ItemSearchPageControllerMixin<ItemSimple> {
  final _storeRepo = Get.find<IStoreRepository>();

  @override
  final SearchSimpleList initialSearchOption;

  GroupBuyingSearchPageController({SearchableAddress? initialSelectedAddress})
      : initialSearchOption = SearchSimpleList.empty().copyWith(
          address: initialSelectedAddress,
          sellType: 'GROUP_BUYING',
          order: Code.orderEmpty(),
        );

  @override
  DataLoader<ItemSimple> get dataLoader => _storeRepo.getStoreItems;

  @override
  RecommendDataLoader<ItemSimple>? get recommendDataLoader => null;
}
