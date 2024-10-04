import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
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
import 'package:teameat/main.dart';

class StoreItemSearchPage extends GetView<StoreItemSearchPageController> {
  const StoreItemSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final crossAxisSpacing = DS.space.tiny;

    final imageWidth =
        (MediaQuery.of(context).size.width - crossAxisSpacing) / 2;

    final scrollController = ScrollController();

    return TEScaffold(
      appBar: TEAppBar(title: c.title),
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

  @override
  Widget build(BuildContext context) {
    final locationTextStyle = DS.textStyle.paragraph3.semiBold.b800.h14;

    return Container(
      height: height,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
        left: AppWidget.horizontalPadding,
        right: AppWidget.horizontalPadding,
        bottom: DS.space.xBase,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
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
                      icon: TEAddressLabel(
                        DS.text.all,
                        style: locationTextStyle,
                      ),
                      iconActivated: TEAddressLabel(
                        c.selectedAddress?.toShortLabel() ?? '',
                        style: locationTextStyle,
                      ),
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
                      icon: TEAddressLabel(
                        DS.text.noDistanceLimit,
                        style: locationTextStyle,
                      ),
                      iconActivated: TEAddressLabel(
                        c.withInMeter?.format(DS.text.withInMeterFormat) ?? '',
                        style: locationTextStyle,
                      ),
                    )),
              ],
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: TextSearcher(
                  onCompleted: c.onSearchTextCompleted,
                  controller: c.searchTextController,
                  hintText: DS.text.itemSearchPageSearchTextHint,
                  autoFocus: false,
                ),
              ),
              DS.space.hTiny,
              TEPrimaryButton(
                onTap: () =>
                    c.onSearchTextCompleted(c.searchTextController.text),
                textStyle: DS.textStyle.caption1.semiBold,
                contentHorizontalPadding: DS.space.xTiny,
                text: DS.text.search,
                height: DS.space.base,
                fitContentWidth: true,
              )
            ],
          )),
          DS.space.vXTiny,
          Obx(
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
        ],
      ),
    );
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
