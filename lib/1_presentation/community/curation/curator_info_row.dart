import 'package:flutter/widgets.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/string.dart';

class CuratorInfoRow extends StatelessWidget {
  final bool withFollowButton;
  final CurationListCuratorInfo curator;
  const CuratorInfoRow(
    this.curator, {
    super.key,
    this.withFollowButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TECacheImage(
            src: curator.profileImageUrl,
            borderRadius: 300,
            width: DS.space.medium,
          ),
          DS.space.hTiny,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  curator.nickname,
                  style: DS.textStyle.caption1.semiBold.b800.h14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                curator.oneLineIntroduce.isNotEmpty()
                    ? const Expanded(child: SizedBox())
                    : const SizedBox(),
                curator.oneLineIntroduce.isNotEmpty()
                    ? Text(
                        curator.oneLineIntroduce!,
                        style: DS.textStyle.caption1.b600.h14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Row(
            children: [
              withFollowButton ? DS.space.hXTiny : const SizedBox(),
              withFollowButton ? Follow(curator.id) : const SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
