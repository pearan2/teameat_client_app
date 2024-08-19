import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEDivider extends StatelessWidget {
  final double height;
  final bool isDotted;
  final Color? color;

  const TEDivider(
      {super.key, required this.height, this.isDotted = false, this.color});

  factory TEDivider.normal() => const TEDivider(height: 4);

  factory TEDivider.thick() => const TEDivider(height: 8);

  factory TEDivider.thin() => const TEDivider(height: 1);

  factory TEDivider.dot() => TEDivider(
        height: 1,
        isDotted: true,
        color: DS.color.background500,
      );

  @override
  Widget build(BuildContext context) {
    if (isDotted) {
      return DottedLine(
        lineThickness: height,
        dashColor: color ?? DS.color.background500,
      );
    }
    return Container(color: color ?? DS.color.background100, height: height);
  }
}
