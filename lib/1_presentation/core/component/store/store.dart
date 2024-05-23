import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';

class StoreSimpleInfoRow extends GetView<IReact> {
  final int storeId;
  final String profileImageUrl;
  final String name;
  final String subInfo;
  final bool isButton;

  const StoreSimpleInfoRow({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.subInfo,
    required this.storeId,
    this.isButton = true,
  });

  Widget _buildButton() {
    if (!isButton) return const SizedBox();
    return const Icon(Icons.keyboard_arrow_right);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: TENetworkImage(url: profileImageUrl, width: DS.space.large),
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
                  style: DS.textStyle.paragraph2
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                DS.space.vXTiny,
                Text(
                  subInfo,
                  overflow: TextOverflow.ellipsis,
                  style: DS.textStyle.caption1,
                ),
              ],
            ),
          ),
        ),
        _buildButton(),
        DS.space.hTiny,
        StoreLike(storeId: storeId),
      ],
    );
  }
}

class StoreLike extends GetView<LikeController<IStoreRepository>> {
  final int storeId;

  const StoreLike({super.key, required this.storeId});

  Widget _buildLikeWidget() {
    return Icon(
      key: const ValueKey(true),
      Icons.bookmark,
      size: DS.space.medium,
      color: DS.color.primary500,
    );
  }

  Widget _buildUnlikeWidget() {
    return Icon(
      key: const ValueKey(false),
      Icons.bookmark_outline,
      size: DS.space.medium,
      color: DS.color.primary500,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      isLoginRequired: true,
      onTap: () => controller.toggleLike(storeId),
      child: Obx(() => controller.isLike(storeId)
          ? _buildLikeWidget()
          : _buildUnlikeWidget()),
    );
  }
}
