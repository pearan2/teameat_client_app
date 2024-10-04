import 'package:teameat/2_application/core/item_search_page_controller_mixin.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/store.dart';

class GroupBuyingSearchPageController extends ItemSearchPageController
    with ItemSearchPageControllerMixin {
  @override
  final SearchSimpleList initialSearchOption;

  GroupBuyingSearchPageController({SearchableAddress? initialSelectedAddress})
      : initialSearchOption = SearchSimpleList.empty().copyWith(
          address: initialSelectedAddress,
          sellType: 'GROUP_BUYING',
          order: Code.orderEmpty(),
        );
}
