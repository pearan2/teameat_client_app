import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/text_searcher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/1_presentation/home/section/category/category_section.dart';
import 'package:teameat/1_presentation/home/section/group_buying/group_buying.dart';
import 'package:teameat/1_presentation/home/section/rank/rank_section.dart';
import 'package:teameat/1_presentation/home/section/recent_store/recent_store_section.dart';
import 'package:teameat/1_presentation/home/section/simple_list/SimpleItemListSection.dart';
import 'package:teameat/2_application/home/home_page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;

    final scrollController = ScrollController();

    final sectionHalfSpacing = DS.space.small;
    final sectionHalfSpacingWidget = SizedBox(height: sectionHalfSpacing);

    return Obx(
      () => TEScaffold(
        loadingText: DS.text.accessToLocationPleaseWait,
        loading: c.loading,
        onFloatingButtonClick: () {
          if (scrollController.hasClients) {
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceInOut);
          }
        },
        activated: BottomNavigatorType.home,
        body: Padding(
          padding: EdgeInsets.only(top: topAreaHeight),
          child: TERefreshIndicator(
            onRefresh: controller.refreshPage,
            child: CustomScrollView(
              controller: scrollController,
              physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverAppBar(
                  backgroundColor: DS.color.background000,
                  surfaceTintColor: DS.color.background000,
                  snap: true,
                  floating: true,
                  primary: false,
                  pinned: true,
                  toolbarHeight: DS.space.large,
                  flexibleSpace: const HomePageSearcher(),
                ),
                const HomePageTextSearcher().withBasePadding.toSliver,
                Obx(() => GroupBuyingSection(
                      selectedAddress: c.selectedAddress,
                      refreshCount: c.sectionRefreshCount,
                    )).toSliver,
                CategorySection(
                  onCategorySelected: (category) => c.react.toStoreItemSearch(
                    searchOption: SearchSimpleList.empty().copyWith(
                      address: c.selectedAddress,
                      category: category,
                    ),
                  ),
                ).toSliver,
                Obx(() => ItemRankSection(
                      address: c.selectedAddress,
                      verticalPadding: sectionHalfSpacing,
                    )).toSliver,
                sectionHalfSpacingWidget.toSliver,
                Obx(() => SimpleItemListSection(
                      searchOption:
                          SearchSimpleList.empty(withRandomSeed: false)
                              .copyWith(
                        address: c.selectedAddress,
                        order: Code.itemOrderManyLike(),
                        pageSize: 10,
                      ),
                      title: DS.text.itemManyLikeSectionTitle,
                      descriptionBuilder: (_) =>
                          DS.text.itemManyLikeSectionDescription,
                    )).toSliver,
                sectionHalfSpacingWidget.toSliver,
                Obx(() => CurationRankSection(
                      address: c.selectedAddress,
                      verticalPadding: sectionHalfSpacing,
                    )).toSliver,
                sectionHalfSpacingWidget.toSliver,
                Obx(() => SimpleItemListSection(
                      searchOption:
                          SearchSimpleList.empty(withRandomSeed: false)
                              .copyWith(
                        address: c.selectedAddress,
                        order: Code.itemHighDiscountRatio(),
                        pageSize: 10,
                      ),
                      title: DS.text.itemHighDiscountRatioSectionTitle,
                      descriptionBuilder: (items) => items.isNotEmpty
                          ? DS.text.itemHighDiscountRatioSectionDescription +
                              StoreItemPriceDiscountRateText.calcDiscountRatio(
                                      items[0].price, items[0].originalPrice)
                                  .format(DS.text
                                      .itemHighDiscountRatioSectionDescriptionFormat)
                          : '',
                    )).toSliver,
                sectionHalfSpacingWidget.toSliver,
                sectionHalfSpacingWidget.toSliver,
                Obx(() => RecentStoreSection(
                      title: DS.text.storeRecentSectionTitle,
                      description: DS.text.storeRecentSectionDescription,
                      address: c.selectedAddress,
                    )).toSliver,
                sectionHalfSpacingWidget.toSliver,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageSearcher extends GetView<HomePageController> {
  const HomePageSearcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DS.space.large,
      padding: EdgeInsets.symmetric(
        horizontal: AppWidget.horizontalPadding,
        vertical: DS.space.tiny,
      ),
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
                icon: TEAddressLabel(DS.text.all),
                iconActivated:
                    TEAddressLabel(c.selectedAddress?.toShortLabel() ?? ''),
              )),
          const Expanded(child: SizedBox()),
          Obx(() => TEonTap(
                onTap: c.onDistanceViewOn,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: DS.color.primary600,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: DS.space.tiny,
                    vertical: DS.space.tiny,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      DS.image.locationSmWhite,
                      DS.space.hXXTiny,
                      Text(
                        DS.text.viewDistanceBetweenMeAndStore,
                        style: DS.textStyle.caption1.b000.semiBold,
                      )
                    ],
                  ),
                ).orEmpty(!c.locationController.isPermitted),
              )),
        ],
      ),
    );
  }
}

class HomePageTextSearcher extends GetView<HomePageController> {
  const HomePageTextSearcher({super.key});

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => c.react.toStoreItemSearch(
          searchOption: SearchSimpleList.empty().copyWith(
        address: c.selectedAddress,
        order: Code.itemOrderManyLike(),
        pageSize: 10,
      )),
      child: Container(
        alignment: Alignment.center,
        height: DS.space.large,
        child: TextSearcher(
          onCompleted: (_) {},
          padding: EdgeInsets.symmetric(
            vertical: DS.space.tiny,
            horizontal: DS.space.tiny,
          ),
          prefixLeftPadding: DS.space.xSmall,
          enabled: false,
        ),
      ),
    );
  }
}
