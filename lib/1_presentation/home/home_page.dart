import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/component/text_searcher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/home/home_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      withBottomNavigator: true,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.pagingController.refresh();
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: DS.getColor().background000,
                surfaceTintColor: DS.getColor().background000,
                snap: true,
                floating: true,
                expandedHeight: HomePageSearcher.homePageSearcherMaxHeight,
                flexibleSpace: const HomePageSearcher(),
              ),
              PagedSliverList.separated(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<StoreSimple>(
                  itemBuilder: (_, store, idx) =>
                      idx == 0 ? const SizedBox() : StoreCard(store: store),
                ),
                separatorBuilder: (_, idx) => idx == 0
                    ? DS.getSpace().vBase
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: DS.getSpace().xSmall),
                        child: Divider(
                          color: DS.getColor().background600,
                        ),
                      ),
              ),
              SliverToBoxAdapter(child: DS.getSpace().vSmall),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            DS.getSpace().hSmall,
            Expanded(
              child: StoreSimpleInfoRow(
                storeId: store.id,
                profileImageUrl: store.profileImageUrl,
                name: store.name,
                subInfo: store.address,
              ),
            ),
            DS.getSpace().hLarge,
          ],
        ),
        DS.getSpace().vTiny,
        StoreItemList(items: store.items)
      ],
    );
  }
}

class StoreItemList extends GetView<HomePageController> {
  final List<ItemSimple> items;

  const StoreItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: DS.getSpace().small),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Padding(
                  padding: EdgeInsets.only(right: DS.getSpace().small),
                  child: StoreItemColumnCard(
                      item: item,
                      onTap: controller.onStoreItemCardClickHandler),
                ))
            .toList(),
      ),
    );
  }
}

class HomePageSearcher extends StatelessWidget {
  static const double homePageSearcherMaxHeight = 124.0;

  const HomePageSearcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: DS.getColor().background000,
        boxShadow: [
          BoxShadow(
              color: DS.getColor().background800.withOpacity(0.25),
              blurRadius: DS.getSpace().xTiny,
              offset: Offset(0, DS.getSpace().xTiny))
        ],
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: DS.getSpace().small),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [DS.getImage().mainIconWithText],
            ),
            DS.getSpace().vBase,
            const TextSearcher(),
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
                    ? DS.getColor().primary500
                    : DS.getColor().background500,
                borderRadius: BorderRadius.circular(300)),
            padding: EdgeInsets.symmetric(
                vertical: DS.getSpace().xTiny,
                horizontal: DS.getSpace().xSmall),
            child: Row(
              children: [
                Text(DS.getText().nearbyMe,
                    style: DS.getTextStyle().caption3.copyWith(
                        color: DS.getColor().background000,
                        fontWeight: FontWeight.bold)),
                DS.getSpace().hXTiny,
                DS.getImage().nearbyMeIcon,
              ],
            ),
          ),
        ));
  }
}
