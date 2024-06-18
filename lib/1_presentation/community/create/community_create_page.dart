import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/community_create_page_controller.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class CommunityCreatePage extends GetView<CommunityCreatePageController> {
  const CommunityCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      appBar: TEAppBar(
        leadingIconOnPressed: c.react.back,
        title: DS.text.menuApplication,
        action: const ToPreviewButton(),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(AppWidget.horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TEMultiImageSelector(
              addButtonTitle: DS.text.addMenuImage,
              isFirstCover: true,
              numberOfMiniumImages: 1,
              numberOfMaximumImages: 5,
              onImageChanged: (images) => c.menuImages = images,
              onLoading: (isLoading) => c.isMenuImageLoading = isLoading,
            ),
            DS.space.vSmall,
            TEMultiImageSelector(
              addButtonTitle: DS.text.addEtcImage,
              numberOfMiniumImages: 0,
              numberOfMaximumImages: 10,
              onImageChanged: (images) => c.storeImages = images,
              onLoading: (isLoading) => c.isStoreImageLoading = isLoading,
            ),
            DS.space.vSmall,
            TEonTap(
              onTap: c.onSearchStore,
              child: TECupertinoTextField(
                isEssential: true,
                autoFocus: false,
                helperText: '가게',
                hintText: '가게를 선택해주세요',
                maxLines: null,
                enabled: false,
                controller: c.storeNameController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToPreviewButton extends GetView<CommunityCreatePageController> {
  const ToPreviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TETextButton(
        text: DS.text.preview,
        onTap: c.isInputValid ? c.toPreview : null,
      ),
    );
  }
}
