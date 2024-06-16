import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/community_page_controller.dart';
import 'package:teameat/99_util/get.dart';

class CommunityPage extends GetView<CommunityPageController> {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        appBar: TEAppBar(height: 0),
        body: Center(
          child: Column(
            children: [
              TEPrimaryButton(onTap: c.onSearchStore, text: '가게검색'),
              TEPrimaryButton(onTap: c.onImageSelect, text: '이미지선택'),
              Center(
                child: Obx(() => c.bytes.value == null
                    ? const SizedBox()
                    : Image.memory(c.bytes.value!)),
              )
            ],
          ),
        ));
  }
}
