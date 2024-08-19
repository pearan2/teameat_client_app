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
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = (screenWidth - (AppWidget.itemHorizontalSpace / 2)) / 2;

    return TEScaffold(
        appBar: TEAppBar(
          leadingIconOnPressed: controller.react.back,
          title: DS.text.like,
        ),
        body: TERefreshIndicator(
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
                        imageWidth: imageWidth,
                        item: item,
                        onTap: controller.react.toStoreItemDetail)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: imageWidth /
                      StoreItemColumnCard.calcTotalHeight(
                          imageWidth), // Todo 비율 조정
                  crossAxisSpacing: DS.space.tiny,
                  mainAxisSpacing: DS.space.xBase,
                  crossAxisCount: 2,
                ),
              ),
            ],
          ),
        ));
  }
}
