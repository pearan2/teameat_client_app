import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:teameat/99_util/extension/string.dart';
import 'package:teameat/99_util/extension/text_style.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    return TEScaffold(
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
                backgroundColor: DS.color.background000,
                surfaceTintColor: DS.color.background000,
                snap: true,
                floating: true,
                expandedHeight: HomePageSearcher.homePageSearcherMaxHeight,
                flexibleSpace: const HomePageSearcher(),
              ),
              PagedSliverList(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<StoreSimple>(
                  noItemsFoundIndicatorBuilder: (_) => const SearchNotFound(),
                  itemBuilder: (_, store, idx) => Padding(
                    padding:
                        EdgeInsets.only(top: idx == 0 ? DS.space.xBase : 0),
                    child: StoreCard(store: store),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: DS.space.vSmall),
            ],
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
        Row(
          children: [
            DS.space.hSmall,
            Expanded(
              child: StoreSimpleInfoRow(
                storeId: store.id,
                profileImageUrl: store.profileImageUrl,
                name: store.name,
                subInfo: store.address,
              ),
            ),
            DS.space.hSmall
          ],
        ),
        DS.space.vTiny,
        StoreItemList(
          items: store.items,
          borderRadius: DS.space.tiny,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: DS.space.small),
          child: Divider(
            color: DS.color.background600,
          ),
        )
      ],
    );
  }
}

class HomePageSearcher extends GetView<HomePageController> {
  static const double homePageSearcherMaxHeight = 80.0;

  const HomePageSearcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: DS.color.background000,
        boxShadow: [
          BoxShadow(
              color: DS.color.background800.withOpacity(0.25),
              blurRadius: DS.space.xTiny,
              offset: Offset(0, DS.space.xTiny))
        ],
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: DS.space.small),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [DS.image.mainIconWithText],
            ),
            DS.space.vBase,
            Obx(
              () => TextSearcher(
                onCompleted: controller.onSearchTextCompleted,
                value: controller.searchOption.searchText,
              ),
            ),
          ],
        ),
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
                    ? DS.color.primary500
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
          DS.text.searchNotFound.style(DS.textStyle.paragraph3.w500()),
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
