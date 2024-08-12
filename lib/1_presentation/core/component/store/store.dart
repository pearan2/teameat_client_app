import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/component/expandable.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/99_util/extension/text_style.dart';

class StoreSimpleInfoRow extends GetView<IReact> {
  final int storeId;
  final String profileImageUrl;
  final String name;
  final String subInfo;
  final bool isButton;
  final Point location;

  const StoreSimpleInfoRow({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.subInfo,
    required this.storeId,
    required this.location,
    this.isButton = true,
  });

  Widget _buildButton() {
    if (!isButton) return const SizedBox();
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: TECacheImage(src: profileImageUrl, width: DS.space.medium),
          ),
          DS.space.hTiny,
          Expanded(
            child: TEonTap(
              onTap: () {
                if (isButton) {
                  controller.toStoreDetail(storeId);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: DS.textStyle.paragraph3
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  DS.space.vXXTiny,
                  Text(
                    subInfo,
                    overflow: TextOverflow.ellipsis,
                    style: DS.textStyle.caption2,
                  ),
                ],
              ),
            ),
          ),
          _buildButton(),
          DS.space.hTiny,
          DistanceWithIcon(point: location),
          DS.space.hTiny,
          StoreLike(storeId: storeId),
        ],
      ),
    );
  }
}

class StoreLike extends GetView<LikeController<IStoreRepository>> {
  final int storeId;

  const StoreLike({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      isLoginRequired: true,
      onTap: () => controller.toggleLike(storeId),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: DS.space.xTiny),
        child: Obx(() => controller.isLike(storeId)
            ? DS.image.bookmarkClicked
            : DS.image.bookmark),
      ),
    );
  }
}

class StoreTimeInfoExpandable extends StatelessWidget {
  final List<StoreTimeWrapper> timeInfo;

  const StoreTimeInfoExpandable(this.timeInfo, {super.key});

  Text _buildText(String text,
      {required bool isOperation, required bool isFirst}) {
    TextStyle style = isOperation
        ? DS.textStyle.caption1.b700.h14.semiBold
        : DS.textStyle.caption2.b600.h14.semiBold;
    if (!isFirst) {
      style = style.copyWith(fontWeight: FontWeight.normal);
    }
    return Text(text, style: style);
  }

  Widget _buildItem(StoreTimeWrapper info, bool isFirst) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildText(
          info.dayOfWeek,
          isOperation: true,
          isFirst: isFirst,
        ),
        DS.space.hXTiny,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildText(info.operationTime, isOperation: true, isFirst: isFirst),
            info.breakTime.isEmpty
                ? const SizedBox()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildText(DS.text.breakTime,
                          isOperation: false, isFirst: isFirst),
                      DS.space.hXTiny,
                      _buildText(info.breakTime,
                          isOperation: false, isFirst: isFirst)
                    ],
                  ),
            info.lastOrderTime.isEmpty
                ? const SizedBox()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildText(DS.text.lastOrderTime,
                          isOperation: false, isFirst: isFirst),
                      DS.space.hXTiny,
                      _buildText(info.lastOrderTime,
                          isOperation: false, isFirst: isFirst)
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TEExpandable(
        header: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DS.image.clock(size: DS.space.small),
            DS.space.hTiny,
            Text(DS.text.operationTime, style: DS.textStyle.caption1.b800.h14),
            DS.space.hXTiny,
            Text(timeInfo.first.operationTime,
                style: DS.textStyle.caption1.b800.h14),
          ],
        ),
        content: ListView.separated(
          padding: EdgeInsets.only(
              top: DS.space.tiny, left: (DS.space.base + DS.space.xxTiny)),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, idx) => _buildItem(timeInfo[idx], idx == 0),
          separatorBuilder: (_, __) => DS.space.vXTiny,
          itemCount: timeInfo.length,
        ));
  }
}
