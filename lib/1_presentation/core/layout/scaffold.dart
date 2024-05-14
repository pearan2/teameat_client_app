import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';

class TEScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomSheet;

  const TEScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: DS.getColor().background000,
      body: body,
      bottomSheet: bottomSheet,
    );
  }
}
