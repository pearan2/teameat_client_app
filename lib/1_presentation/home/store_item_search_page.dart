import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/text_searcher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/home/store_item_search_page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';

class StoreItemSearchPage extends GetView<StoreItemSearchPageController> {
  const StoreItemSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final crossAxisSpacing = DS.space.tiny;

    final imageWidth =
        (MediaQuery.of(context).size.width - crossAxisSpacing) / 2;

    final scrollController = ScrollController();

    return TEScaffold(
      appBar: TEAppBar(
        title: c.title,
        leadingIconOnPressed: c.react.back,
      ),
      onFloatingButtonClick: () {
        if (scrollController.hasClients) {
          scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceInOut);
        }
      },
      body: TERefreshIndicator(
        onRefresh: controller.refreshPage,
        child: CustomScrollView(
          controller: scrollController,
          physics: const ClampingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              backgroundColor: DS.color.background000,
              surfaceTintColor: DS.color.background000,
              automaticallyImplyLeading: false,
              snap: true,
              floating: true,
              primary: false,
              toolbarHeight: SearchTools.height,
              flexibleSpace: const SearchTools(),
            ),
            PagedSliverGrid(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<ItemSimple>(
                  itemBuilder: (_, item, idx) => StoreItemColumnCard(
                    imageWidth: imageWidth,
                    item: item,
                    infoBoxHorizontalPadding: DS.space.tiny,
                    onTap: c.react.toStoreItemDetail,
                  ),
                  noItemsFoundIndicatorBuilder: (_) => const SearchNotFound(),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: imageWidth /
                      StoreItemColumnCard.calcTotalHeight(
                          imageWidth), // Todo 비율 조정
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: DS.space.xBase,
                  crossAxisCount: 2,
                )),
            DS.space.vMedium.toSliver,
          ],
        ),
      ),
    );
  }
}

class SearchTools extends GetView<StoreItemSearchPageController> {
  static double height = (DS.space.large * 2) + DS.space.xBase;

  const SearchTools({super.key});

  Widget _buildLabelIcon(String label) {
    final locationTextStyle = DS.textStyle.caption1.semiBold.b700.h14;
    return TEAddressLabel(
      label,
      paddingBetweenLabelAndIcon: 0,
      style: locationTextStyle,
      iconSize: DS.space.xSmall,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: DS.space.medium,
          child: Row(
            children: [
              Obx(() => TESelectorBottomSheet<SearchableAddress?>(
                    candidates: [...c.searchableAddresses, null],
                    onSelected: c.onSelectedAddressChanged,
                    isEqual: (lhs, rhs) => lhs == rhs,
                    toLabel: (v) {
                      if (v == null) {
                        return DS.text.noEupMyeonDongLimit;
                      } else {
                        return v.toLongLabel();
                      }
                    },
                    selectedValue: c.selectedAddress,
                    title: c.searchableAddresses.length
                        .format(DS.text.numberOfServicedEupMyeonDongFormat),
                    icon: _buildLabelIcon(DS.text.all),
                    iconActivated: _buildLabelIcon(
                        c.selectedAddress?.toShortLabel() ?? ''),
                  )),
              const Expanded(child: SizedBox()),
              Obx(() => TESelectorBottomSheet<int?>(
                    candidates: const [500, 1000, 2000, null],
                    onSelected: c.onWithInMeterChanged,
                    isEqual: (lhs, rhs) => lhs == rhs,
                    toLabel: (v) {
                      if (v == null) {
                        return DS.text.noDistanceLimit;
                      } else {
                        return v.format(DS.text.withInMeterFormat);
                      }
                    },
                    selectedValue: c.withInMeter,
                    icon: _buildLabelIcon(DS.text.noDistanceLimit),
                    iconActivated: _buildLabelIcon(
                        c.withInMeter?.format(DS.text.withInMeterFormat) ?? ''),
                  )),
            ],
          ),
        ),
        Container(
            alignment: Alignment.center,
            height: DS.space.large,
            child: TextSearcher(
              onCompleted: c.onSearchTextCompleted,
              controller: c.searchTextController,
              prefixLeftPadding: DS.space.xSmall,
              padding: EdgeInsets.symmetric(
                  vertical: DS.space.tiny, horizontal: DS.space.xSmall),
              hintText: DS.text.itemSearchPageSearchTextHint,
              needToActiveBuildActionButton: (value) => value.length >= 2,
              actionButtonBuilder: (value, isActive, unFocus) => TEonTap(
                onTap: () {
                  if (!isActive) return;
                  unFocus();
                  c.onSearchTextCompleted(value);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: DS.space.medium,
                  height: DS.space.xBase,
                  decoration: BoxDecoration(
                    color:
                        isActive ? DS.color.primary600 : DS.color.background000,
                    borderRadius: BorderRadius.circular(DS.space.xTiny),
                  ),
                  child: Text(
                    DS.text.searchButtonShortText,
                    style: DS.textStyle.caption2.semiBold.copyWith(
                      color: isActive
                          ? DS.color.background000
                          : DS.color.background600,
                    ),
                  ),
                ),
              ),
              autoFocus: false,
            )),
        SizedBox(
          height: DS.space.medium,
          child: Obx(
            () => TESelectorBottomSheet<Code>(
              candidates: c.orders,
              onSelected: c.onOrderChanged,
              isEqual: (lhs, rhs) => lhs.code == rhs.code,
              toLabel: (v) => v.title,
              selectedValue: c.searchOption.order,
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.searchOption.order?.title ?? DS.text.order,
                      style: DS.textStyle.caption1.b700.h14),
                  DS.space.hXTiny,
                  DS.image.sort
                ],
              ),
            ),
          ),
        ),
      ],
    ).withBasePadding;
  }
}

class SearchNotFound extends GetView<StoreItemSearchPageController> {
  const SearchNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DS.text.searchNotFound,
            style:
                DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.w500),
          ),
          DS.space.vTiny,
          TEPrimaryButton(
            onTap: controller.clearSearchOption,
            text: DS.text.clearSearchOption,
            contentHorizontalPadding: DS.space.small,
            fitContentWidth: true,
          ),
          Obx(() {
            if (controller.recommendedItem == null) {
              return const SizedBox();
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DS.space.vBase,
                Text(
                  DS.text.howAboutThisItem,
                  style: DS.textStyle.paragraph2,
                ),
                DS.space.vTiny,
                Container(
                  padding: EdgeInsets.all(DS.space.tiny),
                  decoration: BoxDecoration(
                      border: Border.all(color: DS.color.background600),
                      borderRadius: BorderRadius.circular(DS.space.tiny)),
                  child: StoreItemColumnCard(
                    item: controller.recommendedItem!,
                    borderRadius: DS.space.tiny,
                    onTap: controller.react.toStoreItemDetail,
                  ),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
