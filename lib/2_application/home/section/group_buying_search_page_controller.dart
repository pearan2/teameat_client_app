import 'package:teameat/2_application/core/item_search_page_controller_mixin.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/store.dart';

class GroupBuyingSearchPageController extends ItemSearchPageController
    with ItemSearchPageControllerMixin {
  @override
  SearchSimpleList get initialSearchOption => SearchSimpleList.empty().copyWith(
        address: initialSelectedAddress?.toFullAddress(),
        sellType: 'GROUP_BUYING',
        order: Code.orderEmpty(),
      );

  @override
  final SearchableAddress? initialSelectedAddress;

  GroupBuyingSearchPageController({this.initialSelectedAddress});
}
