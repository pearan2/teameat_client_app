import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/item_search_page_controller_mixin.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreItemSearchPageController extends ItemSearchPageController
    with ItemSearchPageControllerMixin {
  @override
  final SearchSimpleList initialSearchOption;

  StoreItemSearchPageController({required this.initialSearchOption});

  late final TextEditingController searchTextController =
      TextEditingController(text: initialSearchOption.searchText);

  String get title =>
      initialSearchOption.category?.title ?? DS.text.itemSearchPageTitle;

  @override
  void beforeClearSearchOption() {
    searchTextController.text = '';
  }
}
