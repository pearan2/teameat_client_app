import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/1_presentation/home/section/common.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/main.dart';

class GroupBuyingSection extends StatefulWidget {
  final SearchableAddress? selectedAddress;
  final int refreshCount;
  const GroupBuyingSection(
      {super.key, this.selectedAddress, this.refreshCount = 0});

  @override
  State<GroupBuyingSection> createState() => _GroupBuyingSectionState();
}

class _GroupBuyingSectionState extends State<GroupBuyingSection> {
  bool isLoading = true;
  List<ItemSimple> items = [];
  final _storeRepo = Get.find<IStoreRepository>();

  Future<void> _loadItems() async {
    setState(() => isLoading = true);
    final ret = await _storeRepo.getStoreItems(
      SearchSimpleList.empty().copyWith(
        address: widget.selectedAddress?.toFullAddress(),
        pageSize: 5,
        sellType: 'GROUP_BUYING',
      ),
    );

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
  void didUpdateWidget(covariant GroupBuyingSection oldWidget) {
    if ((widget.selectedAddress != oldWidget.selectedAddress) ||
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
    return Container(
      color: DS.color.secondary300,
      padding: EdgeInsets.symmetric(vertical: DS.space.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TitleAndSeeAll(
            title: DS.text.groupBuyingSectionTitle,
            description: DS.text.groupBuyingSectionDescription,
            onTap: () => Get.find<IReact>().toGroupBuyingSearchPage(
                selectedAddress: widget.selectedAddress),
          ),
          DS.space.vTiny,
          isLoading
              ? const SizedBox(
                  height: GroupBuyingItemCard.defaultBoxHeight,
                  child: Center(child: TELoading()))
              : GroupBuyingSectionHorizontalList(items),
        ],
      ),
    );
  }
}

class GroupBuyingItemCard extends StatelessWidget {
  static const defaultBoxHeight = 175.0;
  static const defaultBoxWidth = 280.0;
  static const defaultImageWidth = 92.0;
  static const defaultImageHeight = 126.0;

  final ItemSimple item;
  final double boxWidth;
  final EdgeInsetsGeometry? padding;

  const GroupBuyingItemCard(
    this.item, {
    super.key,
    this.boxWidth = defaultBoxWidth,
    this.padding,
  });

  bool get isBigCard => boxWidth == double.infinity;

  Widget _buildGroupBuyingInfoContainer() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: DS.space.xTiny),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DS.space.xxTiny),
        color: DS.color.point500,
      ),
      child: _buildGroupBuyingInfoContent(),
    );
  }

  Widget _buildGroupBuyingInfoContent() {
    if (item.groupBuyingInfo == null) {
      return Text(
        DS.text.groupBuyingSectionGoToOpenGroupBuyingFormat,
        style: DS.textStyle.caption1.h14.b000,
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              TECacheImage(
                src: item.groupBuyingInfo!.openerProfileImageUrl,
                width: DS.space.small,
                ratio: 1 / 1,
                borderRadius: 300,
              ),
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: DS.color.background000),
                  borderRadius: BorderRadius.circular(300),
                ),
              )),
            ],
          ),
          DS.space.hXXTiny,
          Text(
            "${item.groupBuyingInfo!.openerNickname.substring(0, 2)}*${DS.text.sir}",
            style: DS.textStyle.caption1.h14.b000.semiBold,
          ),
          Text(
            DS.text.groupBuyingSectionGoToFinishGroupBuyingFormat,
            style: DS.textStyle.caption1.h14.b000,
          ),
        ],
      );
    }
  }

  Widget _buildRemainCount() {
    final textStyle = DS.textStyle.caption1.b500.h14;

    if (item.groupBuyingInfo == null) {
      return DS.space.vBase;
    }
    return Container(
      height: DS.space.base,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DS.space.xxTiny),
        color: DS.color.background100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(DS.text.groupBuyingSectionRemainDurationFormat,
              style: textStyle),
          TEDDateText(
            futurePoint: item.groupBuyingInfo!.willBeClosedAt,
            withMillis: false,
            style: textStyle,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => Get.find<IReact>().toStoreItemDetail(item.id, item: item),
      child: Container(
        width: boxWidth,
        height: defaultBoxHeight,
        padding: padding ?? EdgeInsets.all(DS.space.tiny),
        color: DS.color.background000,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: defaultImageHeight,
              child: Row(
                children: [
                  StoreItemImage.fromItemSimple(
                    item,
                    width: DS.space.big + DS.space.medium,
                    borderRadius: 0.0,
                    withCuratorInfo: false,
                    withSellTypeBadge: false,
                  ),
                  DS.space.hTiny,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Expanded(child: SizedBox()),
                        TELeftRightText(
                          item.storeName,
                          DistanceText(
                            point: item.storeLocation,
                            style: isBigCard
                                ? DS.textStyle.caption1.b500.h14
                                : DS.textStyle.caption2.b500.h14,
                            withDivider: true,
                          ),
                          useDefaultDivider: false,
                        ),
                        Text(
                          item.name,
                          style: isBigCard
                              ? DS.textStyle.paragraph2.medium.b800.h14
                              : DS.textStyle.paragraph3.medium.b800.h14,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const Expanded(child: SizedBox()),
                        StoreItemPrice(
                          originalPrice: item.originalPrice,
                          price: item.price,
                          originalPriceStyle: DS.textStyle.caption1.b500.h14,
                          priceStyle: DS.textStyle.paragraph2.bold.b800.h14,
                        ),
                        DS.space.vXTiny,
                        _buildRemainCount(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DS.space.vXTiny,
            _buildGroupBuyingInfoContainer(),
          ],
        ),
      ),
    );
  }
}

class GroupBuyingSectionHorizontalList extends StatelessWidget {
  final List<ItemSimple> items;

  const GroupBuyingSectionHorizontalList(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: GroupBuyingItemCard.defaultBoxHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.symmetric(horizontal: AppWidget.horizontalPadding),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, idx) => GroupBuyingItemCard(
          items[idx],
        ),
        separatorBuilder: (_, __) => DS.space.hXTiny,
        itemCount: items.length,
      ),
    );
  }
}
