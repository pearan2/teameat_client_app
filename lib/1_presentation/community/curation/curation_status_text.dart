import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/99_util/extension/text_style.dart';

class CurationStatusText extends StatelessWidget {
  final CurationListSimple curation;
  final Color color;

  const CurationStatusText(this.curation, {super.key, required this.color});

  factory CurationStatusText.fromDetail(
    CurationListDetail curation,
  ) {
    return CurationStatusText(
      CurationListSimple.fromDetail(curation),
      color: DS.color.primary600,
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusText = curation.getStatusText();
    if (statusText == null) {
      return const SizedBox();
    }
    return Container(
      width: DS.space.large,
      height: DS.space.base,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(DS.space.base)),
      child: Text(statusText,
          style: DS.textStyle.caption2.semiBold.b000.copyWith(color: color)),
    );
  }
}
