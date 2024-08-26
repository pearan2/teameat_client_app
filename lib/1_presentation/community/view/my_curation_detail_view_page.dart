import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/my_curation_detail_view_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class MyCurationDetailViewPage extends GetView<MyCurationDetailPageController> {
  const MyCurationDetailViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imageWidth = width - AppWidget.horizontalPadding * 2;

    return TEScaffold(
      appBar: TEAppBar(
        leadingIconOnPressed: c.react.back,
        title: DS.text.menuApplication,
        homeOnPressed: c.react.toHomeOffAll,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TEDivider.thin(),
            Padding(
                padding: const EdgeInsets.all(AppWidget.horizontalPadding),
                child: c.me.obx((me) => CurationCuratorInfo(
                    creatorProfileImageUrl: me.profileImageUrl,
                    creatorNickname: me.nickname,
                    creatorOneLineIntroduce: me.oneLineIntroduce))),
            TEDivider.thin(),
            DS.space.vSmall,
            InfoTitleText(DS.text.storeItemPicture).withBasePadding,
            DS.space.vSmall,
            c.curation
                .obx(
                  (curation) => TEImageCarousel(
                    width: imageWidth,
                    imageSrcs: curation.itemImageUrls,
                    ratio: 3 / 4,
                    overlayAdditionalHorizontalPadding: 0,
                  ),
                )
                .withBasePadding,
            DS.space.vSmall,
            TEDivider.thick(),
            DS.space.vSmall,
            InfoTitleText(DS.text.itemDescriptionByCurator).withBasePadding,
            DS.space.vSmall,
            c.curation.obx((curation) => CurationInfo(curation)),
            DS.space.vSmall,
            DS.space.vLarge,
          ],
        ),
      ),
    );
  }
}

class CurationInfo extends StatelessWidget {
  final MyCurationDetail curation;
  const CurationInfo(this.curation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        curation.storeImageUrls.isEmpty
            ? const SizedBox()
            : TEImageCarousel(
                width: MediaQuery.of(context).size.width,
                imageSrcs: curation.storeImageUrls,
                overlayAdditionalHorizontalPadding: 0,
              ),
        curation.storeImageUrls.isEmpty ? const SizedBox() : DS.space.vSmall,
        Text(curation.oneLineIntroduce, style: DS.textStyle.title3)
            .withBasePadding,
        DS.space.vSmall,
        TEReadMoreText(curation.introduce, visibleLength: 72).withBasePadding,
        DS.space.vSmall,
      ],
    );
  }
}

class CurationCuratorInfo extends StatelessWidget {
  final double height;
  final String creatorProfileImageUrl;
  final String? creatorOneLineIntroduce;
  final String creatorNickname;

  const CurationCuratorInfo({
    super.key,
    this.height = 32.0,
    required this.creatorProfileImageUrl,
    this.creatorOneLineIntroduce,
    required this.creatorNickname,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TECacheImage(
              src: creatorProfileImageUrl,
              width: height,
              ratio: 1 / 1,
              borderRadius: 300,
            ),
            DS.space.hXSmall,
            Column(
              mainAxisAlignment: creatorOneLineIntroduce == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(creatorNickname,
                    style: DS.textStyle.paragraph3.semiBold.b800),
                creatorOneLineIntroduce == null
                    ? const SizedBox()
                    : Text(creatorOneLineIntroduce!,
                        style: DS.textStyle.caption1.b800),
              ],
            )
          ],
        ),
      ),
    );
  }
}
