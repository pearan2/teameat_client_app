import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/home/store_item_search_page_controller.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class StoreItemSearchPage extends GetView<StoreItemSearchPageController> {
  const StoreItemSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    final scrollController = ScrollController();

    return TEScaffold(
      onFloatingButtonClick: () {
        if (scrollController.hasClients) {
          scrollController.animateTo(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.bounceInOut);
        }
      },
      body: TERefreshIndicator(
        onRefresh: controller.refreshPage,
        child: CustomScrollView(
          controller: scrollController,
          physics: const ClampingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              backgroundColor: DS.color.background000,
              surfaceTintColor: DS.color.background000,
              snap: true,
              floating: true,
              primary: false,
              pinned: true,
              toolbarHeight: DS.space.large,
              flexibleSpace: const SearchTools(),
            ),
          ],
        ),
      ).paddingOnly(top: topAreaHeight),
    );
  }
}

class SearchTools extends GetView<StoreItemSearchPageController> {
  const SearchTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DS.space.large,
      padding: EdgeInsets.symmetric(
        horizontal: AppWidget.horizontalPadding,
        vertical: DS.space.tiny,
      ),
      child: Row(
        children: [
          Obx(() => TESelectorBottomSheet<SearchableAddress?>(
                candidates: [...c.searchableAddresses, null],
                onSelected: c.onSelectedAddressChanged,
                isEqual: (lhs, rhs) => lhs == rhs,
                toLabel: (v) {
                  if (v == null) {
                    return DS.text.noEupMyeonDongLimit;
                  } else {
                    return v.toLongLabel();
                  }
                },
                selectedValue: c.selectedAddress,
                title: c.searchableAddresses.length
                    .format(DS.text.numberOfServicedEupMyeonDongFormat),
                icon: TEAddressLabel(DS.text.all),
                iconActivated:
                    TEAddressLabel(c.selectedAddress?.toShortLabel() ?? ''),
              )),
          const Expanded(child: SizedBox()),
          Obx(() => TESelectorBottomSheet<int?>(
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
                selectedValue: controller.withInMeter,
                icon: DS.image.location.paddingAll(DS.space.xxTiny),
                iconActivated:
                    DS.image.locationActivated.paddingAll(DS.space.xxTiny),
              )),
        ],
      ),
    );
  }
}
