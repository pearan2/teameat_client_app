import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/3_domain/user/user.dart';

class FollowerCard extends StatelessWidget {
  final Follower follower;

  const FollowerCard(this.follower, {super.key});

  Widget _buildContent() {
    if (follower.oneLineIntroduce == null) {
      return Text(
        follower.nickname,
        style: DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.bold),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            follower.nickname,
            style:
                DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.bold),
          ),
          DS.space.vTiny,
          Text(
            follower.oneLineIntroduce!,
            style: DS.textStyle.caption1,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TECacheImage(
          src: follower.profileImageUrl,
          width: DS.space.large,
          ratio: 1,
          borderRadius: 300,
        ),
        DS.space.hTiny,
        _buildContent(),
      ],
    );
  }
}
