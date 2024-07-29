import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:teameat/1_presentation/community/curation/curation_status_text.dart';
import 'package:teameat/1_presentation/community/curation/curator_info_row.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/like.dart';
import 'package:teameat/1_presentation/core/component/map.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/curation_detail_view_page_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/store/store.dart';
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
    final width = MediaQuery.of(context).size.width;
    const ratio = 3 / 4;

    return TEScaffold(
        body: CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: DS.color.background000,
          surfaceTintColor: DS.color.background000,
          pinned: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: DS.image.more,
            )
          ],
          toolbarHeight: DS.space.large,
          expandedHeight: (width / ratio) - DS.space.large,
          flexibleSpace: FlexibleSpaceBar(
            background: c.curation.obx(
              (curation) => TEImageCarousel(
                ratio: ratio,
                width: width,
                imageSrcs: curation.itemImageUrls + curation.storeImageUrls,
                overlayAdditionalHorizontalPadding: 0.0,
              ),
            ),
          ),
        ),
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
        SliverToBoxAdapter(child: DS.space.vSmall),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppWidget.horizontalPadding),
          child: c.curation.obx((curation) => Text(
                curation.oneLineIntroduce,
                style: DS.textStyle.title3.bold.b800,
              )),
        )),
        SliverToBoxAdapter(child: DS.space.vXSmall),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppWidget.horizontalPadding),
          child: c.curation.obx((curation) => Text(
                curation.introduce,
                style: DS.textStyle.paragraph2Long.bold.b500,
              )),
        )),
        SliverToBoxAdapter(child: DS.space.vSmall),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          child: c.curation.obx((curation) => ItemNameAndPrice(curation)),
        )),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          child: c.curation.obx((curation) => StoreNameAndCategory(curation)),
        )),
        SliverToBoxAdapter(
            child: c.curation.obx((curation) => StoreMap(curation))),
        SliverToBoxAdapter(child: DS.space.vMedium),
      ],
    ));
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
              DS.image.share,
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
                  style: DS.textStyle.paragraph3.semiBold.b800,
                ),
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
        curation.item != null ? DS.space.vTiny : const SizedBox(),
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
                style: DS.textStyle.paragraph2.semiBold.b800,
              ),
              curation.storeAdditional.isEntered
                  ? DS.image.rightArrow
                  : const SizedBox(),
            ],
          ),
          DS.space.vXTiny,
          Text(
              "${curation.storeAdditional.category} | ${curation.storeAdditional.numberOfCurations.format(DS.text.numberOfCurationFormat)}")
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
