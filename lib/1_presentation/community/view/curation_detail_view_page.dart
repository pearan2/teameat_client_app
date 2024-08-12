import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/community/core/report.dart';
import 'package:teameat/1_presentation/community/curation/curator_info_row.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/like.dart';
import 'package:teameat/1_presentation/core/component/map.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/curation_detail_view_page_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class CurationDetailViewPage extends GetView<CurationDetailViewPageController> {
  @override
  // ignore: overridden_fields
  final String tag;

  const CurationDetailViewPage(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEScaffold(
        loading: c.isLoading,
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            c.curation.obx(
              (curation) => ColorAdjustImageCarouselAppBar(
                actionBuilder: (color) => CurationTools(c, iconColor: color),
                imageUrls: curation.itemImageUrls + curation.storeImageUrls,
              ),
              loadingBuilder: (_) => ColorAdjustImageCarouselAppBar.loading(),
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(DS.space.small),
                  child: c.curation.obx(
                    (curation) => CuratorInfoRow(curation.curator,
                        withFollowButton: !curation.isMine),
                  ),
                ),
                TEDivider.thin(),
                DS.space.vBase,
                c.curation.obx((curation) => _CurationDetailStatusAndToolsRow(
                      curation,
                      onShare: c.onShare,
                    )),
                DS.space.vBase,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppWidget.horizontalPadding),
                  child: c.curation.obx((curation) => Text(
                        curation.oneLineIntroduce,
                        style: DS.textStyle.paragraph1.bold.b800.h14,
                      )),
                ),
                DS.space.vXSmall,
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppWidget.horizontalPadding),
                  child: c.curation.obx((curation) => Text(
                        curation.introduce,
                        style: DS.textStyle.paragraph3.b500.h14,
                      )),
                ),
                DS.space.vSmall,
                DS.space.vMedium,
                Padding(
                  padding: const EdgeInsets.all(AppWidget.horizontalPadding),
                  child:
                      c.curation.obx((curation) => ItemNameAndPrice(curation)),
                ),
                DS.space.vMedium,
                Padding(
                  padding: const EdgeInsets.all(AppWidget.horizontalPadding),
                  child: c.curation
                      .obx((curation) => StoreNameAndCategory(curation)),
                ),
                c.curation.obx((curation) => StoreMap(curation)),
                DS.space.vLarge,
                DS.space.vLarge,
              ],
            ),
          ),
        )));
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
          (const StoreItemInSaleIcon()).orEmpty(curation.isInSale),
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
      onTap: curation.isInSale
          ? () => Get.find<IReact>().toStoreItemDetail(curation.item!.id)
          : () {},
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
                curation.isInSale ? DS.space.hXXTiny : const SizedBox(),
                curation.isInSale ? DS.image.rightArrowInBox : const SizedBox(),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildItemName(),
        DS.space.vSmall,
        curation.isInSale
            ? StoreItemPrice(
                withDiscountText: false,
                originalPrice: curation.item!.originalPrice,
                price: curation.item!.price,
              )
            : StoreItemPrice(
                withDiscountText: false,
                originalPrice: curation.originalPrice,
                price: curation.originalPrice,
              ),
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
          TELeftRightText(
              getCategory(),
              curation.storeAdditional.numberOfCurations
                  .format(DS.text.numberOfCurationFormat)),
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
      naverMapPlaceId: curation.storeAdditional.naverMapPlaceId,
      name: curation.store.name,
    );

    return TESingleStoreMap(
      store: storePoint,
      address: curation.store.address,
      isLoading: curation == CurationListDetail.empty(),
    );
  }
}

class CurationTools extends StatelessWidget {
  final CurationDetailViewPageController controller;
  final Color iconColor;
  const CurationTools(this.controller, {super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return controller.curation.obx((curation) => curation.isMine
        ? EditDeleteTools(controller, iconColor: iconColor)
        : BlockReportTools(controller, iconColor: iconColor));
  }
}

class BlockReportTools extends StatelessWidget {
  final CurationDetailViewPageController controller;
  final Color iconColor;

  const BlockReportTools(this.controller, {super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return TESelectorBottomSheet<String>(
      selectedValue: "",
      candidates: [DS.text.blockThisCuration, DS.text.reportThisCuration],
      getDefaultColor: (s) =>
          s == DS.text.reportThisCuration ? DS.color.point500 : null,
      isLoginRequested: true,
      onSelected: (s) async {
        if (s == DS.text.blockThisCuration) {
          final ret = await showTEConfirmDialog(
            content: DS.text.areYouSureToBlockThisCuration,
            leftButtonText: DS.text.no,
            rightButtonText: DS.text.yesIWillBlockThis,
          );
          if (!ret) return;
          controller.onBlock();
        } else if (s == DS.text.reportThisCuration) {
          await showReport(controller.onReport);
        }
      },
      icon: DS.image.more(iconColor),
      iconActivated: DS.image.more(iconColor),
    );
  }
}

class EditDeleteTools extends StatelessWidget {
  final CurationDetailViewPageController controller;
  final Color iconColor;

  const EditDeleteTools(this.controller, {super.key, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return TESelectorBottomSheet<String>(
      selectedValue: "",
      candidates: [DS.text.editMyCuration, DS.text.deleteMyCuration],
      getDefaultColor: (s) =>
          s == DS.text.deleteMyCuration ? DS.color.point500 : null,
      isLoginRequested: true,
      onSelected: (s) async {
        if (s == DS.text.editMyCuration) {
          controller.onCurationEdit();
        } else if (s == DS.text.deleteMyCuration) {
          final ret = await showTEConfirmDialog(
            content: DS.text.areYouSureToDeleteYourCuration,
            leftButtonText: DS.text.no,
            rightButtonText: DS.text.yesIWillDeleteMyCuration,
          );
          if (!ret) return;
          controller.onCurationDelete();
        }
      },
      icon: DS.image.more(iconColor),
      iconActivated: DS.image.more(iconColor),
    );
  }
}
