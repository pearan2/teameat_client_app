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
    return Obx(() => TEScaffold(
          loading: c.isLoading,
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
                  imageWidthRatio: 1,
                  imageHeightRatio: 1,
                  onImageChanged: (images) => c.storeImages = images,
                  onLoading: (isLoading) => c.isStoreImageLoading = isLoading,
                ),
                DS.space.vSmall,
                TEonTap(
                  onTap: c.onSearchStore,
                  child: TECupertinoTextField(
                    isEssential: true,
                    autoFocus: false,
                    helperText: DS.text.store,
                    hintText: DS.text.pleaseSearchLocalStore,
                    maxLines: null,
                    enabled: false,
                    controller: c.storeNameController,
                  ),
                ),
                const IsStoreEnteredText(),
                DS.space.vSmall,
                TECupertinoTextField(
                  isEssential: true,
                  autoFocus: false,
                  helperText: DS.text.menuName,
                  hintText: DS.text.pleaseInputMenuName,
                  maxLines: 1,
                  controller: c.menuNameController,
                  onEditingComplete: c.menuPriceController.requestFocus,
                  errorText: DS.text.menuNameError,
                  validate: (value) => value.isNotEmpty && value.length <= 30,
                ),
                LayoutBuilder(builder: (context, constraints) {
                  return TECupertinoTextField(
                    isEssential: true,
                    autoFocus: false,
                    helperText: DS.text.menuPrice,
                    hintText: DS.text.menuPriceHint,
                    widgetWidth: constraints.maxWidth,
                    suffixText: DS.text.koreanWon,
                    maxLines: 1,
                    controller: c.menuPriceController,
                    onEditingComplete:
                        c.menuOneLineIntroduceController.requestFocus,
                    errorText: DS.text.menuPriceError,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: true), // 'Done' 버튼 때문에 이렇게 해둠
                    validate: (value) {
                      final price = int.tryParse(value);
                      return price != null && price >= 1000 && price <= 100000;
                    },
                  );
                }),
                TECupertinoTextField(
                  isEssential: true,
                  autoFocus: false,
                  helperText: DS.text.menuOneLineIntroduce,
                  hintText: DS.text.pleaseInputMenuOneLineIntroduce,
                  maxLines: 1,
                  controller: c.menuOneLineIntroduceController,
                  onEditingComplete: c.menuIntroduceController.requestFocus,
                  errorText: DS.text.menuOneLineIntroduceError,
                  validate: (value) => value.isNotEmpty && value.length <= 100,
                ),
                TECupertinoTextField(
                  isEssential: true,
                  autoFocus: false,
                  helperText: DS.text.etcInfo,
                  hintText: DS.text.pleaseInputEtcInfo,
                  maxLines: null,
                  controller: c.menuIntroduceController,
                  onEditingComplete: c.toPreview,
                  errorText: DS.text.etcInfoError,
                  validate: (value) => value.isNotEmpty && value.length <= 1024,
                ),
              ],
            ),
          ),
        ));
  }
}

class ToPreviewButton extends GetView<CommunityCreatePageController> {
  const ToPreviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TETextButton(
      text: DS.text.preview,
      onTap: c.toPreview,
    );
  }
}

class IsStoreEnteredText extends GetView<CommunityCreatePageController> {
  const IsStoreEnteredText({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (c.local == null) {
        return const SizedBox();
      }
      if (c.localIsEntered) {
        return Text(
          DS.text.storeIsEnteredText,
          style: DS.textStyle.caption1.copyWith(color: DS.color.background700),
        );
      } else {
        return const SizedBox();
        // return Text(
        //   DS.text.storeIsNotEnteredText,
        //   style: DS.textStyle.caption1.copyWith(color: DS.color.background500),
        // );
      }
    });
  }
}
