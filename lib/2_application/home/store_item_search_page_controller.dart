import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/item_search_page_controller_mixin.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreItemSearchPageController extends SearchPageController<ItemSimple>
    with ItemSearchPageControllerMixin<ItemSimple> {
  final _storeRepo = Get.find<IStoreRepository>();
  final _itemRepo = Get.find<IStoreItemRepository>();
  @override
  final SearchSimpleList initialSearchOption;

  StoreItemSearchPageController({required this.initialSearchOption});

  late final TextEditingController searchTextController =
      TextEditingController(text: initialSearchOption.searchText);

  String get title =>
      initialSearchOption.category?.title
          .replaceAll('\n', ' ')
          .replaceAll(' ', ', ') ??
      DS.text.itemSearchPageTitle;

  @override
  void beforeClearSearchOption() {
    searchTextController.text = '';
  }

  @override
  DataLoader<ItemSimple> get dataLoader => _storeRepo.getStoreItems;

  @override
  RecommendDataLoader<ItemSimple>? get recommendDataLoader =>
      _itemRepo.findRecommendedItems;
}
