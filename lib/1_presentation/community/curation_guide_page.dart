import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';

class CurationGuidePage extends StatelessWidget {
  const CurationGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TEScaffold(
            body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: DS.image.curationGuide,
        )),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: TEAppBar(
            leadingIconOnPressed: Get.back,
            backgroundColor: Colors.transparent,
            leadingIconColor: DS.color.background000,
          ),
        )
      ],
    );
  }
}
