import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/1_presentation/home/section/recent_store/recent_store_section.dart';
import 'package:teameat/2_application/home/store_search_page_controller.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';

class StoreSearchPage extends GetView<StoreSearchPageController> {
  const StoreSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final crossAxisSpacing = DS.space.tiny;

    final imageWidth =
        (MediaQuery.of(context).size.width - crossAxisSpacing) / 2;
    const imageRatio = 3 / 4;

    final scrollController = ScrollController();

    return TEScaffold(
      appBar: TEAppBar(
        title: DS.text.storeSearchPage,
        leadingIconOnPressed: c.react.back,
      ),
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
              automaticallyImplyLeading: false,
              snap: true,
              floating: true,
              primary: false,
              toolbarHeight: SearchTools.height,
              flexibleSpace: const SearchTools(),
            ),
            PagedSliverGrid(
                pagingController: c.pagingController,
                builderDelegate: PagedChildBuilderDelegate<StoreSimple>(
                  itemBuilder: (_, store, idx) => StoreSimpleColumnCard(
                    store: store,
                    onTap: c.react.toStoreDetail,
                    width: imageWidth,
                    height: imageWidth / imageRatio,
                  ),
                  noItemsFoundIndicatorBuilder: (_) => const SearchNotFound(),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: imageRatio, // Todo 비율 조정
                  crossAxisSpacing: crossAxisSpacing,
                  mainAxisSpacing: DS.space.xSmall,
                  crossAxisCount: 2,
                )),
            DS.space.vMedium.toSliver,
          ],
        ),
      ),
    );
  }
}

class SearchTools extends GetView<StoreSearchPageController> {
  static double height = (DS.space.large * 3);

  const SearchTools({super.key});

  Widget _buildLabelIcon(String label) {
    final locationTextStyle = DS.textStyle.caption1.semiBold.b700.h14;
    return TEAddressLabel(
      label,
      paddingBetweenLabelAndIcon: 0,
      style: locationTextStyle,
      iconSize: DS.space.xSmall,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: DS.space.medium,
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
                    icon: _buildLabelIcon(DS.text.all),
                    iconActivated: _buildLabelIcon(
                        c.selectedAddress?.toShortLabel() ?? ''),
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
                    selectedValue: c.withInMeter,
                    icon: _buildLabelIcon(DS.text.noDistanceLimit),
                    iconActivated: _buildLabelIcon(
                        c.withInMeter?.format(DS.text.withInMeterFormat) ?? ''),
                  )),
            ],
          ),
        ),
      ],
    ).withBasePadding;
  }
}

class SearchNotFound extends GetView<StoreSearchPageController> {
  const SearchNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DS.text.searchNotFound,
            style:
                DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.w500),
          ),
          DS.space.vTiny,
          TEPrimaryButton(
            onTap: c.clearSearchOption,
            text: DS.text.clearSearchOption,
            contentHorizontalPadding: DS.space.small,
            fitContentWidth: true,
          ),
        ],
      ),
    );
  }
}
