import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';

class CurationGuidePage extends StatelessWidget {
  const CurationGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      appBar: TEAppBar(
        leadingIconOnPressed: Get.back,
        backgroundColor: const Color(0xFF0089FF),
        leadingIconColor: DS.color.background000,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        child: DS.image.curationGuide,
      ),
    );
  }
}
