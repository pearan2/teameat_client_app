import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/99_util/extension/text_style.dart';

class CurationStatusText extends StatelessWidget {
  final CurationListSimple curation;
  final bool withIcon;

  const CurationStatusText(this.curation, {super.key, this.withIcon = false});

  factory CurationStatusText.fromDetail(
    CurationListDetail curation,
  ) {
    return CurationStatusText(CurationListSimple.fromDetail(curation));
  }

  @override
  Widget build(BuildContext context) {
    if (!curation.isInSale) {
      return const SizedBox();
    }
    final statusText = curation.getStatusText();
    if (statusText == null) {
      return const SizedBox();
    }
    if (withIcon) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DS.image.forkAndKnife,
          DS.space.hXTiny,
          Text(
            statusText,
            style: DS.textStyle.caption1.semiBold.p700.h14,
          )
        ],
      );
    }
    return Container(
      width: DS.space.large,
      height: DS.space.base,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: DS.color.primary700),
          borderRadius: BorderRadius.circular(DS.space.base)),
      child: Text(statusText,
          style: DS.textStyle.caption2.semiBold.b000.h14
              .copyWith(color: DS.color.primary700)),
    );
  }
}
