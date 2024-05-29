import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEDivider extends StatelessWidget {
  const TEDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DS.color.background100,
      height: DS.space.xTiny,
    );
  }
}
