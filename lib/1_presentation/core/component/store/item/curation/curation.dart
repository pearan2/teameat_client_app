import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/99_util/extension/text_style.dart';

class CurationCuratorInfo extends StatelessWidget {
  final double height;
  final Color? color;

  final MyCurationMain curation;
  const CurationCuratorInfo(
    this.curation, {
    super.key,
    this.height = 32.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final react = Get.find<IReact>();
    return TEonTap(
      isLoginRequired: true,
      onTap: () => react.toCuratorSummary(curation.curatorId),
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TECacheImage(
              src: curation.curatorProfileImageUrl,
              width: height,
              ratio: 1 / 1,
              borderRadius: 300,
            ),
            DS.space.hTiny,
            Column(
              mainAxisAlignment: curation.curatorOneLineIntroduce == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(curation.curatorNickname,
                        style: DS.textStyle.caption1.semiBold.h13.b800
                            .copyWith(color: color)),
                    DS.space.hXXTiny,
                  ],
                ),
                curation.curatorOneLineIntroduce == null
                    ? const SizedBox()
                    : Text(curation.curatorOneLineIntroduce!,
                        style: DS.textStyle.caption2.h13.b800
                            .copyWith(color: color)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
