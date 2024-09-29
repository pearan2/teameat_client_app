import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/not_found.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/1_presentation/home/section/group_buying/group_buying.dart';
import 'package:teameat/2_application/home/section/group_buying_search_page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class GroupBuyingSearchPage extends GetView<GroupBuyingSearchPageController> {
  const GroupBuyingSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        appBar: TEAppBar(
          leadingIconOnPressed: c.react.back,
          title: DS.text.groupBuyingSectionTitle,
          action: Obx(() => TESelectorBottomSheet<int?>(
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
        ),
        body: Column(
          children: [
            Container(
              height: DS.space.medium,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppWidget.horizontalPadding),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    c.initialSelectedAddress?.toShortLabel() ?? DS.text.all,
                    style: DS.textStyle.caption1.semiBold.h14.b700,
                  ),
                  Obx(
                    () => TESelectorBottomSheet<Code>(
                      candidates: c.orders,
                      onSelected: c.onOrderChanged,
                      isEqual: (lhs, rhs) => lhs.code == rhs.code,
                      toLabel: (v) => v.title,
                      selectedValue: c.searchOption.order,
                      icon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(c.searchOption.order?.title ?? DS.text.order,
                              style: DS.textStyle.caption1.b700.h14),
                          DS.space.hXTiny,
                          DS.image.sort
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            DS.space.vXTiny,
            Expanded(
              child: TERefreshIndicator(
                onRefresh: c.refreshPage,
                child: PagedListView.separated(
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<ItemSimple>(
                      noItemsFoundIndicatorBuilder: (_) => Center(
                        child: SimpleNotFound(
                          title: DS.text.searchNotFound,
                          buttonText: DS.text.clearSearchOption,
                          onTap: c.clearSearchOption,
                        ),
                      ),
                      itemBuilder: (_, item, idx) => GroupBuyingItemCard(
                        item,
                        boxWidth: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: DS.space.tiny,
                            horizontal: AppWidget.horizontalPadding),
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox()),
              ),
            ),
          ],
        ));
  }
}
