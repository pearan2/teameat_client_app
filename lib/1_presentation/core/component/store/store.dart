import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/distance.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/store.dart';

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
            child: TENetworkCacheImage(
                url: profileImageUrl, width: DS.space.medium),
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
