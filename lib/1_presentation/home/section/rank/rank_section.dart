import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/core/code/statistics/i_statistics_repository.dart';
import 'package:teameat/3_domain/core/code/statistics/statistics.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/99_util/extension/num.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/main.dart';

class ItemRankSection extends StatefulWidget {
  final int refreshCount;
  final SearchableAddress? address;

  final double verticalPadding;
  final double imageWidth;
  final double imageHeight;

  const ItemRankSection({
    super.key,
    this.refreshCount = 0,
    this.verticalPadding = 16.0,
    this.address,
    this.imageWidth = 180,
    this.imageHeight = 240,
  });

  @override
  State<ItemRankSection> createState() => _ItemRankSectionState();
}

class _ItemRankSectionState extends State<ItemRankSection> {
  List<StoreItemSalesStatistics> statistics = [];
  final _statisticsRepo = Get.find<IStatisticsRepository>();

  Future<void> _loadStatistics() async {
    final ret = await _statisticsRepo.findItemStatistics(
        searchOption: SearchList.empty().copyWith(
      address: widget.address?.toFullAddress(),
      limit: 10,
    ));
    ret.fold((l) => showError(l.desc), (r) {
      if (!mounted) return;
      setState(() => statistics = r);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  @override
  void didUpdateWidget(covariant ItemRankSection oldWidget) {
    if ((widget.address != oldWidget.address) ||
        (widget.refreshCount != oldWidget.refreshCount)) {
      _loadStatistics();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (statistics.isEmpty) return const SizedBox();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DS.text.lastWeekBestSalesItemTitle,
          style: DS.textStyle.paragraph1.semiBold.h14.b900,
        ),
        DS.space.vXTiny,
        Text(
          DS.text.lastWeekBestSalesItemDescription,
          style: DS.textStyle.caption1.b600.h14,
        ),
        DS.space.vTiny,
        SizedBox(
          height: StoreItemColumnCard.calcTotalHeight(widget.imageWidth),
          child: CarouselSlider.builder(
              itemCount: statistics.length,
              itemBuilder: (_, idx, realIdx) => StoreItemColumnCard(
                    item: statistics[idx].targetInfo,
                    imageWidth: widget.imageWidth,
                    borderRadius: DS.space.xTiny,
                    infoBoxPrefix: Text(
                      (idx + 1).toString(),
                      style: DS.textStyle.title1.b800.h12.copyWith(
                        fontSize: DS.space.medium + DS.space.tiny,
                      ),
                    ).paddingHorizontal(DS.space.tiny),
                    withLike: false,
                    onTap: Get.find<IReact>().toStoreItemDetail,
                  ).paddingSymmetric(horizontal: DS.space.xTiny),
              options: CarouselOptions(
                enlargeFactor: 0.3,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                viewportFraction: 0.5,
              )),
        )
      ],
    ).paddingVertical(widget.verticalPadding);
  }
}

class CurationRankSection extends StatefulWidget {
  final int refreshCount;
  final SearchableAddress? address;

  final double verticalPadding;
  final double imageWidth;
  final double imageHeight;

  const CurationRankSection({
    super.key,
    this.refreshCount = 0,
    this.verticalPadding = 16.0,
    this.address,
    this.imageWidth = 81,
    this.imageHeight = 108,
  });

  @override
  State<CurationRankSection> createState() => _CurationRankSectionState();
}

class _CurationRankSectionState extends State<CurationRankSection> {
  List<CurationRewardStatistics> statistics = [];
  final _statisticsRepo = Get.find<IStatisticsRepository>();

  Future<void> _loadStatistics() async {
    final ret = await _statisticsRepo.findCurationStatistics(
        searchOption: SearchList.empty().copyWith(
      address: widget.address?.toFullAddress(),
      limit: 3,
    ));
    ret.fold((l) => showError(l.desc), (r) {
      if (!mounted) return;
      setState(() => statistics = r);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  @override
  void didUpdateWidget(covariant CurationRankSection oldWidget) {
    if ((widget.address != oldWidget.address) ||
        (widget.refreshCount != oldWidget.refreshCount)) {
      _loadStatistics();
    }
    super.didUpdateWidget(oldWidget);
  }

  List<Widget> _buildCurationRewardCardColumnChildren() {
    final ret = <Widget>[];

    Widget buildCard(int idx, CurationRewardStatistics statistics) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TECacheImage(
            src: statistics.targetInfo.imageUrl,
            width: widget.imageWidth,
            ratio: widget.imageWidth / widget.imageHeight,
            borderRadius: DS.space.xxTiny,
          ),
          Container(
              alignment: Alignment.center,
              width: DS.space.medium + DS.space.xSmall,
              child: Text((idx + 1).toString(),
                  style: DS.textStyle.title1.h13.b800.copyWith(
                    fontSize: DS.space.medium + DS.space.tiny,
                  ))),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DS.space.vTiny,
                Text(
                  statistics.targetInfo.name,
                  style: DS.textStyle.paragraph3.medium.h14.b800,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  statistics.targetInfo.introducePreview,
                  style: DS.textStyle.caption2.h14.b500,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                DS.space.vXSmall,
                Row(
                  children: [
                    TECacheImage(
                      src: statistics.targetInfo.curator.profileImageUrl,
                      width: DS.space.base,
                      borderRadius: 300,
                    ),
                    DS.space.hXTiny,
                    Text(
                      statistics.targetInfo.curator.nickname,
                      style: DS.textStyle.caption1.semiBold.b800,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                DS.space.vXTiny,
                Row(
                  children: [
                    DS.image.rewardSm,
                    DS.space.hXTiny,
                    Text(
                      statistics.data.format(DS.text.curationRewardFormat),
                      style: DS.textStyle.paragraph2.bold.s500,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      );
    }

    Widget buildSpace() => DS.space.vTiny;

    for (int i = 0; i < statistics.length; i++) {
      final curation = statistics[i].targetInfo;

      if (i != 0) {
        ret.add(buildSpace());
      }
      ret.add(TEonTap(
          isLoginRequired: true,
          onTap: () => Get.find<IReact>()
              .toCurationDetail(curation.id, simple: curation),
          child: buildCard(i, statistics[i])));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    if (statistics.isEmpty) return const SizedBox();
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DS.text.lastWeekBestRewardCurationTitle,
          style: DS.textStyle.paragraph1.semiBold.h14.b900,
        ),
        DS.space.vXTiny,
        Text(
          DS.text.lastWeekBestRewardCurationDescription,
          style: DS.textStyle.caption1.b600.h14,
        ),
        DS.space.vTiny,
        Column(
          mainAxisSize: MainAxisSize.min,
          children: _buildCurationRewardCardColumnChildren(),
        ),
      ],
    ).paddingSymmetric(
      vertical: widget.verticalPadding,
      horizontal: AppWidget.horizontalPadding,
    );
  }
}
