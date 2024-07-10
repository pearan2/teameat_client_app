import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/not_found.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/store/item/like_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/main.dart';

class StoreItemLikePage extends GetView<StoreItemLikePageController> {
  const StoreItemLikePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return TEScaffold(
        appBar: TEAppBar(
          leadingIconOnPressed: controller.react.back,
          title: DS.text.like,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          child: TERefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
            },
            child: CustomScrollView(
              slivers: [
                PagedSliverGrid(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ItemSimple>(
                      noItemsFoundIndicatorBuilder: (_) => Center(
                            child: SimpleNotFound(
                              title: DS.text.likeStoreItemsNotFound,
                              buttonText: DS.text.goToSeeStoreItems,
                              onTap: controller.react.toHomeOffAll,
                            ),
                          ),
                      itemBuilder: (_, item, idx) => StoreItemColumnCard(
                          borderRadius: DS.space.xTiny,
                          item: item,
                          onTap: controller.react.toStoreItemDetail)),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    /// 4/3 비율로 갈거라서 변경해줌
                    childAspectRatio:
                        width / (width * (4 / 3) + DS.space.large * 8),
                    crossAxisSpacing: DS.space.small,
                    mainAxisSpacing: DS.space.small,
                    crossAxisCount: 2,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
