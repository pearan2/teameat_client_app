import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/community_page_controller.dart';
import 'package:teameat/99_util/get.dart';

class CommunityPage extends GetView<CommunityPageController> {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TEPrimaryButton(onTap: c.onSearchStore, text: '가게검색'),
          TEPrimaryButton(onTap: c.onImageSelect, text: '이미지선택'),
        ],
      ),
    ));
  }
}
