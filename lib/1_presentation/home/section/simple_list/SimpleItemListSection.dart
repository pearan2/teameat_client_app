// ignore_for_file: file_names

import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/1_presentation/home/section/common.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/main.dart';

class SimpleItemListSection extends StatefulWidget {
  final SearchSimpleList searchOption;
  final String title;
  final String Function(List<ItemSimple> items) descriptionBuilder;
  final double imageWidth;
  final double horizontalPadding;
  final int refreshCount;

  const SimpleItemListSection({
    super.key,
    required this.searchOption,
    required this.title,
    required this.descriptionBuilder,
    this.refreshCount = 0,
    this.imageWidth = 150,
    this.horizontalPadding = AppWidget.horizontalPadding,
  });

  @override
  State<SimpleItemListSection> createState() => _SimpleItemListSectionState();
}

class _SimpleItemListSectionState extends State<SimpleItemListSection> {
  bool isLoading = true;
  List<ItemSimple> items = [];
  final _storeRepo = Get.find<IStoreRepository>();
  final _react = Get.find<IReact>();

  Future<void> _loadItems() async {
    setState(() => isLoading = true);
    final ret = await _storeRepo.getStoreItems(widget.searchOption);
    ret.fold((l) => showError(l.desc), (r) {
      if (mounted) {
        setState(() {
          items = r;
          isLoading = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant SimpleItemListSection oldWidget) {
    if ((widget.searchOption != oldWidget.searchOption) ||
        (widget.refreshCount != oldWidget.refreshCount)) {
      _loadItems();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleAndSeeAll(
          title: widget.title,
          description: widget.descriptionBuilder(items),
          horizontalPadding: widget.horizontalPadding,
          onTap: () => Get.find<IReact>()
              .toStoreItemSearch(searchOption: widget.searchOption),
        ),
        DS.space.vTiny,
        SizedBox(
          height: StoreItemColumnCard.calcTotalHeight(widget.imageWidth),
          child: isLoading
              ? const Center(
                  child: TELoading(),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.horizontalPadding),
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, idx) => StoreItemColumnCard(
                    item: items[idx],
                    onTap: _react.toStoreItemDetail,
                    imageWidth: widget.imageWidth,
                    borderRadius: DS.space.xxTiny,
                  ),
                  separatorBuilder: (_, __) => DS.space.hTiny,
                  itemCount: items.length,
                ),
        )
      ],
    );
  }
}
