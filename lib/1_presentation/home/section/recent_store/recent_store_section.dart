import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/container.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/1_presentation/home/section/common.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/main.dart';

class RecentStoreSection extends StatefulWidget {
  final String title;
  final String description;
  final double horizontalPadding;
  final int refreshCount;
  final SearchableAddress? address;

  final double imageWidth;
  final double imageHeight;

  const RecentStoreSection({
    super.key,
    required this.title,
    required this.description,
    this.address,
    this.horizontalPadding = AppWidget.horizontalPadding,
    this.refreshCount = 0,
    this.imageWidth = 180.0,
    this.imageHeight = 240.0,
  });

  @override
  State<RecentStoreSection> createState() => _RecentStoreSectionState();
}

class _RecentStoreSectionState extends State<RecentStoreSection> {
  bool isLoading = true;
  List<StoreSimple> stores = [];
  final _storeRepo = Get.find<IStoreRepository>();
  final _react = Get.find<IReact>();

  late final _searchOption = SearchSimpleList.empty().copyWith(
    address: widget.address,
    pageNumber: 0,
    pageSize: 10,
  );

  Future<void> _loadStores() async {
    setState(() => isLoading = true);
    final ret = await _storeRepo.getStores(_searchOption);
    ret.fold((l) => showError(l.desc), (r) {
      if (mounted) {
        setState(() {
          stores = r;
          isLoading = false;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant RecentStoreSection oldWidget) {
    if ((widget.address != oldWidget.address) ||
        (widget.refreshCount != oldWidget.refreshCount)) {
      _loadStores();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _loadStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleAndSeeAll(
          title: widget.title,
          description: widget.description,
          horizontalPadding: widget.horizontalPadding,
          onTap: () =>
              Get.find<IReact>().toStoreSearch(searchOption: _searchOption),
        ),
        DS.space.vTiny,
        SizedBox(
          height: widget.imageHeight,
          child: isLoading
              ? const Center(
                  child: TELoading(),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.horizontalPadding),
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, idx) => StoreSimpleColumnCard(
                    store: stores[idx],
                    onTap: _react.toStoreDetail,
                    width: widget.imageWidth,
                    height: widget.imageHeight,
                  ),
                  separatorBuilder: (_, __) => DS.space.hTiny,
                  itemCount: stores.length,
                ),
        )
      ],
    );
  }
}

class StoreSimpleColumnCard extends StatelessWidget {
  final StoreSimple store;
  final void Function(int id) onTap;
  final double width;
  final double height;

  const StoreSimpleColumnCard({
    super.key,
    required this.store,
    required this.onTap,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = width / height;
    final nameStyle = DS.textStyle.caption1.semiBold.h14.b100;

    return TEonTap(
      onTap: () => onTap(store.id),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            TECacheImage(
              src: store.coverImageUrl,
              width: width,
              ratio: ratio,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: TEGradientContainer(
                alignment: Alignment.bottomLeft,
                gradientStartPoint: const Alignment(0, 1),
                gradientEndPoint: const Alignment(0, -1),
                height: height / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TELeftRightText(
                      store.name,
                      style: nameStyle,
                      DistanceText(
                        point: store.location,
                        style: nameStyle,
                        withDivider: true,
                      ),
                      useDefaultDivider: false,
                    ),
                    DS.space.vXXTiny,
                    Text(
                      store.address,
                      style: DS.textStyle.caption2.h14.b300,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                ).paddingOnly(
                  left: DS.space.tiny,
                  right: DS.space.tiny,
                  bottom: DS.space.xSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
