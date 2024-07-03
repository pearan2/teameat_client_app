import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/text_searcher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/home/home_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = (screenWidth -
            (AppWidget.horizontalPadding * 2) -
            (AppWidget.itemHorizontalSpace)) /
        2;

    final toolbarHeight = DS.space.base;
    return Obx(
      () => TEScaffold(
        loadingText: DS.text.accessToLocationPleaseWait,
        loading: c.loading,
        onFloatingButtonClick: controller.onFloatingButtonClickHandler,
        activated: BottomNavigatorType.home,
        body: Padding(
          padding: EdgeInsets.only(
            top: topAreaHeight,
            left: AppWidget.horizontalPadding,
            right: AppWidget.horizontalPadding,
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              controller.pageRefresh();
            },
            displacement: 0.0,
            edgeOffset: toolbarHeight + DS.space.large,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  key: controller.topKey,
                  backgroundColor: DS.color.background000,
                  surfaceTintColor: DS.color.background000,
                  snap: true,
                  floating: true,
                  toolbarHeight: toolbarHeight,
                  expandedHeight:
                      GetPlatform.isAndroid ? DS.space.medium : null,
                  flexibleSpace: const HomePageSearcher(),
                ),
                PagedSliverGrid(
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<ItemSimple>(
                      itemBuilder: (_, item, idx) => StoreItemColumnCard(
                          item: item,
                          onTap: (itemId) => c.react.toStoreItemDetail(itemId)),
                      noItemsFoundIndicatorBuilder: (_) =>
                          const SearchNotFound(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: imageWidth /
                          (imageWidth +
                              DS.space.large * 3 +
                              DS.space.base * 2), // Todo 비율 조정
                      crossAxisSpacing: DS.space.small,
                      mainAxisSpacing: DS.space.base,
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
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: DS.color.background000,
      ),
      child: Row(
        children: [
          DS.image.mainIconSm,
          DS.space.hXSmall,
          Obx(() => TESelectorBottomSheet<int?>(
                borderRadius: DS.space.tiny,
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
                icon: Icons.location_pin,
                selectedValue: controller.withInMeter,
                text: DS.text.distance,
              )),
          DS.space.hXSmall,
          Obx(
            () => Expanded(
              child: TextSearcher(
                onCompleted: controller.onSearchTextCompleted,
                value: controller.searchOption.searchText,
              ),
            ),
          ),
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
                      borderRadius: BorderRadius.circular(DS.space.xBase)),
                  child: StoreItemColumnCard(
                    item: controller.recommendedItem!,
                    borderRadius: DS.space.xBase,
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
