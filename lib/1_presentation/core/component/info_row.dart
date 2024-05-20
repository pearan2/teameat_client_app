import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class InfoRow extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String content;
  final double? titleWidth;

  const InfoRow({
    super.key,
    this.icon,
    required this.title,
    required this.content,
    this.titleWidth = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon ?? const SizedBox(),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: DS.getSpace().xTiny),
          width: titleWidth,
          child: Text(
            title,
            style: DS.getTextStyle().paragraph3.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        DS.getSpace().hBase,
        Expanded(
            child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(top: DS.getSpace().xTiny),
          child: Text(
            content,
            textAlign: TextAlign.right,
            style: DS
                .getTextStyle()
                .paragraph3
                .copyWith(color: DS.getColor().background600),
          ),
        ))
      ],
    );
  }
}
