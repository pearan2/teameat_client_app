import 'package:teameat/2_application/core/item_search_page_controller_mixin.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreItemSearchPageController extends ItemSearchPageController
    with ItemSearchPageControllerMixin {
  @override
  final SearchSimpleList initialSearchOption;

  @override
  final SearchableAddress? initialSelectedAddress;

  StoreItemSearchPageController({
    required this.initialSearchOption,
    required this.initialSelectedAddress,
  });
}
