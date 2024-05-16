import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Padding(
        padding: EdgeInsets.only(
            bottom: GetPlatform.isIOS && bottomSheet != null
                ? DS.getSpace().xBase
                : 0.0),
        child: body,
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
            bottom: GetPlatform.isIOS ? DS.getSpace().xBase : 0.0),
        child: bottomSheet,
      ),
    );
  }
}
