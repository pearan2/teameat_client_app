import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/info_row.dart';
import 'package:teameat/1_presentation/core/component/map.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/clipboard.dart';
import 'package:teameat/2_application/store/store_page_controller.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StorePage extends GetView<StorePageController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final topAreaHeight = MediaQuery.of(context).padding.top;

    return TEScaffold(
        appBar: TEAppBar(
          leadingIconOnPressed: controller.react.back,
          homeOnPressed: controller.react.toHomeOffAll,
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: const SizedBox(),
              backgroundColor: DS.color.background000,
              surfaceTintColor: DS.color.background000,
              expandedHeight: width,
              flexibleSpace: c.store.obx((store) =>
                  TEImageCarousel(width: width, imageSrcs: store.imageUrls)),
            ),
            SliverAppBar(
              leading: const SizedBox(),
              backgroundColor: DS.color.background000,
              surfaceTintColor: DS.color.background000,
              pinned: true,
              toolbarHeight: DS.space.large + topAreaHeight,
              flexibleSpace: Container(
                padding: EdgeInsets.symmetric(horizontal: DS.space.xBase),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: DS.color.background100,
                            width: DS.space.xTiny))),
                child: c.store.obx(
                  (store) => StoreSimpleInfoRow(
                    profileImageUrl: store.profileImageUrl,
                    name: store.name,
                    subInfo: store.oneLineIntroduce,
                    storeId: store.id,
                    location: store.location,
                    isButton: false,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(DS.space.xBase),
                    child: c.store.obx(
                      (store) => TEonTap(
                        onTap: () => TEClipboard.setText(store.address),
                        child: InfoRow(
                          icon: DS.image.address,
                          title: DS.text.address,
                          content: store.address,
                        ),
                      ),
                    ),
                  ),
                  const TEDivider(),
                  c.store.obx((store) => TEStoreMap.single(
                        store: StorePoint.fromDetail(store),
                        height: MediaQuery.of(context).size.height / 3,
                        isLoading: controller.react.isEventLoading,
                      )),
                  const TEDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.space.xBase),
                    child: c.store.obx(
                      (store) => InfoRow(
                        icon: DS.image.store,
                        title: DS.text.storeIntroduce,
                        content: store.introduce,
                      ),
                    ),
                  ),
                  const TEDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.space.xBase),
                    child: c.store.obx(
                      (store) => TEonTap(
                        onTap: () => launchUrlString('tel:${store.phone}'),
                        child: InfoRow(
                          withUnderLine: true,
                          icon: DS.image.phone,
                          title: '${DS.text.reservation} / ${DS.text.question}',
                          content: store.phone,
                        ),
                      ),
                    ),
                  ),
                  const TEDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.space.xBase),
                    child: c.store.obx(
                      (store) => InfoRow(
                        icon: DS.image.clock,
                        title: DS.text.operationTime,
                        content: store.operationTime,
                      ),
                    ),
                  ),
                  const TEDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.space.xBase),
                    child: c.store.obx(
                      (store) => InfoRow(
                        icon: DS.image.clock,
                        title: DS.text.breakTime,
                        content: store.breakTime,
                      ),
                    ),
                  ),
                  const TEDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.space.xBase),
                    child: c.store.obx(
                      (store) => InfoRow(
                        icon: DS.image.clock,
                        title: DS.text.lastOrderTime,
                        content: store.lastOrderTime,
                      ),
                    ),
                  ),
                  const TEDivider()
                ],
              ),
            ),
            SliverToBoxAdapter(
                child: c.store.obx((store) => ListView.separated(
                      padding: EdgeInsets.all(DS.space.xBase),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, idx) => StoreItemRowCard(
                        item: store.items[idx],
                        onTap: controller.react.toStoreItemDetail,
                        borderRadius: DS.space.xBase,
                      ),
                      separatorBuilder: (_, __) => DS.space.vBase,
                      itemCount: store.items.length,
                    ))),
          ],
        ));
  }
}
