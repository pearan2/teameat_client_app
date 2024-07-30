import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:teameat/1_presentation/community/core/report.dart';
import 'package:teameat/1_presentation/community/curation/curation_status_text.dart';
import 'package:teameat/1_presentation/community/curation/curator_info_row.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/like.dart';
import 'package:teameat/1_presentation/core/component/map.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/curation_detail_view_page_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/color.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class CurationDetailViewPage extends GetView<CurationDetailViewPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const CurationDetailViewPage(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        body: CustomScrollView(
      cacheExtent: 99999,
      physics: const ClampingScrollPhysics(),
      slivers: [
        ColorAdjustAppBar(c),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(DS.space.small),
            child: c.curation.obx(
              (curation) =>
                  CuratorInfoRow(curation.curator, withFollowButton: true),
            ),
          ),
        ),
        SliverToBoxAdapter(child: TEDivider.thin()),
        SliverToBoxAdapter(child: DS.space.vBase),
        SliverToBoxAdapter(
            child:
                c.curation.obx((curation) => _CurationDetailStatusAndToolsRow(
                      curation,
                      onShare: c.onShare,
                    ))),
        SliverToBoxAdapter(child: DS.space.vBase),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppWidget.horizontalPadding),
          child: c.curation.obx((curation) => Text(
                curation.oneLineIntroduce,
                style: DS.textStyle.paragraph1.bold.b800.h14,
              )),
        )),
        SliverToBoxAdapter(child: DS.space.vXSmall),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppWidget.horizontalPadding),
          child: c.curation.obx((curation) => Text(
                curation.introduce,
                style: DS.textStyle.paragraph3.b500,
              )),
        )),
        SliverToBoxAdapter(child: DS.space.vSmall),
        SliverToBoxAdapter(child: DS.space.vMedium),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          child: c.curation.obx((curation) => ItemNameAndPrice(curation)),
        )),
        SliverToBoxAdapter(child: DS.space.vMedium),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          child: c.curation.obx((curation) => StoreNameAndCategory(curation)),
        )),
        SliverToBoxAdapter(
            child: c.curation.obx((curation) => StoreMap(curation))),
        SliverToBoxAdapter(child: DS.space.vLarge),
        SliverToBoxAdapter(child: DS.space.vLarge),
      ],
    ));
  }
}

class ColorAdjustAppBar extends StatefulWidget {
  final CurationDetailViewPageController controller;
  const ColorAdjustAppBar(this.controller, {super.key});

  @override
  State<ColorAdjustAppBar> createState() => _ColorAdjustAppBarState();
}

class _ColorAdjustAppBarState extends State<ColorAdjustAppBar> {
  Color primaryColor = DS.color.background000;
  bool needToBeWhite = true;
  bool isCollapsed = false;

  Future<void> onImageChanged(String imageUrl, Size imageSize) async {
    if (isCollapsed) return;
    if (CurationListDetail.empty().itemImageUrls.contains(imageUrl)) {
      return;
    }
    final backgroundColorComputeResult =
        await calcBackgroundImage(MakePaletteParam(
      imageUrl: imageUrl,
      region: Rect.fromLTRB(0, 0, imageSize.width - 1, DS.space.large * 1.75),
      size: imageSize,
    ));
    if (backgroundColorComputeResult == null) return;
    if (!mounted || isCollapsed) return;
    Future.delayed(Duration.zero, () {
      setState(() {
        primaryColor = backgroundColorComputeResult.backgroundColor;
        needToBeWhite = backgroundColorComputeResult.isNeedToBeWhiteText;
      });
    });
  }

  void changeIsCollapsed(bool isCollapsed) {
    Future.delayed(Duration.zero, () {
      setState(() => this.isCollapsed = isCollapsed);
    });
  }

  @override
  Widget build(BuildContext context) {
    const ratio = 3 / 4;
    final width = MediaQuery.of(context).size.width;
    final height = width / ratio;
    final toolbarHeight = DS.space.large;

    final iconColor = isCollapsed
        ? DS.color.background700
        : (needToBeWhite ? DS.color.background000 : DS.color.background700);
    final c = widget.controller;
    return SliverAppBar(
      backgroundColor: isCollapsed ? DS.color.background000 : primaryColor,
      surfaceTintColor: isCollapsed ? DS.color.background000 : primaryColor,
      leading: IconButton(
        onPressed: c.react.back,
        icon: DS.image.leftArrowInBox(color: iconColor),
      ),
      pinned: true,
      actions: [
        c.curation.obx((curation) => curation.isMine
            ? EditDeleteTools(iconColor: iconColor)
            : BlockReportTools(iconColor: iconColor)),
        DS.space.hXSmall,
      ],
      toolbarHeight: toolbarHeight,
      expandedHeight: (width / ratio) - DS.space.large,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        if (settings != null &&
            constraints.biggest.height < settings.minExtent * 1.5) {
          changeIsCollapsed(true);
        } else {
          changeIsCollapsed(false);
        }

        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: c.curation.obx(
            (curation) => TEImageCarousel(
              ratio: ratio,
              width: width,
              imageSrcs: curation.itemImageUrls + curation.storeImageUrls,
              overlayAdditionalHorizontalPadding: 0.0,
              onNetworkImageChanged: (imageUrl) =>
                  onImageChanged(imageUrl, Size(width, height)),
            ),
          ),
        );
      }),
    );
  }
}

class _CurationDetailStatusAndToolsRow extends StatelessWidget {
  final CurationListDetail curation;
  final void Function() onShare;

  const _CurationDetailStatusAndToolsRow(this.curation,
      {required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppWidget.horizontalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurationStatusText.fromDetail(curation),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TEonTap(onTap: onShare, child: DS.image.share),
              DS.space.hXSmall,
              Like<ICurationRepository>.base(
                curation.id,
                numberOfLikes: curation.numberOfLikes,
              )
            ],
          )
        ],
      ),
    );
  }
}

class ItemNameAndPrice extends StatelessWidget {
  final CurationListDetail curation;

  const ItemNameAndPrice(this.curation, {super.key});

  Widget _buildItemName() {
    return TEonTap(
      onTap: curation.item == null
          ? () {}
          : () => Get.find<IReact>().toStoreItemDetail(curation.item!.id),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: DS.space.tiny, horizontal: DS.space.xSmall),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: DS.color.background700),
                borderRadius: BorderRadius.circular(300)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  curation.name,
                  style: DS.textStyle.caption1.semiBold.b800.h14,
                ),
                curation.item != null ? DS.space.hXXTiny : const SizedBox(),
                curation.item != null
                    ? DS.image.rightArrowInBox
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildItemName(),
        curation.item != null ? DS.space.vSmall : const SizedBox(),
        curation.item != null
            ? StoreItemPrice(
                originalPrice: curation.item!.originalPrice,
                price: curation.item!.price,
              )
            : const SizedBox(),
      ],
    );
  }
}

class StoreNameAndCategory extends StatelessWidget {
  final CurationListDetail curation;
  const StoreNameAndCategory(this.curation, {super.key});

  void onTap() {
    if (!curation.storeAdditional.isEntered) return;
    Get.find<IReact>().toStoreDetail(curation.store.id);
  }

  String getCategory() {
    final category = curation.storeAdditional.category;
    if (!category.contains('>')) {
      return category;
    } else {
      return category.split('>').last;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                curation.store.name,
                style: DS.textStyle.paragraph2.semiBold.b800.h14,
              ),
              curation.storeAdditional.isEntered
                  ? DS.image.rightArrow
                  : const SizedBox(),
            ],
          ),
          DS.space.vXTiny,
          Text(
            "${getCategory()} | ${curation.storeAdditional.numberOfCurations.format(DS.text.numberOfCurationFormat)}",
            style: DS.textStyle.caption2.b500.h14,
          )
        ],
      ),
    );
  }
}

class StoreMap extends StatelessWidget {
  final CurationListDetail curation;
  const StoreMap(this.curation, {super.key});

  @override
  Widget build(BuildContext context) {
    final storePoint = StorePoint(
        id: curation.store.id,
        profileImageUrl: curation.storeAdditional.profileImageUrl,
        location: curation.store.location,
        naverMapPlaceId: curation.storeAdditional.naverMapPlaceId);
    return Column(
      children: [
        TEStoreMap.single(
          height: DS.space.large * 4,
          store: storePoint,
          isLoading: curation == CurationListDetail.empty(),
        ),
        DS.space.vTiny,
        TEMapToolbar(
          store: storePoint,
          name: curation.store.name,
          address: curation.store.address,
        ).paddingSymmetric(horizontal: AppWidget.horizontalPadding)
      ],
    );
  }
}

class BlockReportTools extends GetView<CurationDetailViewPageController> {
  final Color iconColor;

  const BlockReportTools({super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return TESelectorBottomSheet<String>(
      selectedValue: "",
      candidates: [DS.text.blockThisCuration, DS.text.reportThisCuration],
      closeAfterSelect: false,
      isLoginRequested: true,
      onSelected: (s) async {
        if (s == DS.text.blockThisCuration) {
          final ret = await showTEConfirmDialog(
            content: DS.text.areYouSureToBlockThisCuration,
            leftButtonText: DS.text.no,
            rightButtonText: DS.text.yesIWillBlockThis,
          );
          c.react.back();
          if (!ret) return;
          c.onBlock();
        } else if (s == DS.text.reportThisCuration) {
          await showReport(c.onReport);
          c.react.back();
        } else {
          c.react.back();
        }
      },
      icon: DS.image.more(iconColor),
      iconActivated: DS.image.more(iconColor),
    );
  }
}

class EditDeleteTools extends GetView<CurationDetailViewPageController> {
  final Color iconColor;

  const EditDeleteTools({super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return TESelectorBottomSheet<String>(
      selectedValue: "",
      candidates: ["수정하기", "삭제하기"],
      closeAfterSelect: false,
      isLoginRequested: true,
      onSelected: (s) async {},
      icon: DS.image.more(iconColor),
      iconActivated: DS.image.more(iconColor),
    );
  }
}
