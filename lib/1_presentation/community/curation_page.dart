import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/component/not_found.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/curation_page_controller.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/3_domain/core/i_likable_repository.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/99_util/extension/date_time.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';
import 'package:teameat/99_util/extension/string.dart';

class CurationPage extends GetView<CurationPageController> {
  const CurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    return TEScaffold(
      activated: BottomNavigatorType.community,
      body: Padding(
        padding: EdgeInsets.only(
          top: topAreaHeight,
          left: AppWidget.horizontalPadding,
          right: AppWidget.horizontalPadding,
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
              SliverToBoxAdapter(child: DS.space.vXBase),
              const CurationList(),
            ],
          ),
        ),
      ),
    );
  }
}

class CurationPageToolbar extends GetView<CurationPageController> {
  const CurationPageToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: DS.space.xSmall),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: DS.space.xBase * 2 + DS.space.xSmall),
          Text(DS.text.curation, style: DS.textStyle.paragraph2.semiBold.b800),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DS.image.map,
              DS.space.hXSmall,
              DS.image.location,
            ],
          ),
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
        noItemsFoundIndicatorBuilder: (_) => Center(
          child: SimpleNotFound(
            title: DS.text.curationNotFound,
            buttonText: DS.text.goToApplyMyFavoriteMenu,
            onTap: controller.react.toCommunityCreate,
          ),
        ),
        itemBuilder: (_, curation, idx) =>
            CurationCard(curation, key: ValueKey(curation.id)),
      ),
      separatorBuilder: (_, idx) => DS.space.vXSmall,
    );
  }
}

class CurationCard extends StatelessWidget {
  final CurationListSimple curation;

  const CurationCard(this.curation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DS.space.tiny),
        color: DS.color.background000,
        boxShadow: [
          BoxShadow(
            color: DS.color.background800.withOpacity(0.25),
            blurRadius: DS.space.xTiny,
            offset: Offset(0, DS.space.xTiny),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
              Positioned(
                  right: DS.space.xSmall,
                  top: DS.space.xSmall,
                  child: Like<ICurationRepository>.base(curation.id)),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(DS.space.xSmall),
            child:
                CuratorInfoRow(curation.curator, createdAt: curation.createdAt),
          )
        ],
      ),
    );
  }
}

class Like<T extends ILikableRepository> extends GetView<LikeController<T>> {
  final int targetId;
  final Widget liked;
  final Widget base;
  final int? numberOfLikes;

  const Like({
    super.key,
    required this.targetId,
    required this.liked,
    required this.base,
    this.numberOfLikes,
  });
  factory Like.base(int targetId, {int? numberOfLikes}) {
    return Like(
      targetId: targetId,
      liked: DS.image.iconLikeClicked,
      base: DS.image.iconLike,
      numberOfLikes: numberOfLikes,
    );
  }

  factory Like.border(int targetId, {int? numberOfLikes}) {
    return Like(
      targetId: targetId,
      liked: DS.image.iconLikeBorderClicked,
      base: DS.image.iconLikeBorder,
      numberOfLikes: numberOfLikes,
    );
  }

  Widget _buildContent() {
    final notIncludeMeLikeCount =
        (numberOfLikes ?? 0) - (controller.isLike(targetId) ? 1 : 0);

    if (numberOfLikes == null) {
      return Obx(
        () => controller.isLike(targetId) ? liked : base,
      );
    } else {
      return Obx(() {
        return Column(
          children: [
            c.isLike(targetId) ? liked : base,
            Text(
              (notIncludeMeLikeCount + (c.isLike(targetId) ? 1 : 0)).toString(),
              style: DS.textStyle.caption3.b000,
            )
          ],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => c.toggleLike(targetId),
      isLoginRequired: true,
      child: _buildContent(),
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

  Widget _buildSaleStatusTextBox() {
    final statusText = curation.getStatusText();
    if (statusText == null) {
      return const SizedBox();
    }
    return Container(
      width: DS.space.large,
      height: DS.space.base,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: DS.color.background000),
          borderRadius: BorderRadius.circular(DS.space.base)),
      child: Text(statusText, style: DS.textStyle.caption2.semiBold.b000),
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
              _buildSaleStatusTextBox()
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
                    style: DS.textStyle.caption2.b000.h14,
                  ),
                  DS.space.vXXTiny,
                  Text(
                    curation.store.address,
                    style: DS.textStyle.caption3.b300.h14,
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

class CuratorInfoRow extends StatelessWidget {
  final DateTime createdAt;
  final CurationListCuratorInfo curator;
  const CuratorInfoRow(this.curator, {super.key, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TECacheImage(
            src: curator.profileImageUrl,
            borderRadius: 300,
            width: DS.space.medium,
          ),
          DS.space.hXTiny,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  curator.nickname,
                  style: DS.textStyle.caption1.semiBold.b800.h14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                curator.oneLineIntroduce.isNotEmpty()
                    ? const Expanded(child: SizedBox())
                    : const SizedBox(),
                curator.oneLineIntroduce.isNotEmpty()
                    ? Text(
                        curator.oneLineIntroduce!,
                        style: DS.textStyle.caption3.b600.h14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          DS.space.hXTiny,
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              createdAt.format(DS.text.curatorInfoDateFormat),
              style: DS.textStyle.caption3.b600.h14,
            ),
          )
        ],
      ),
    );
  }
}
