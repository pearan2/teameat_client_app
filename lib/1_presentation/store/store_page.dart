import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/store/store_page_controller.dart';

class StorePage extends GetView<StorePageController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final topAreaHeight = MediaQuery.of(context).padding.top;

    return TEScaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          leading: const SizedBox(),
          backgroundColor: DS.getColor().background000,
          surfaceTintColor: DS.getColor().background000,
          snap: true,
          floating: true,
          expandedHeight: width - topAreaHeight,
          flexibleSpace: Obx(
            () => StoreImageCarousel(
              width: width,
              height: width,
              store: controller.store,
            ),
          ),
        ),
        SliverAppBar(
          leading: const SizedBox(),
          backgroundColor: DS.getColor().background000,
          surfaceTintColor: DS.getColor().background000,
          pinned: true,
          toolbarHeight: DS.getSpace().large + topAreaHeight,
          flexibleSpace: Container(
            padding: EdgeInsets.symmetric(horizontal: DS.getSpace().xBase),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: DS.getColor().background400))),
            child: Obx(
              () => PageLoadingWrapper(
                child: StoreSimpleInfoRow(
                  profileImageUrl: controller.store.profileImageUrl,
                  name: controller.store.name,
                  subInfo: controller.store.oneLineIntroduce,
                  storeId: controller.storeId,
                  isButton: false,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(DS.getSpace().xBase),
                    child: PageLoadingWrapper(
                      child: StoreInfoRow(
                        icon: DS.getImage().storeLocation,
                        title: DS.getText().address,
                        content: controller.store.address,
                      ),
                    ),
                  ),
                  const StorePageDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.getSpace().xBase),
                    child: PageLoadingWrapper(
                      child: StoreInfoRow(
                        icon: DS.getImage().storeIntroduce,
                        title: DS.getText().storeIntroduce,
                        content: controller.store.introduce,
                      ),
                    ),
                  ),
                  const StorePageDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.getSpace().xBase),
                    child: PageLoadingWrapper(
                      child: StoreInfoRow(
                        icon: DS.getImage().storePhone,
                        title:
                            '${DS.getText().reservation} / ${DS.getText().question}',
                        content: controller.store.phone,
                      ),
                    ),
                  ),
                  const StorePageDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.getSpace().xBase),
                    child: PageLoadingWrapper(
                      child: StoreInfoRow(
                        icon: DS.getImage().storeOperationInfo,
                        title: DS.getText().operationTime,
                        content: controller.store.operationTime,
                      ),
                    ),
                  ),
                  const StorePageDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.getSpace().xBase),
                    child: PageLoadingWrapper(
                      child: StoreInfoRow(
                        icon: DS.getImage().storeOperationInfo,
                        title: DS.getText().breakTime,
                        content: controller.store.breakTime,
                      ),
                    ),
                  ),
                  const StorePageDivider(),
                  Padding(
                    padding: EdgeInsets.all(DS.getSpace().xBase),
                    child: PageLoadingWrapper(
                      child: StoreInfoRow(
                        icon: DS.getImage().storeOperationInfo,
                        title: DS.getText().lastOrderTime,
                        content: controller.store.lastOrderTime,
                      ),
                    ),
                  ),
                  const StorePageDivider()
                ],
              )),
        ),
        SliverToBoxAdapter(
            child: Obx(() => ListView.separated(
                  padding: EdgeInsets.all(DS.getSpace().xBase),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, idx) => StoreItemRowCard(
                    item: controller.store.items[idx],
                    onTap: controller.react.toStoreItemDetail,
                  ),
                  separatorBuilder: (_, __) => DS.getSpace().vBase,
                  itemCount: controller.store.items.length,
                )))
      ],
    ));
  }
}

class StorePageDivider extends StatelessWidget {
  const StorePageDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: DS.getColor().background400, height: 1, thickness: 1);
  }
}
