import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/99_util/extension/text_style.dart';

class CurationCuratorInfo extends StatelessWidget {
  final double height;

  final MyCurationMain curation;
  const CurationCuratorInfo(this.curation, {super.key, this.height = 32.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TECacheImage(
              src: curation.curatorProfileImageUrl,
              width: height,
              ratio: 1 / 1,
              borderRadius: 300,
            ),
            DS.space.hXSmall,
            Column(
              mainAxisAlignment: curation.curatorOneLineIntroduce == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(curation.curatorNickname,
                    style: DS.textStyle.paragraph3.semiBold.b800),
                curation.curatorOneLineIntroduce == null
                    ? const SizedBox()
                    : Text(curation.curatorOneLineIntroduce!,
                        style: DS.textStyle.caption1.b800),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CurationIntroduce extends StatelessWidget {
  const CurationIntroduce({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
