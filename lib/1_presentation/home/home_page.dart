import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/text_searcher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/home/home_page_controller.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/4_infra/core/store_item_search_history_repository.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = (screenWidth - (AppWidget.itemHorizontalSpace / 2)) / 2;

    final scrollController = ScrollController();

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
          padding: EdgeInsets.only(
            top: topAreaHeight,
          ),
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
                  toolbarHeight: DS.space.large,
                  flexibleSpace: const HomePageSearcher(),
                ),
                DS.space.vXSmall.toSliver,
                PagedSliverGrid(
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<ItemSimple>(
                      itemBuilder: (_, item, idx) => StoreItemColumnCard(
                        imageWidth: imageWidth,
                        item: item,
                        onTap: c.react.toStoreItemDetail,
                      ),
                      noItemsFoundIndicatorBuilder: (_) =>
                          const SearchNotFound(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: imageWidth /
                          StoreItemColumnCard.calcTotalHeight(
                              imageWidth), // Todo 비율 조정
                      crossAxisSpacing: DS.space.tiny,
                      mainAxisSpacing: DS.space.xBase,
                      crossAxisCount: 2,
                    )),
                SliverToBoxAdapter(child: DS.space.vSmall),
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
          Obx(() => TextSearchButton<StoreItemSearchHistoryRepository>(
                onCompleted: c.onSearchTextCompleted,
                value: controller.searchOption.searchText,
              )),
          DS.space.hXSmall,
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
                selectedValue: controller.withInMeter,
                icon: DS.image.location.paddingAll(DS.space.xxTiny),
                iconActivated:
                    DS.image.locationActivated.paddingAll(DS.space.xxTiny),
              )),
        ],
      ),
    );
  }
}

class NearbyMe extends GetView<HomePageController> {
  const NearbyMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEonTap(
          onTap: controller.onNearbyMeClickHandler,
          child: Container(
            decoration: BoxDecoration(
                color: controller.isNearbyMe
                    ? DS.color.primary600
                    : DS.color.background500,
                borderRadius: BorderRadius.circular(300)),
            padding: EdgeInsets.symmetric(
                vertical: DS.space.xTiny, horizontal: DS.space.xSmall),
            child: Row(
              children: [
                Text(DS.text.nearbyMe,
                    style: DS.textStyle.caption3.copyWith(
                        color: DS.color.background000,
                        fontWeight: FontWeight.bold)),
                DS.space.hXTiny,
                DS.image.nearbyMeIcon,
              ],
            ),
          ),
        ));
  }
}

class SearchNotFound extends GetView<HomePageController> {
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
