import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/2_application/core/i_react.dart';
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
    final react = Get.find<IReact>();
    return TEonTap(
      onTap: () => react.toCuratorSummary(curator.id),
      child: Row(
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
                  style: DS.textStyle.caption1.bold.b800.h14,
                ),
                curator.oneLineIntroduce.isNotEmpty()
                    ? Text(
                        curator.oneLineIntroduce!,
                        style: DS.textStyle.caption2.b600.h14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          withFollowButton ? DS.space.hTiny : const SizedBox(),
          withFollowButton
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Follow(curator.id),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
