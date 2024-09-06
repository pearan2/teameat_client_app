import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/community/core/report.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/curator_summary_view_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';
import 'package:teameat/99_util/extension/string.dart';

class CuratorSummaryViewPage extends GetView<CuratorSummaryViewPageController> {
  const CuratorSummaryViewPage({super.key});

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
          action: const CuratorTool(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CuratorSummaryRow(),
              c.summary.obx((s) => s.oneLineIntroduce.isEmpty()
                  ? const SizedBox()
                  : DS.space.vSmall),
              c.summary.obx((s) => s.oneLineIntroduce.isEmpty()
                  ? const SizedBox()
                  : Text(s.oneLineIntroduce!,
                      style: DS.textStyle.caption2.b500.h14)),
              DS.space.vLarge,
              DS.space.vXSmall,
              const Expanded(child: CuratorCurationGrid()),
              GetPlatform.isIOS ? DS.space.vXSmall : const SizedBox(),
            ],
          ),
        )));
  }
}

class CuratorTool extends GetView<CuratorSummaryViewPageController> {
  const CuratorTool({super.key});

  @override
  Widget build(BuildContext context) {
    return c.summary.obx((summary) {
      if (summary.isMe) {
        return TEonTap(
            onTap: c.react.toCurationOffAll,
            child: Center(child: DS.image.iconHome));
      }
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
            );
            if (!ret) return;
            c.onBlock();
          } else if (s == DS.text.reportThisUser) {
            await showReport(c.onReport);
          }
        },
        icon: DS.image.more(DS.color.background700),
      );
    });
  }
}

class CuratorSummaryRow extends GetView<CuratorSummaryViewPageController> {
  static const imageWidth = 76.0;
  const CuratorSummaryRow({super.key});

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
                return const CuratorSummaryNumberRow();
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const CuratorSummaryNumberRow(),
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
  const CuratorSummaryNumberRow({super.key});

  Widget _buildTextAndCount(String text, num count) {
    final textStyle = DS.textStyle.caption2.b500;
    final countStyle = DS.textStyle.caption2.b700;
    return Row(
      children: [
        Text(text, style: textStyle),
        DS.space.hXTiny,
        Text(count.strClamp(max: 999), style: countStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return c.summary.obx((s) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTextAndCount(DS.text.follower, s.numberOfFollowers),
            _buildTextAndCount(DS.text.curation, s.numberOfCurations),
            _buildTextAndCount(
                DS.text.commercialization, s.numberOfCommercializedCurations),
          ],
        ));
  }
}

class CuratorCurationGrid extends GetView<CuratorSummaryViewPageController> {
  const CuratorCurationGrid({super.key});

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
