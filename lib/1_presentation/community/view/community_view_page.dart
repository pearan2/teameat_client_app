import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/community_view_page_controller.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class CommunityViewPage extends GetView<CommunityViewPageController> {
  const CommunityViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        appBar: TEAppBar(),
        body: ListView(
          padding: const EdgeInsets.all(AppWidget.horizontalPadding),
          shrinkWrap: true,
          children: [
            Text(
              DS.text.storeItemPicture,
              style: DS.textStyle.paragraph3,
            ),
            DS.space.vXTiny,
            c.curation.obx((curation) => TEImageListViewer(
                imageSrcs: curation.itemImageUrls, imageRatio: 3 / 4)),
            DS.space.vSmall,
            ////////////////////////////////
            Text(
              DS.text.etcPicture,
              style: DS.textStyle.paragraph3,
            ),
            DS.space.vXTiny,
            c.curation.obx((curation) => TEImageListViewer(
                imageSrcs: curation.storeImageUrls, imageRatio: 1 / 1)),
            DS.space.vSmall,
////////////////////////////////
            Text(DS.text.store),
            c.curation.obx((curation) => Text(
                  curation.storeName,
                  style: DS.textStyle.paragraph2.semiBold,
                )),
            DS.space.vSmall,
            ////////////////////////////////
            Text(DS.text.menuName),
            c.curation.obx((curation) => Text(
                  curation.name,
                  style: DS.textStyle.paragraph2.semiBold,
                )),
            DS.space.vSmall,
            ////////////////////////////////
            Text(DS.text.menuPrice),
            c.curation.obx((curation) => Text(
                  curation.originalPrice.toString() + DS.text.koreanWon,
                  style: DS.textStyle.paragraph2.semiBold,
                )),
            DS.space.vSmall,
            ////////////////////////////////
            Text(DS.text.menuOneLineIntroduce),
            c.curation.obx((curation) => Text(
                  curation.oneLineIntroduce,
                  style: DS.textStyle.paragraph2.semiBold,
                )),
            DS.space.vSmall,
            ////////////////////////////////
            Text(DS.text.menuOneLineIntroduce),
            c.curation.obx((curation) => Text(
                  curation.introduce,
                  style: DS.textStyle.paragraph2Long.semiBold,
                )),
            DS.space.vSmall,
          ],
        ));
  }
}
