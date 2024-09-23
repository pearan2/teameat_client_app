import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/community/curation/curator_info_row.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/component/like.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/text_searcher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/curation_page_controller.dart';
import 'package:teameat/2_application/core/login_checker.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/4_infra/core/curation_search_history_repository.dart';
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class CurationPage extends GetView<CurationPageController> {
  const CurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    return Obx(() => TEScaffold(
          onPop: (didPop) => controller.react.toHomeOffAll(),
          loading: c.isPageLoading,
          activated: BottomNavigatorType.community,
          floatingButtonIcon:
              Icon(Icons.post_add, color: DS.color.background000),
          onFloatingButtonClick: () =>
              loginWrapper(() => c.react.toCurationCreate(null)),
          body: Padding(
            padding: EdgeInsets.only(
              top: topAreaHeight,
            ),
            child: TERefreshIndicator(
              onRefresh: c.refreshPage,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                slivers: [
                  SliverAppBar(
                    backgroundColor: DS.color.background000,
                    surfaceTintColor: DS.color.background000,
                    primary: false,
                    snap: true,
                    floating: true,
                    toolbarHeight:
                        DS.space.large + DS.space.medium + DS.space.tiny,
                    flexibleSpace: const CurationPageToolbar(),
                  ),
                  const CurationList(),
                ],
              ),
            ),
          ),
        ));
  }
}

class CurationPageToolbar extends GetView<CurationPageController> {
  const CurationPageToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppWidget.horizontalPadding),
          alignment: Alignment.center,
          height: DS.space.large,
          child: Stack(
            children: [
              Center(
                child: Text(DS.text.curation,
                    style: DS.textStyle.paragraph2.semiBold.b800),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: Obx(() => TESelectorBottomSheet<SearchableAddress?>(
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
                      icon: TEAddressLabel(DS.text.all),
                      iconActivated: TEAddressLabel(
                          c.selectedAddress?.toShortLabel() ?? ''),
                    )),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TEonTap(
                      onTap: c.react.toCurationRewardGuide,
                      child: DS.image.reward,
                    ),
                    DS.space.hXSmall,
                    Obx(() => TextSearchButton<CurationSearchHistoryRepository>(
                          onCompleted: c.onSearchTextCompleted,
                          value: controller.searchOption.searchText,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppWidget.horizontalPadding),
          alignment: Alignment.centerRight,
          height: DS.space.medium,
          child: Obx(
            () => TESelectorBottomSheet<Code>(
              borderRadius: DS.space.tiny,
              candidates: c.orders,
              onSelected: c.onOrderChanged,
              isEqual: (lhs, rhs) => lhs.code == rhs.code,
              toLabel: (v) => v.title,
              selectedValue: c.searchOption.order,
              icon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.searchOption.order.title,
                      style: DS.textStyle.caption1.b700.h14),
                  DS.space.hXTiny,
                  DS.image.sort
                ],
              ),
            ),
          ),
        ),
        DS.space.vTiny,
      ],
    );
  }
}

class CurationList extends GetView<CurationPageController> {
  const CurationList({super.key});

  @override
  Widget build(BuildContext context) {
    return PagedSliverList.separated(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate<CurationListSimple>(
        noItemsFoundIndicatorBuilder: (_) =>
            const Center(child: CurationNotFound()),
        itemBuilder: (_, curation, idx) => CurationCard(curation,
            key: ValueKey(curation.id),
            onTap: () => c.onCurationTapHandler(curation.id, simple: curation)),
      ),
      separatorBuilder: (_, idx) => DS.space.vXSmall,
    );
  }
}

class CurationNotFound extends GetView<CurationPageController> {
  const CurationNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DS.space.xBase),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DS.text.searchedCurationNotFound,
            style: DS.textStyle.paragraph2.copyWith(
              fontWeight: FontWeight.w500,
            ),
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

class CurationCard extends StatelessWidget {
  final CurationListSimple curation;
  final void Function() onTap;

  const CurationCard(this.curation, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: onTap,
      isLoginRequired: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CuratorInfoRow(curation.curator).paddingSymmetric(
            vertical: DS.space.tiny,
            horizontal: DS.space.small,
          ),
          Stack(
            children: [
              TECacheImage(src: curation.imageUrl),
              Positioned.fill(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0, 0),
                      end: Alignment(0, 1),
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0),
                        Color.fromRGBO(0, 0, 0, 0.4),
                      ],
                    ),
                  ),
                  child: CurationImageOverlay(curation),
                ),
              ),
            ],
          ),
          DS.space.vXSmall,
          LikeRow(curation),
          DS.space.vSmall,
          OneLineIntroduceAndIntroducePreviewRow(curation),
          DS.space.vSmall,
          CreatedAtRow(curation),
          DS.space.vSmall,
        ],
      ),
    );
  }
}

class CurationImageOverlay extends StatelessWidget {
  final CurationListSimple curation;
  const CurationImageOverlay(this.curation, {super.key});

  Widget _buildNameText() {
    return Text(
      curation.name,
      style: DS.textStyle.paragraph1.bold.b000.h14,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppWidget.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNameText(),
          DS.space.vSmall,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                curation.store.name,
                style: DS.textStyle.caption1.b000.h14,
              ),
              DS.space.vXXTiny,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    curation.store.address,
                    style: DS.textStyle.caption2.b300.h14,
                  ),
                  DistanceText(
                      point: curation.store.location,
                      style: DS.textStyle.caption2.b300),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LikeRow extends StatelessWidget {
  final CurationListSimple curation;

  const LikeRow(this.curation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppWidget.horizontalPadding,
      ),
      child: Row(
        children: [
          Like<ICurationRepository>.baseRowShape(
            curation.id,
            numberOfLikes: curation.numberOfLikes,
          ),
          DS.space.hXSmall,
          (const StoreItemInSaleIcon()).orEmpty(curation.isInSale),
        ],
      ),
    );
  }
}

class CreatedAtRow extends StatelessWidget {
  final CurationListSimple curation;

  const CreatedAtRow(this.curation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppWidget.horizontalPadding,
      ),
      child: Text(curation.createdAt.format(DS.text.curatorInfoDateFormat),
          style: DS.textStyle.caption2.b500.h14),
    );
  }
}

class OneLineIntroduceAndIntroducePreviewRow extends StatelessWidget {
  final CurationListSimple curation;
  const OneLineIntroduceAndIntroducePreviewRow(this.curation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppWidget.horizontalPadding),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  curation.oneLineIntroduce,
                  style: DS.textStyle.paragraph3.semiBold.b800.h14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                DS.space.vXTiny,
                Text(
                  curation.introducePreview,
                  style: DS.textStyle.caption1.b500.h14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
