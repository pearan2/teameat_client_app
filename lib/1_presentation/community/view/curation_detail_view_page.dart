import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:teameat/1_presentation/community/curation/curation_status_text.dart';
import 'package:teameat/1_presentation/community/curation/curator_info_row.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/like.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/curation_detail_view_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
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
            child: c.curation.obx((curation) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppWidget.horizontalPadding),
                  child: Text(
                    curation.name,
                    style: DS.textStyle.title3.bold.b800,
                  ),
                ))),
        SliverToBoxAdapter(child: DS.space.vXSmall),
        SliverToBoxAdapter(
            child: c.curation.obx((curation) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppWidget.horizontalPadding),
                  child: Text(
                    curation.name,
                    style: DS.textStyle.paragraph2Long.bold.b500,
                  ),
                ))),
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
