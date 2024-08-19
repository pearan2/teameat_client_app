import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/3_domain/core/i_likable_repository.dart';
import 'package:teameat/99_util/extension/text_style.dart';

import 'package:teameat/99_util/get.dart';

class Like<T extends ILikableRepository> extends GetView<LikeController<T>> {
  final int targetId;
  final Widget liked;
  final Widget base;
  final int? numberOfLikes;

  final TextStyle countStyle;
  final bool isRowShape;

  const Like({
    super.key,
    required this.targetId,
    required this.liked,
    required this.base,
    this.numberOfLikes,
    required this.countStyle,
    this.isRowShape = false,
  });
  factory Like.whiteWithShadow(int targetId, {int? numberOfLikes}) {
    return Like(
      targetId: targetId,
      liked: DS.image.iconLikeShadowClicked,
      base: DS.image.iconLikeShadow,
      numberOfLikes: numberOfLikes,
      countStyle: DS.textStyle.caption1.b000,
    );
  }

  factory Like.base(int targetId, {int? numberOfLikes}) {
    return Like(
      targetId: targetId,
      liked: DS.image.iconLikeClicked,
      base: DS.image.iconLike,
      numberOfLikes: numberOfLikes,
      countStyle: DS.textStyle.caption1.b700,
    );
  }

  factory Like.baseRowShape(int targetId, {int? numberOfLikes}) {
    return Like(
      targetId: targetId,
      liked: DS.image.iconLikeClicked,
      base: DS.image.iconLike,
      numberOfLikes: numberOfLikes,
      countStyle: DS.textStyle.caption1.b700,
      isRowShape: true,
    );
  }

  Widget _buildNumberOfLikes(int numberOfLikes) {
    final numberOfLikesText =
        numberOfLikes > 9999 ? '9999+' : numberOfLikes.toString();
    return Text(numberOfLikesText, style: countStyle);
  }

  Widget _buildLikeWithCount(int notIncludeMyLikeCount) {
    /// 왜인지는 모르지만 표기되는 Like 수가 -1 까지 줄어드는 현상 디펜스
    if (notIncludeMyLikeCount < 0) {
      notIncludeMyLikeCount = 0;
    }

    if (isRowShape) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          c.isLike(targetId) ? liked : base,
          DS.space.hXTiny,
          _buildNumberOfLikes(
              (notIncludeMyLikeCount + (c.isLike(targetId) ? 1 : 0))),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          c.isLike(targetId) ? liked : base,
          DS.space.vXXTiny,
          _buildNumberOfLikes(
              (notIncludeMyLikeCount + (c.isLike(targetId) ? 1 : 0))),
        ],
      );
    }
  }

  Widget _buildContent() {
    final notIncludeMyLikeCount =
        (numberOfLikes ?? 0) - (controller.isLike(targetId) ? 1 : 0);

    if (numberOfLikes == null) {
      return Obx(
        () => controller.isLike(targetId) ? liked : base,
      );
    } else {
      return Obx(() => _buildLikeWithCount(notIncludeMyLikeCount));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => c.toggleLike(targetId),
      isLoginRequired: true,
      child: _buildContent(),
    );
  }
}
