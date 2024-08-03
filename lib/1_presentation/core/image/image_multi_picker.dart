import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/99_util/extension/text_style.dart';

class PhotoLoadingIndicator extends StatelessWidget {
  final Color backgroundColor;
  const PhotoLoadingIndicator({
    super.key,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: const Center(child: TELoading()),
    );
  }
}

class InstaAssetPickerTextDelegate extends AssetPickerTextDelegate {
  @override
  String get languageCode => 'ko_KR';

  @override
  String get confirm => '확인';

  @override
  String get cancel => '취소';

  @override
  String get edit => '수정';

  @override
  String get loadFailed => '이미지 로드 실패';

  @override
  String get original => '원본';

  @override
  String get select => '선택';

  @override
  String get emptyList => '사진이 없어요';

  @override
  String get unSupportedAssetType => '지원되지 않는 유형입니다';

  @override
  String get unableToAccessAll => '리소스에 접근 할 수 없습니다';

  @override
  String get viewingLimitedAssetsTip => '특정 리소스와 앨범에만 액세스할 수 있습니다';

  @override
  String get changeAccessibleLimitedAssets => '액세스 가능한 리소스를 설정하려면 클릭하세요';

  @override
  String get accessAllTip => '일부 장치 리소스에만 액세스하도록 애플리케이션을 설정했습니다,'
      '"모든 리소스"에 대한 액세스를 허용하는 것이 좋습니다';

  @override
  String get goToSystemSettings => '시스템 설정으로 이동하기';

  @override
  String get accessLimitedAssets => '제한된 리소스 접근';

  @override
  String get accessiblePathName => '접근 가능한 경로';
}

class InstaAssetPickerResult {
  final List<AssetEntity> selectedAssets;
  final List<File> croppedFiles;

  InstaAssetPickerResult({
    required this.selectedAssets,
    required this.croppedFiles,
  });
}

void showInstaAssetPicker(BuildContext context,
    {required int maxAssets,
    double preferSize = 1024,
    double cropRatio = 3 / 4,
    int gridCount = 3,
    required dynamic Function(Stream<InstaAssetPickerResult>)
        onCompleted}) async {
  final router = Get.find<IReact>();
  final theme = InstaAssetPicker.themeData(Theme.of(context).primaryColor);
  final pickerTheme = theme.copyWith(
    canvasColor: DS.color.background800, // body background color
    splashColor: DS.color.background500, // onTap splash color
    colorScheme: theme.colorScheme.copyWith(
      surface: DS.color.background800, // albums list background color
    ),
    appBarTheme: theme.appBarTheme.copyWith(
      backgroundColor: DS.color.background800, // app bar background color
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
          color: DS.color
              .background000), // change app bar title text style to be like app theme
    ),
    // edit `confirm` button style
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: DS.color.primary600,
        disabledForegroundColor: DS.color.point500,
      ),
    ),
  );

  InstaAssetPicker.pickAssets(
    context,
    pickerConfig: InstaAssetPickerConfig(
      loadingIndicatorBuilder: (context, isAssetsEmpty) =>
          const Center(child: TELoading()),
      closeOnComplete: true,
      textDelegate: InstaAssetPickerTextDelegate(),
      gridCount: gridCount,
      pickerTheme: pickerTheme,
      cropDelegate: InstaAssetCropDelegate(
          preferredSize: preferSize, cropRatios: [cropRatio]),
    ),
    requestType: RequestType.image,
    pageSize: 30,
    onPermissionDenied: (context, delegateDescription) {
      showTEBottomSheet(Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '사진 접근 권한이 없습니다',
            style: DS.textStyle.paragraph2.semiBold,
          ),
          DS.space.vSmall,
          TEPrimaryButton(
            text: '권한 보기',
            onTap: router.toPermissionSetting,
          ),
        ],
      ));
    },
    maxAssets: maxAssets,
    onCompleted: (stream) => onCompleted(stream.map((detail) {
      final filtered = detail.data.where((data) => data.croppedFile != null);

      return InstaAssetPickerResult(
        selectedAssets: detail.selectedAssets,
        croppedFiles: filtered.map((data) => data.croppedFile as File).toList(),
      );
    })),
  );
}
