import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/component/text_searcher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/home/home_page_controller.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    return Obx(
      () => TEScaffold(
        loadingText: DS.text.accessToLocationPleaseWait,
        loading: c.loading,
        onFloatingButtonClick: controller.onFloatingButtonClickHandler,
        activated: BottomNavigatorType.home,
        body: Padding(
          padding: EdgeInsets.only(top: topAreaHeight),
          child: RefreshIndicator(
            onRefresh: () async {
              controller.pageRefresh();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  key: controller.topKey,
                  backgroundColor: DS.color.background000,
                  surfaceTintColor: DS.color.background000,
                  snap: true,
                  floating: true,
                  toolbarHeight: DS.space.tiny,
                  expandedHeight:
                      GetPlatform.isAndroid ? DS.space.medium : null,
                  flexibleSpace: const HomePageSearcher(),
                ),
                PagedSliverList(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<StoreSimple>(
                    noItemsFoundIndicatorBuilder: (_) => const SearchNotFound(),
                    itemBuilder: (_, store, idx) => StoreCard(store: store),
                  ),
                ),
                SliverToBoxAdapter(child: DS.space.vSmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  final StoreSimple store;

  const StoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    /// 구매 할 수 있는 아이템이 하나도 없다면 아예 표기자체를 하지 않는다.
    /// 물론 표기만 안했지 item list 에는 존재하기 때문에 다음 것을 로딩하려고 시도한다.
    if (store.items.isEmpty) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppWidget.horizontalPadding),
          child: StoreSimpleInfoRow(
            location: store.location,
            storeId: store.id,
            profileImageUrl: store.profileImageUrl,
            name: store.name,
            subInfo: store.address,
          ),
        ),
        DS.space.vTiny,
        StoreItemList(
          items: store.items,
          borderRadius: DS.space.xTiny,
        ),
        DS.space.vXBase
      ],
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
      padding:
          const EdgeInsets.symmetric(horizontal: AppWidget.horizontalPadding),
      child: Row(
        children: [
          DS.image.mainIconSm,
          DS.space.hXSmall,
          Obx(
            () => Expanded(
              child: TextSearcher(
                onCompleted: controller.onSearchTextCompleted,
                value: controller.searchOption.searchText,
              ),
            ),
          ),
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
