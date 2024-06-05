import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEDivider extends StatelessWidget {
  final double? height;

  const TEDivider({super.key, this.height});

  factory TEDivider.normal() => const TEDivider();

  factory TEDivider.thick() => TEDivider(height: DS.space.tiny);

  factory TEDivider.thin() => TEDivider(height: DS.space.xxTiny);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DS.color.background100,
      height: height ?? DS.space.xTiny,
    );
  }
}
