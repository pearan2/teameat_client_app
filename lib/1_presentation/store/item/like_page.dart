import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/store/item/like_page_controller.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class LikePage extends GetView<LikePageController> {
  const LikePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return TEScaffold(
        appBar: TEAppBar(
          leadingIconOnPressed: controller.react.back,
          title: DS.text.like,
        ),
        body: Padding(
          padding: EdgeInsets.all(DS.space.xBase),
          child: RefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
            },
            child: CustomScrollView(
              slivers: [
                PagedSliverGrid(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<ItemSimple>(
                      noItemsFoundIndicatorBuilder: (_) =>
                          const Center(child: LikeItemsNotFound()),
                      itemBuilder: (_, item, idx) => StoreItemColumnCard(
                          borderRadius: DS.space.xBase,
                          item: item,
                          onTap: controller.react.toStoreItemDetail)),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: width / (width + DS.space.large * 5),
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

class LikeItemsNotFound extends GetView<LikePageController> {
  const LikeItemsNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DS.space.xBase),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DS.text.likeStoreItemsNotFound,
            style: DS.textStyle.paragraph2.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          DS.space.vTiny,
          TEPrimaryButton(
            onTap: controller.react.toHomeOffAll,
            text: DS.text.goToSeeStoreItems,
            contentHorizontalPadding: DS.space.small,
            fitContentWidth: true,
          ),
        ],
      ),
    );
  }
}
