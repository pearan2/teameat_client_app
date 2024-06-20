import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image_multi_picker.dart';
import 'package:teameat/1_presentation/core/image/image_viewer.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/loading_provider.dart';
import 'package:teameat/99_util/image.dart';
import 'package:teameat/99_util/text.dart';
import 'package:url_launcher/url_launcher.dart';

class TEMainButton extends GetView<LoadingProvider> {
  final void Function()? onTap;
  final bool isLoginRequired;
  final String text;
  final bool listenEventLoading;

  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;

  final Color fillColor;
  final Color contentColor;

  final double? contentHorizontalPadding;
  final double? contentVerticalPadding;

  final bool fitContentWidth;
  final bool withShadow;

  const TEMainButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoginRequired = false,
    this.listenEventLoading = false,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.contentHorizontalPadding,
    this.contentVerticalPadding,
    required this.fillColor,
    required this.contentColor,
    this.fitContentWidth = false,
    this.withShadow = false,
  });

  TextStyle getContentStyle() {
    return DS.textStyle.paragraph1.copyWith(
      color: onTap == null ? contentColor.withOpacity(0.5) : contentColor,
      fontWeight: FontWeight.bold,
    );
  }

  double getContentWidth() {
    return getTextPainter(
            text: text,
            style: getContentStyle(),
            maxLine: 1,
            maxWidth: double.infinity)
        .size
        .width;
  }

  double getContainerWidth() {
    final contentWidth = getContentWidth();
    if (contentHorizontalPadding == null) {
      return contentWidth;
    } else {
      return contentWidth + (contentHorizontalPadding! * 2);
    }
  }

  Widget _buildContent() {
    return Text(text, style: getContentStyle());
  }

  Border? _buildBorder() {
    if (borderColor == null || borderWidth == null) return null;
    return Border.all(color: borderColor!, width: borderWidth!);
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => onTap?.call(),
      isLoginRequired: isLoginRequired,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            vertical: contentVerticalPadding ?? 0.0,
            horizontal: contentHorizontalPadding ?? 0.0),
        width: fitContentWidth
            ? getContainerWidth() +
                DS.space
                    .tiny // Todo 계산완료 후 tiny 정도를 더해준다. 왜 이래야 정상적으로 레이아웃이 1줄로 나오는지 잘 모르겠음.
            : double.infinity,
        height: DS.space.large,
        decoration: BoxDecoration(
          border: _buildBorder(),
          color: fillColor,
          borderRadius: BorderRadius.circular(borderRadius ?? DS.space.tiny),
          boxShadow: withShadow
              ? [
                  BoxShadow(
                    color: DS.color.background800.withOpacity(0.25),
                    blurRadius: DS.space.xTiny,
                    offset: Offset(0, DS.space.xTiny),
                  )
                ]
              : [],
        ),
        child: listenEventLoading
            ? Obx(() {
                if (controller.isEventLoading) {
                  return TELoading(color: contentColor);
                } else {
                  return _buildContent();
                }
              })
            : _buildContent(),
      ),
    );
  }
}

class TEPrimaryButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isLoginRequired;
  final String text;
  final bool listenEventLoading;
  final double? contentHorizontalPadding;
  final double? contentVerticalPadding;
  final bool fitContentWidth;
  final double? borderRadius;
  final bool withShadow;

  const TEPrimaryButton({
    super.key,
    this.onTap,
    required this.text,
    this.isLoginRequired = false,
    this.listenEventLoading = false,
    this.contentHorizontalPadding,
    this.contentVerticalPadding,
    this.borderRadius,
    this.fitContentWidth = false,
    this.withShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return TEMainButton(
      onTap: onTap,
      text: text,
      isLoginRequired: isLoginRequired,
      listenEventLoading: listenEventLoading,
      fillColor: DS.color.primary600,
      contentColor: DS.color.background000,
      contentHorizontalPadding: contentHorizontalPadding,
      contentVerticalPadding: contentVerticalPadding,
      fitContentWidth: fitContentWidth,
      borderRadius: borderRadius,
      withShadow: withShadow,
    );
  }
}

class TESecondaryButton extends GetView<LoadingProvider> {
  final void Function()? onTap;
  final bool isLoginRequired;
  final String text;
  final bool listenEventLoading;
  final double? contentHorizontalPadding;
  final double? contentVerticalPadding;
  final bool fitContentWidth;
  final double? borderRadius;
  final bool withShadow;

  const TESecondaryButton({
    super.key,
    this.onTap,
    required this.text,
    this.isLoginRequired = false,
    this.listenEventLoading = false,
    this.contentHorizontalPadding,
    this.contentVerticalPadding,
    this.borderRadius,
    this.fitContentWidth = false,
    this.withShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return TEMainButton(
      onTap: onTap,
      text: text,
      isLoginRequired: isLoginRequired,
      listenEventLoading: listenEventLoading,
      fillColor: DS.color.background000,
      contentColor: DS.color.primary600,
      borderColor: DS.color.primary600,
      borderWidth: DS.space.xxTiny,
      contentHorizontalPadding: contentHorizontalPadding,
      contentVerticalPadding: contentVerticalPadding,
      fitContentWidth: fitContentWidth,
      borderRadius: borderRadius,
      withShadow: withShadow,
    );
  }
}

class TEToggle extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double height;
  final Color? boxSelected;
  final Color? boxUnSelected;
  final Color? textSelected;
  final Color? textUnSelected;
  final double borderRadius;
  final bool isTextBold;
  final bool withShadow;
  final TextStyle? textStyle;

  const TEToggle({
    super.key,
    required this.text,
    required this.isSelected,
    this.height = 32.0,
    this.borderRadius = 2.0,
    this.boxSelected,
    this.boxUnSelected,
    this.textUnSelected,
    this.textSelected,
    this.isTextBold = false,
    this.withShadow = false,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final boxSelected = this.boxSelected ?? DS.color.background700;
    final boxUnSelected = this.boxUnSelected ?? DS.color.background100;
    final textSelected = this.textSelected ?? DS.color.background000;
    final textUnSelected = this.textUnSelected ?? DS.color.background800;

    final textStyle = this.textStyle ?? DS.textStyle.caption1;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? boxSelected : boxUnSelected,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: DS.color.background800.withOpacity(0.25),
                  blurRadius: DS.space.xTiny,
                  offset: Offset(0, DS.space.xTiny),
                )
              ]
            : [],
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: textStyle.copyWith(
          color: isSelected ? textSelected : textUnSelected,
          fontWeight: isTextBold ? FontWeight.bold : null,
        ),
      ),
    );
  }
}

class TESelectorGrid<T> extends StatelessWidget {
  final List<T> selectedValues;
  final List<T> candidates;
  final void Function(T) onTap;
  final Widget Function(T value, bool isSelected) builder;
  final int numberOfRowChildren;
  final double rowSpacing;
  final double columnSpacing;
  final bool Function(T lhs, T rhs)? isEqual;

  const TESelectorGrid({
    super.key,
    required this.selectedValues,
    required this.candidates,
    required this.onTap,
    required this.builder,
    this.isEqual,
    this.numberOfRowChildren = 1,
    this.rowSpacing = 8.0,
    this.columnSpacing = 12.0,
  }) : assert(numberOfRowChildren == 0 ||
            (candidates.length % numberOfRowChildren == 0));

  Widget Function(T, bool) getBuilder() {
    bool flushed = false;
    int childCount = 0;
    final List<Widget> buffer = [];

    return (value, isSelected) {
      buffer.add(Expanded(
          child: TEonTap(
              onTap: () => onTap(value), child: builder(value, isSelected))));
      childCount++;

      if (childCount >= numberOfRowChildren) {
        /// flush
        final bufferCopy = [...buffer];
        buffer.clear();
        childCount = 0;
        Widget row = Row(children: bufferCopy);
        if (flushed) {
          row = Padding(
            padding: EdgeInsets.only(top: columnSpacing),
            child: row,
          );
        }
        flushed = true;
        return row;
      } else {
        buffer.add(SizedBox(width: rowSpacing));
        return const SizedBox();
      }
    };
  }

  bool isSelected(T rhs) {
    if (isEqual == null) {
      return selectedValues.contains(rhs);
    } else {
      for (int i = 0; i < selectedValues.length; i++) {
        final lhs = selectedValues[i];
        final isEqual = this.isEqual!(lhs, rhs);
        if (isEqual) return true;
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final builder = getBuilder();
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, idx) =>
          builder(candidates[idx], isSelected(candidates[idx])),
      itemCount: candidates.length,
    );
  }
}

class TESelectorBottomSheet<T> extends StatelessWidget {
  final List<T> candidates;
  final T? selectedValue;
  final bool Function(T lhs, T rhs)? isEqual;
  final void Function(T) onSelected;
  final String Function(T)? toLabel;
  final String text;
  final IconData icon;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;

  const TESelectorBottomSheet({
    super.key,
    required this.candidates,
    required this.onSelected,
    required this.text,
    this.toLabel,
    this.icon = Icons.flashlight_on,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.selectedValue,
    this.isEqual,
  });

  String toLabelString(T value) {
    if (toLabel == null) {
      return value.toString();
    } else {
      return toLabel!(value);
    }
  }

  bool isSelected(T value) {
    if (isEqual == null) {
      return selectedValue! == value;
    } else {
      return isEqual!(selectedValue as T, value);
    }

    // if (selectedValue == null) {
    //   return false;
    // } else {
    //   if (isEqual == null) {
    //     return selectedValue! == value;
    //   } else {
    //     return isEqual!(selectedValue as T, value);
    //   }
    // }
  }

  TextStyle getTextStyle(T value) {
    return DS.textStyle.paragraph2.copyWith(
      color:
          isSelected(value) ? DS.color.background800 : DS.color.background700,
      fontWeight: isSelected(value) ? FontWeight.bold : null,
    );
  }

  void showSelector(double maxHeight) {
    final react = Get.find<IReact>();

    showTEBottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: ListView.separated(
          padding: EdgeInsets.only(bottom: DS.space.xBase),
          shrinkWrap: true,
          itemBuilder: (_, idx) => TEonTap(
            onTap: () {
              onSelected(candidates[idx]);
              react.back();
            },
            child: Text(
              toLabelString(candidates[idx]),
              style: getTextStyle(candidates[idx]),
            ),
          ),
          separatorBuilder: (_, __) => DS.space.vSmall,
          itemCount: candidates.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => showSelector(MediaQuery.of(context).size.height / 2),
      child: Container(
        width: width,
        height: height ?? DS.space.medium,
        padding: EdgeInsets.symmetric(horizontal: DS.space.tiny),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? DS.color.background100,
          borderRadius: BorderRadius.circular(borderRadius ?? 300.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: DS.textStyle.caption1,
            ),
            DS.space.hXXTiny,
            Icon(
              icon,
              size: DS.space.xSmall,
            ),
          ],
        ),
      ),
    );
  }
}

class TERowButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final bool isLoginRequired;
  final String text;
  final void Function() onTap;

  const TERowButton({
    super.key,
    required this.onTap,
    required this.text,
    this.padding,
    this.isLoginRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: onTap,
      isLoginRequired: isLoginRequired,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
                horizontal: DS.space.xBase, vertical: DS.space.small),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: DS.textStyle.paragraph3.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.keyboard_arrow_right),
          ],
        ),
      ),
    );
  }
}

class TEServicePolicyButton extends StatelessWidget {
  const TEServicePolicyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TERowButton(
      onTap: () {
        final url = Uri.https(
            '80000coding.notion.site', '/a12fbdc3259c49158e93ff99fbdc173b');
        launchUrl(url);
      },
      text: DS.text.servicePolicy,
    );
  }
}

class TEPrivacyPolicyButton extends StatelessWidget {
  const TEPrivacyPolicyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TERowButton(
      onTap: () {
        final url = Uri.https(
            '80000coding.notion.site', '/6c327d4888414099b737cce42add2de5');
        launchUrl(url);
      },
      text: DS.text.privacyPolicy,
    );
  }
}

class TETextButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const TETextButton({
    super.key,
    required this.text,
    this.onTap,
  });

  TextStyle getActiveStyle() {
    return DS.textStyle.paragraph3
        .copyWith(color: DS.color.background800, fontWeight: FontWeight.w600);
  }

  TextStyle getInactiveStyle() {
    return DS.textStyle.paragraph3.copyWith(color: DS.color.background400);
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => onTap?.call(),
      child: Text(
        text,
        style: onTap == null ? getInactiveStyle() : getActiveStyle(),
      ),
    );
  }
}

class TEMultiImageSelector extends StatefulWidget {
  final int numberOfMiniumImages;
  final int numberOfMaximumImages;
  final double imagePreviewWidth;
  final int imageWidthRatio;
  final int imageHeightRatio;
  final bool isFirstCover;

  final String addButtonTitle;
  final Function(List<ImageResizeResult> images) onImageChanged;
  final Function(bool isLoading) onLoading;

  const TEMultiImageSelector({
    super.key,
    this.numberOfMiniumImages = 0,
    this.numberOfMaximumImages = 10,
    this.imagePreviewWidth = 80.0,
    this.imageWidthRatio = 3,
    this.imageHeightRatio = 4,
    this.addButtonTitle = '사진 추가',
    this.isFirstCover = false,
    required this.onImageChanged,
    required this.onLoading,
  });

  @override
  State<TEMultiImageSelector> createState() => _TEMultiImageSelectorState();
}

class _TEMultiImageSelectorState extends State<TEMultiImageSelector> {
  late final imageRatio = widget.imageWidthRatio / widget.imageHeightRatio;

  List<File> selectedImages = [];
  List<ImageResizeResult> croppedImages = [];
  List<bool> loadings = [];

  Widget _buildContainer(Widget child) {
    return Container(
      width: widget.imagePreviewWidth,
      height: widget.imagePreviewWidth / imageRatio,
      decoration:
          BoxDecoration(border: Border.all(color: DS.color.background300)),
      child: child,
    );
  }

  void _changeIdx(int lhs, int rhs) {
    if (lhs < 0 ||
        lhs >= selectedImages.length ||
        rhs < 0 ||
        rhs >= selectedImages.length) {
      return;
    }
    if (loadings[lhs] || loadings[rhs]) {
      return;
    }

    final lhsLoading = loadings[lhs];
    final lhsCroppedImage = croppedImages[lhs];
    final lhsSelectedImage = selectedImages[lhs];

    final nextLoading = [...loadings];
    final nextCroppedImage = [...croppedImages];
    final nextSelectedImage = [...selectedImages];

    nextLoading[lhs] = nextLoading[rhs];
    nextCroppedImage[lhs] = nextCroppedImage[rhs];
    nextSelectedImage[lhs] = nextSelectedImage[rhs];

    nextLoading[rhs] = lhsLoading;
    nextCroppedImage[rhs] = lhsCroppedImage;
    nextSelectedImage[rhs] = lhsSelectedImage;

    setState(() {
      loadings = nextLoading;
      croppedImages = nextCroppedImage;
      selectedImages = nextSelectedImage;
      _tryInvokeCallback();
    });
  }

  Widget _buildContent(int idx) {
    final isLoading = loadings[idx];
    if (isLoading) {
      return const Center(child: TELoading());
    }
    final imageSrc = croppedImages[idx].bytes;
    final imageSrcs = croppedImages.map((c) => c.bytes).toList();

    return GestureDetector(
      key: ValueKey(idx),
      onTap: () {
        if (loadings.contains(true)) {
          return;
        }
        showMultiImageViewer(
          imageSrc: imageSrc,
          imageSrcs: imageSrcs,
          imageRatio: imageRatio,
          onRemove: _removeImage,
          onReorder: _changeIdx,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Image.memory(
            croppedImages[idx].bytes,
            fit: BoxFit.fill,
          ),
          Positioned(
              left: DS.space.xTiny,
              bottom: DS.space.xTiny,
              child: Visibility(
                visible: idx == 0 && widget.isFirstCover,
                child: Container(
                  padding: EdgeInsets.all(DS.space.xTiny),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      DS.space.xTiny,
                    ),
                    color: DS.color.background700.withOpacity(0.85),
                  ),
                  child: Text(
                    'cover',
                    style: DS.textStyle.paragraph3.copyWith(
                      color: DS.color.background000,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildButtonText() {
    final style = DS.textStyle.caption1.copyWith(color: DS.color.background600);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.numberOfMiniumImages == 0
            ? Text(widget.addButtonTitle, style: style)
            : TEEssentialText(widget.addButtonTitle, style: style),
        DS.space.vXTiny,
        Text(
          '${selectedImages.length}/${widget.numberOfMaximumImages}',
          style: style,
        )
      ],
    );
  }

  void _tryInvokeCallback() {
    if (!loadings.contains(true)) {
      widget.onLoading(false);
      widget.onImageChanged(croppedImages);
    }
  }

  void _removeImage(int idx) {
    final nextLoadings = [...loadings]..removeAt(idx);
    final nextCroppedImages = [...croppedImages]..removeAt(idx);
    final nextSelectedImages = [...selectedImages]..removeAt(idx);
    setState(() {
      loadings = nextLoadings;
      croppedImages = nextCroppedImages;
      selectedImages = nextSelectedImages;
      _tryInvokeCallback();
    });
  }

  Future<void> _cropImage(int idx) async {
    final ret = await resize(
        ImageResizeParameter(selectedImages[idx], ratio: imageRatio));
    setState(() {
      final nextLoadings = [...loadings];
      nextLoadings[idx] = false;
      final nextCroppedImages = [...croppedImages];
      nextCroppedImages[idx] = ret;
      loadings = nextLoadings;
      croppedImages = nextCroppedImages;
      _tryInvokeCallback();
    });
  }

  Future<void> _onAddImage() async {
    if (this.selectedImages.length >= widget.numberOfMaximumImages) {
      return showError(DS.text.canNotAddMorePictures);
    }

    final selectedImages = await showMultiPhotoPickerBottomSheet(
      limit: widget.numberOfMaximumImages - this.selectedImages.length,
      widthRatio: widget.imageWidthRatio,
      heightRatio: widget.imageHeightRatio,
      height: Get.mediaQuery.size.height - Get.mediaQuery.padding.top,
    );
    if (selectedImages == null) {
      return;
    }
    final beforeLength = this.selectedImages.length;
    setState(() {
      this.selectedImages = [...this.selectedImages, ...selectedImages];
      loadings = [
        ...loadings,
        ...List.generate(selectedImages.length, (_) => true)
      ];
      croppedImages = [
        ...croppedImages,
        ...List.generate(
            selectedImages.length, (_) => ImageResizeResult.empty())
      ];
    });
    for (int i = beforeLength; i < this.selectedImages.length; i++) {
      _cropImage(i);
    }
    widget.onLoading(true);
  }

  Widget _buildAddImageButton() {
    return TEonTap(
      onTap: _onAddImage,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DS.image.addImage,
          _buildButtonText(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.imagePreviewWidth / imageRatio;
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (_, idx) {
          if (idx < selectedImages.length) {
            return _buildContainer(_buildContent(idx));
          } else {
            return _buildContainer(_buildAddImageButton());
          }
        },
        separatorBuilder: (_, __) => DS.space.hXTiny,
        itemCount: selectedImages.length + 1,
      ),
    );
  }
}
