import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/not_found.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/store/like_page_controller.dart';
import 'package:teameat/3_domain/store/store.dart';

class StoreLikePage extends GetView<StoreLikePageController> {
  const StoreLikePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      appBar: TEAppBar(
        leadingIconOnPressed: controller.react.back,
        title: DS.text.followStore,
      ),
      body: Padding(
        padding: EdgeInsets.all(DS.space.xBase),
        child: TERefreshIndicator(
          onRefresh: () async {
            controller.pagingController.refresh();
          },
          child: PagedListView.separated(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<StoreSimple>(
              noItemsFoundIndicatorBuilder: (_) => Center(
                child: SimpleNotFound(
                  title: DS.text.followStoreNotFound,
                  buttonText: DS.text.goToSeeStore,
                  onTap: controller.react.toHomeOffAll,
                ),
              ),
              itemBuilder: (_, store, idx) => StoreSimpleInfoRow(
                profileImageUrl: store.profileImageUrl,
                name: store.name,
                subInfo: store.address,
                location: store.location,
                storeId: store.id,
              ),
            ),
            separatorBuilder: (_, idx) => Padding(
              padding: EdgeInsets.symmetric(vertical: DS.space.xSmall),
              child: Divider(
                color: DS.color.background600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
