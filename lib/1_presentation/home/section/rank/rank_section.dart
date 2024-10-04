import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/core/code/statistics/i_statistics_repository.dart';
import 'package:teameat/3_domain/core/code/statistics/statistics.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';

class ItemRankSection extends StatefulWidget {
  final int refreshCount;
  final SearchableAddress? address;

  final double verticalPadding;
  final double imageWidth;
  final double imageHeight;

  final double enlargementRatio;

  const ItemRankSection({
    super.key,
    this.refreshCount = 0,
    this.verticalPadding = 16.0,
    this.address,
    this.imageWidth = 180,
    this.imageHeight = 240,
    this.enlargementRatio = 1.2,
  });

  @override
  State<ItemRankSection> createState() => _ItemRankSectionState();
}

class _ItemRankSectionState extends State<ItemRankSection> {
  List<StoreItemSalesStatistics> statistics = [];
  final _statisticsRepo = Get.find<IStatisticsRepository>();
  final enlargeFactor = 1.2;

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
                  ),
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
