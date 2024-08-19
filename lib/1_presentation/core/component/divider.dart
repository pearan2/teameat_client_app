import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEDivider extends StatelessWidget {
  final double height;

  const TEDivider({super.key, required this.height});

  factory TEDivider.normal() => const TEDivider(height: 4);

  factory TEDivider.thick() => const TEDivider(height: 8);

  factory TEDivider.thin() => const TEDivider(height: 1);

  @override
  Widget build(BuildContext context) {
    return Container(color: DS.color.background100, height: height);
  }
}
