import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/community/curation/curation_status_text.dart';
import 'package:teameat/1_presentation/community/curation/curator_info_row.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/component/like.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/component/text_searcher.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/curation_page_controller.dart';
import 'package:teameat/2_application/core/login_checker.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class CurationPage extends GetView<CurationPageController> {
  const CurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    return Obx(() => TEScaffold(
          loading: c.isPageLoading,
          activated: BottomNavigatorType.community,
          floatingButtonIcon:
              Icon(Icons.post_add, color: DS.color.background000),
          onFloatingButtonClick: () => loginWrapper(c.react.toCurationCreate),
          body: Padding(
            padding: EdgeInsets.only(
              top: topAreaHeight,
            ),
            child: TERefreshIndicator(
              onRefresh: c.refreshPage,
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: DS.color.background000,
                    surfaceTintColor: DS.color.background000,
                    snap: true,
                    floating: true,
                    toolbarHeight: 0,
                    flexibleSpace: const CurationPageToolbar(),
                  ),
                  SliverToBoxAdapter(child: DS.space.vXSmall),
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
    return Container(
      alignment: Alignment.center,
      padding:
          const EdgeInsets.symmetric(horizontal: AppWidget.horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(DS.text.curation, style: DS.textStyle.paragraph2.semiBold.b800),
          DS.space.hXSmall,
          Expanded(
            child: Obx(
              () => TextSearcher(
                onCompleted: c.onSearchTextCompleted,
                value: controller.searchOption.searchText,
              ),
            ),
          ),
          DS.space.hXSmall,
          Obx(
            () => TESelectorBottomSheet<Code>(
              borderRadius: DS.space.tiny,
              candidates: c.orders,
              onSelected: c.onOrderChanged,
              isEqual: (lhs, rhs) => lhs.code == rhs.code,
              toLabel: (v) => v.title,
              selectedValue: c.searchOption.order,
              icon: DS.image.sort,
              iconActivated: DS.image.sort,
            ),
          ),
          DS.space.hXSmall,
          Obx(() => TESelectorBottomSheet<int?>(
                borderRadius: DS.space.tiny,
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
                icon: DS.image.location,
                iconActivated: DS.image.locationActivated,
              )),
        ],
      ),
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
            onTap: () => c.onCurationTapHandler(curation.id)),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(0, 0),
                      end: const Alignment(0, 1),
                      colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.4)
                      ],
                    ),
                  ),
                  child: CurationImageOverlay(curation),
                ),
              ),
            ],
          ),
          LikeAndCreatedAtRow(curation),
          NameAndOneLineIntroduceRow(curation),
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
      style: DS.textStyle.paragraph1.bold.b000,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DS.space.xSmall),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(child: _buildNameText()),
              DS.space.hSmall,
              CurationStatusText(curation, color: DS.color.background000)
            ],
          ),
          DS.space.vXSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    curation.store.name,
                    style: DS.textStyle.caption1.b000.h14,
                  ),
                  DS.space.vXXTiny,
                  Text(
                    curation.store.address,
                    style: DS.textStyle.caption2.b300.h14,
                  ),
                ],
              ),
              DistanceText(
                point: curation.store.location,
                textColor: DS.color.background000,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LikeAndCreatedAtRow extends StatelessWidget {
  final CurationListSimple curation;

  const LikeAndCreatedAtRow(this.curation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DS.space.xSmall,
        horizontal: DS.space.small,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Like<ICurationRepository>.small(
            curation.id,
            numberOfLikes: curation.numberOfLikes,
          ),
          Text(curation.createdAt.format(DS.text.curatorInfoDateFormat),
              style: DS.textStyle.caption2.b600),
        ],
      ),
    );
  }
}

class NameAndOneLineIntroduceRow extends StatelessWidget {
  final CurationListSimple curation;
  const NameAndOneLineIntroduceRow(this.curation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: DS.space.xSmall,
        horizontal: DS.space.small,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  curation.name,
                  style: DS.textStyle.paragraph3.semiBold.b800,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                DS.space.vTiny,
                Text(
                  curation.name,
                  style: DS.textStyle.caption1.semiBold.b500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}