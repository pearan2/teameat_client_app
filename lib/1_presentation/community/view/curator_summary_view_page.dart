import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/community/core/report.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/1_presentation/user/follow/follow_card.dart';
import 'package:teameat/2_application/community/curator_summary_view_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';
import 'package:teameat/99_util/extension/string.dart';

class CuratorSummaryViewPage extends GetView<CuratorSummaryViewPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const CuratorSummaryViewPage(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEScaffold(
        loading: c.isLoading,
        appBar: TEAppBar(
          leadingIconOnPressed: c.react.back,
          titleWidget: c.summary.obx((summary) => Text(
                summary.nickname,
                style: DS.textStyle.paragraph2
                    .copyWith(fontWeight: FontWeight.bold),
              )),
          action: CuratorTool(tag),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CuratorSummaryRow(tag),
              c.summary.obx((s) => s.oneLineIntroduce.isEmpty()
                  ? const SizedBox()
                  : DS.space.vSmall),
              c.summary.obx((s) => s.oneLineIntroduce.isEmpty()
                  ? const SizedBox()
                  : Text(s.oneLineIntroduce!,
                      style: DS.textStyle.caption2.b500.h14)),
              DS.space.vLarge,
              DS.space.vXSmall,
              Expanded(child: CuratorCurationGrid(tag)),
              GetPlatform.isIOS ? DS.space.vXSmall : const SizedBox(),
            ],
          ),
        )));
  }
}

class CuratorTool extends GetView<CuratorSummaryViewPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const CuratorTool(this.tag, {super.key});

  Widget _buildHomeButton() {
    return TEonTap(
        onTap: c.react.toCurationOffAll,
        child: Center(child: DS.image.iconHome));
  }

  Widget _buildControlTool() {
    return TESelectorBottomSheet<String>(
      selectedValue: "",
      candidates: [DS.text.blockThisUser, DS.text.reportThisUser],
      getDefaultColor: (s) =>
          s == DS.text.reportThisUser ? DS.color.point500 : null,
      isLoginRequested: true,
      onSelected: (s) async {
        if (s == DS.text.blockThisUser) {
          final ret = await showTEConfirmDialog(
                content: DS.text.areYouSUreToBlockThisUser,
                leftButtonText: DS.text.no,
                rightButtonText: DS.text.yesIWillBlockThis,
              ) ??
              false;
          if (!ret) return;
          c.onBlock();
        } else if (s == DS.text.reportThisUser) {
          await showReport(c.onReport);
        }
      },
      icon: DS.image.more(DS.color.background700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return c.summary.obx((summary) {
      if (summary.isMe) {
        return _buildHomeButton();
      } else {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHomeButton(),
            DS.space.hXSmall,
            _buildControlTool(),
          ],
        );
      }
    });
  }
}

class CuratorSummaryRow extends GetView<CuratorSummaryViewPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  static const imageWidth = 76.0;
  const CuratorSummaryRow(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DS.space.tiny),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            c.summary.obx((s) => TECacheImage(
                  src: s.profileImageUrl,
                  width: imageWidth,
                  borderRadius: 300,
                )),
            DS.space.hBase,
            Expanded(child: c.summary.obx((s) {
              if (s.isMe) {
                return CuratorSummaryNumberRow(tag);
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CuratorSummaryNumberRow(tag),
                    Follow(
                      c.curatorId,
                      height: DS.space.base,
                      width: double.infinity,
                    ),
                  ],
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}

class CuratorSummaryNumberRow
    extends GetView<CuratorSummaryViewPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const CuratorSummaryNumberRow(this.tag, {super.key});

  Widget _buildTextAndCount(String text, num count, void Function() onTap) {
    final textStyle = DS.textStyle.caption2.b500;
    final countStyle = DS.textStyle.caption2.b700;
    return TEonTap(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: textStyle),
          DS.space.vXTiny,
          Text(count.strClamp(max: 9999), style: countStyle),
        ],
      ),
    );
  }

  void onTextAndCountTap(
      final Future<List<Follower>> Function(int pageNumber, int pageSize)
          getFollower) {
    showTEBottomSheet(
        _FollowerList(
          getFollower: getFollower,
          onFollowerCardTap: (follower) =>
              c.react.toCuratorSummary(follower.id),
        ),
        withBar: true,
        withClose: true);
  }

  @override
  Widget build(BuildContext context) {
    return c.summary.obx((s) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTextAndCount(DS.text.follower, s.numberOfFollowers, () {
              if (s.numberOfFollowers == 0) return;
              onTextAndCountTap(c.loadFollowers);
            }),
            _buildTextAndCount(DS.text.following, s.numberOfFollowings, () {
              if (s.numberOfFollowings == 0) return;
              onTextAndCountTap(c.loadFollowings);
            }),
            _buildTextAndCount(DS.text.curation, s.numberOfCurations, () {}),
            _buildTextAndCount(DS.text.commercialization,
                s.numberOfCommercializedCurations, () {}),
          ],
        ));
  }
}

class CuratorCurationGrid extends GetView<CuratorSummaryViewPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const CuratorCurationGrid(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      pagingController: c.pagingController,
      builderDelegate: PagedChildBuilderDelegate<CurationListSimple>(
          noItemsFoundIndicatorBuilder: (_) => Center(
                child: Text(
                  DS.text.thisUserNotCreateCurationYet,
                  style: DS.textStyle.paragraph3.semiBold.b800,
                ),
              ),
          itemBuilder: (_, curation, __) => TEonTap(
              onTap: () => c.react.toCurationDetail(curation.id),
              child: TECacheImage(src: curation.imageUrl))),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 4,
        crossAxisSpacing: DS.space.xTiny,
        mainAxisSpacing: DS.space.xTiny,
        crossAxisCount: 2,
      ),
    );
  }
}

class _FollowerList extends StatefulWidget {
  final Future<List<Follower>> Function(int pageNumber, int pageSize)
      getFollower;
  final void Function(Follower) onFollowerCardTap;

  const _FollowerList(
      {required this.getFollower, required this.onFollowerCardTap});

  @override
  State<_FollowerList> createState() => __FollowerListState();
}

class __FollowerListState extends State<_FollowerList> {
  final PagingController<int, Follower> pagingController =
      PagingController(firstPageKey: 0);

  static const pageSize = 20;

  Future<void> loadFollowers(int pageNumber) async {
    final ret = await widget.getFollower(pageNumber, pageSize);
    if (ret.length < pageSize) {
      pagingController.appendLastPage(ret);
    } else {
      pagingController.appendPage(ret, pageNumber + 1);
    }
  }

  @override
  void initState() {
    pagingController.addPageRequestListener(loadFollowers);
    super.initState();
  }

  @override
  void dispose() {
    pagingController.removePageRequestListener(loadFollowers);
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 2),
      child: PagedListView.separated(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: DS.space.tiny),
        shrinkWrap: true,
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<Follower>(
          itemBuilder: (_, follower, __) => TEonTap(
            onTap: () => widget.onFollowerCardTap(follower),
            child: FollowerCard(follower),
          ),
        ),
        separatorBuilder: (_, __) => DS.space.vXSmall,
      ),
    );
  }
}
