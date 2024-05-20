import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEDivider extends StatelessWidget {
  const TEDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: DS.getColor().background400, height: 1, thickness: 1);
  }
}
