import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DS.getColor().primary500,
      body: Center(child: DS.getImage().splashBackground),
    );
  }
}
