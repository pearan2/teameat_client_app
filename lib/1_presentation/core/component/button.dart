import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/image/image_multi_picker.dart';
import 'package:teameat/1_presentation/core/image/image_viewer.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/clipboard.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/loading_provider.dart';
import 'package:teameat/2_application/core/login_checker.dart';
import 'package:teameat/3_domain/connection/i_connection.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/99_util/extension/list.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/text.dart';
import 'package:url_launcher/url_launcher.dart';

class TEMainButton extends GetView<LoadingProvider> {
  final void Function()? onTap;
  final bool isLoginRequired;
  final String text;
  final TextStyle? textStyle;
  final bool listenEventLoading;

  final double? width;
  final double? height;
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
    this.textStyle,
    this.isLoginRequired = false,
    this.listenEventLoading = false,
    this.width,
    this.height,
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
    final style = textStyle ?? DS.textStyle.paragraph1.bold;
    return style.copyWith(
      color: onTap == null ? contentColor.withOpacity(0.5) : contentColor,
    );
  }

  double getContentWidth() {
    return getTextPainter(
      text: text,
      style: getContentStyle(),
      maxLine: 1,
      maxWidth: double.infinity,
    ).size.width;
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
        width: width ??
            (fitContentWidth
                ? getContainerWidth() +
                    DS.space
                        .tiny // Todo 계산완료 후 tiny 정도를 더해준다. 왜 이래야 정상적으로 레이아웃이 1줄로 나오는지 잘 모르겠음.
                : double.infinity),
        height: height ?? DS.space.large,
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
  final TextStyle? textStyle;
  final double? width;
  final double? height;
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
    this.textStyle,
    this.width,
    this.height,
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
      textStyle: textStyle,
      width: width,
      height: height,
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

class TEDisableButton extends GetView<LoadingProvider> {
  final void Function()? onTap;
  final bool isLoginRequired;
  final String text;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final bool listenEventLoading;
  final double? contentHorizontalPadding;
  final double? contentVerticalPadding;
  final bool fitContentWidth;
  final double? borderRadius;
  final bool withShadow;

  const TEDisableButton({
    super.key,
    this.onTap,
    required this.text,
    this.textStyle,
    this.width,
    this.height,
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
      textStyle: textStyle,
      width: width,
      height: height,
      isLoginRequired: isLoginRequired,
      listenEventLoading: listenEventLoading,
      fillColor: DS.color.background200,
      contentColor: DS.color.background400,
      borderColor: DS.color.background200,
      borderWidth: DS.space.xxTiny,
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
  final TextStyle? textStyle;
  final double? width;
  final double? height;
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
    this.textStyle,
    this.width,
    this.height,
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
      textStyle: textStyle,
      width: width,
      height: height,
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
  final String? title;
  final List<T> candidates;
  final T? selectedValue;
  final bool Function(T lhs, T rhs)? isEqual;
  final void Function(T) onSelected;
  final String Function(T)? toLabel;
  final Color? Function(T)? getDefaultColor;
  final String? text;
  final Widget? icon;
  final Widget? iconActivated;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final bool closeAfterSelect;
  final bool isLoginRequested;

  const TESelectorBottomSheet({
    super.key,
    required this.candidates,
    required this.onSelected,
    this.text,
    this.title,
    this.toLabel,
    this.getDefaultColor,
    this.icon,
    this.iconActivated,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.closeAfterSelect = true,
    this.selectedValue,
    this.isEqual,
    this.isLoginRequested = false,
  }) : assert((text == null && icon != null) ||
            (text != null && icon == null && iconActivated == null));

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
  }

  TextStyle getTextStyle(T value) {
    final defaultColorFromCustom =
        getDefaultColor?.call(value) ?? DS.color.background800;

    return DS.textStyle.paragraph2.copyWith(
      color: isSelected(value) ? DS.color.primary600 : defaultColorFromCustom,
      fontWeight: isSelected(value) ? FontWeight.w600 : null,
    );
  }

  Widget _buildTitleText() {
    if (title == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title!, style: DS.textStyle.caption1),
        DS.space.vXTiny,
        TEDivider.thin(),
        DS.space.vSmall,
      ],
    );
  }

  Widget _buildItem(T value) {
    final react = Get.find<IReact>();
    return TEonTap(
      onTap: () {
        if (closeAfterSelect) {
          react.back();
        }
        onSelected(value);
      },
      child: SizedBox(
        height: DS.space.large,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              toLabelString(value),
              style: getTextStyle(value),
            ),
            isSelected(value) ? DS.image.selected : const SizedBox(),
          ],
        ),
      ),
    );
  }

  void showSelector(double maxHeight) {
    if (isLoginRequested) {
      loginWrapper(() => showBottomSheet(maxHeight));
    } else {
      showBottomSheet(maxHeight);
    }
  }

  void showBottomSheet(double maxHeight) {
    showTEBottomSheet(
      withBar: true,
      withClose: true,
      Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (_, idx) {
            if (idx == 0) {
              return _buildTitleText();
            }
            return _buildItem(candidates[idx - 1]);
          },
          itemCount: candidates.length + 1,
        ),
      ),
    );
  }

  Widget _buildTextButton() {
    final bColor = backgroundColor ?? DS.color.background100;

    return Container(
      width: width,
      height: height ?? DS.space.medium,
      padding: EdgeInsets.symmetric(horizontal: DS.space.tiny),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            color: selectedValue == null ? bColor : DS.color.primary600),
        color: bColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 300.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text!,
            style: DS.textStyle.caption1,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton() {
    final activatedIcon = iconActivated ?? icon!;
    return selectedValue == null ? icon! : activatedIcon;
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => showSelector(MediaQuery.of(context).size.height / 2),
      child: text != null ? _buildTextButton() : _buildIconButton(),
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
  final List<String> initialImages;
  final Function(List<dynamic> images) onImageChanged;
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
    this.initialImages = const [],
    required this.onImageChanged,
    required this.onLoading,
  });

  @override
  State<TEMultiImageSelector> createState() => _TEMultiImageSelectorState();
}

class _TEMultiImageSelectorState extends State<TEMultiImageSelector> {
  late final imageRatio = widget.imageWidthRatio / widget.imageHeightRatio;

  late List<dynamic> selectedImages = [...widget.initialImages];

  bool isDisposed = false;

  void changeState(void Function() callback) {
    if (isDisposed) {
      return;
    }
    setState(() {
      callback();
      _tryInvokeCallback();
    });
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

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
    changeState(() {
      selectedImages = selectedImages.reorder(lhs, rhs);
    });
  }

  void _removeImage(int idx) {
    final nextSelectedImages = [...selectedImages]..removeAt(idx);
    changeState(() {
      selectedImages = nextSelectedImages;
    });
  }

  Widget _buildContent(int idx) {
    if (selectedImages[idx] == null) {
      return const Center(
        child: TELoading(),
      );
    }

    final imageSrc = selectedImages[idx];
    final imageSrcs = selectedImages.toList();

    return GestureDetector(
      key: ValueKey(idx),
      onTap: () {
        showMultiImageEditViewer(
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
          TECacheImage(
            src: selectedImages[idx]!,
            fit: BoxFit.fill,
            ratio: imageRatio,
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
    if (selectedImages.where((s) => s == null).isEmpty) {
      widget.onImageChanged(selectedImages);
      widget.onLoading(false);
    } else {
      widget.onLoading(true);
    }
  }

  Future<void> _onAddImage() async {
    if (selectedImages.length >= widget.numberOfMaximumImages) {
      return showError(DS.text.canNotAddMorePictures);
    }

    final originalImages = [...selectedImages];

    showInstaAssetPicker(context,
        maxAssets: widget.numberOfMaximumImages - selectedImages.length,
        cropRatio: widget.imageWidthRatio / widget.imageHeightRatio,
        onCompleted: (stream) {
      stream.listen((data) {
        if (selectedImages.length !=
            originalImages.length + data.selectedAssets.length) {
          changeState(() {
            selectedImages = [
              ...originalImages,
              ...data.selectedAssets.map((_) => null)
            ];
          });
        }
        if (data.selectedAssets.length == data.croppedFiles.length) {
          changeState(() {
            selectedImages = [...originalImages, ...data.croppedFiles];
          });
        }
      });
    });
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

class TEOnOffButton extends StatelessWidget {
  final bool value;
  final bool isLoading;
  final void Function(bool) onChange;

  const TEOnOffButton(
      {super.key,
      required this.value,
      required this.onChange,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      loading: isLoading,
      indicatorTransition: const ForegroundIndicatorTransition.fading(),
      styleBuilder: (on) => ToggleStyle(
        indicatorColor: DS.color.background000,
        backgroundColor: DS.color.background000,
        borderColor: on ? DS.color.primary500 : DS.color.background400,
      ),
      textBuilder: (on) => Text(
        on ? 'ON' : 'OFF',
        style: on
            ? DS.textStyle.caption1.semiBold.b800
            : DS.textStyle.caption1.b600,
      ),
      animationDuration: const Duration(milliseconds: 300),
      iconBuilder: (on) => Container(
        width: DS.space.xBase,
        height: DS.space.xBase,
        color: on ? DS.color.primary600 : DS.color.background300,
      ),
      indicatorSize: Size.fromWidth(DS.space.xBase),
      spacing: DS.space.medium,
      height: DS.space.base,
      current: value,
      first: false,
      second: true,
      onChanged: onChange,
    );
  }
}

class TEPermissionButton extends StatefulWidget {
  final Permission permission;
  final void Function()? onPermitted;

  const TEPermissionButton(this.permission, {super.key, this.onPermitted});

  @override
  State<TEPermissionButton> createState() => _TEPermissionButtonState();
}

class _TEPermissionButtonState extends State<TEPermissionButton>
    with WidgetsBindingObserver {
  bool isLoading = true;
  bool isPermitted = false;
  bool isRequested = false;

  /// 기본 false 값으로 시작

  void changeState(void Function() stateChanger) {
    if (!mounted) {
      return;
    }
    setState(stateChanger);
  }

  void startLoading() {
    changeState(() => isLoading = true);
  }

  void endLoading() {
    changeState(() => isLoading = false);
  }

  void changePermitted(PermissionStatus status) {
    final isPermitted = status.isGranted;
    final isRequested = GetPlatform.isAndroid ? true : !status.isDenied;

    changeState(() {
      this.isPermitted = isPermitted;
      this.isRequested = isRequested;
      if (this.isPermitted) {
        widget.onPermitted?.call();
      }
    });
  }

  Future<void> checkPermission() async {
    startLoading();

    final permissionStatus = await widget.permission.status;
    changePermitted(permissionStatus);
    endLoading();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      checkPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isRequested) {
      return const SizedBox();
    }
    return TEOnOffButton(
      isLoading: isLoading,
      value: isPermitted,
      onChange: (_) {
        openAppSettings();
      },
    );
  }
}

class TETextCopyButton extends StatelessWidget {
  final String textData;
  final TextStyle? style;
  final String? text;

  const TETextCopyButton({
    super.key,
    required this.textData,
    this.style,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    const underLineOffsetY = 1.5;

    return TEonTap(
      onTap: () => TEClipboard.setText(textData),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Transform.translate(
              offset: const Offset(0, underLineOffsetY),
              child: Text(
                (text ?? textData),
                style: style ??
                    DS.textStyle.caption1.b700.h14.copyWith(
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      shadows: [
                        Shadow(
                            color: DS.color.background700,
                            offset: const Offset(0, -underLineOffsetY))
                      ],
                    ),
              ),
            ),
          ),
          DS.space.hXXTiny,
          DS.image.copy,
        ],
      ),
    );
  }
}

class TELoadingButton extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final Future<void> Function() onTap;

  const TELoadingButton({
    super.key,
    required this.text,
    this.width = 68.0,
    this.height = 24.0,
    required this.onTap,
  });

  @override
  State<TELoadingButton> createState() => _TELoadingButtonState();
}

class _TELoadingButtonState extends State<TELoadingButton> {
  bool isLoading = false;

  void changeLoadingState(bool isLoading) {
    if (!mounted) return;
    setState(() => this.isLoading = isLoading);
  }

  Future<void> onTap() async {
    changeLoadingState(true);
    await widget.onTap();
    changeLoadingState(false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: DS.color.primary600),
          borderRadius: BorderRadius.circular(DS.space.xTiny),
        ),
        alignment: Alignment.center,
        width: widget.width,
        height: widget.height,
        child: const TELoading(),
      );
    }

    return TEPrimaryButton(
      borderRadius: DS.space.xTiny,
      text: widget.text,
      width: widget.width,
      height: widget.height,
      textStyle: DS.textStyle.caption2,
      onTap: onTap,
    );
  }
}

class Follow extends StatefulWidget {
  final int targetUserId;
  final double? width;
  final double? height;
  const Follow(this.targetUserId, {super.key, this.width, this.height});

  @override
  State<Follow> createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  late final width = widget.width ?? (DS.space.large + DS.space.tiny);
  late final height = widget.height ?? DS.space.base;

  final _userRepo = Get.find<IUserRepository>();

  bool isLoading = true;
  bool isFollowing = false;
  bool isError = !Get.find<IConnection>().isLogined;

  @override
  void initState() {
    init();
    super.initState();
  }

  void changeState(void Function() cb) {
    if (!mounted) return;
    setState(() => cb());
  }

  Future<void> init() async {
    changeState(() => isLoading = true);
    final ret = await _userRepo.isLiked(widget.targetUserId);
    ret.fold(
        (l) => changeState(() => isError = true),
        (r) => changeState(() {
              isError = false;
              isFollowing = r;
            }));
    changeState(() => isLoading = false);
  }

  Future<void> follow() async {
    changeState(() => isLoading = true);
    final ret = await _userRepo.like(widget.targetUserId);
    ret.fold((l) {
      showError(l.desc);
      changeState(() => isError = true);
    }, (r) => changeState(() => isFollowing = true));
    changeState(() => isLoading = false);
  }

  Future<void> unFollow() async {
    changeState(() => isLoading = true);
    final ret = await _userRepo.unLike(widget.targetUserId);
    ret.fold((l) {
      showError(l.desc);
      changeState(() => isError = true);
    }, (r) => changeState(() => isFollowing = false));
    changeState(() => isLoading = false);
  }

  Widget _buildLoading() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: DS.color.primary600),
        borderRadius: BorderRadius.circular(DS.space.xTiny),
      ),
      alignment: Alignment.center,
      width: width,
      height: height,
      child: const TELoading(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return const SizedBox();
    }
    if (isLoading) {
      return _buildLoading();
    }
    if (isFollowing) {
      return TEDisableButton(
        borderRadius: DS.space.xTiny,
        text: DS.text.following,
        width: width,
        height: height,
        textStyle: DS.textStyle.caption2,
        onTap: unFollow,
      );
    } else {
      return TEPrimaryButton(
        borderRadius: DS.space.xTiny,
        text: DS.text.follow,
        width: width,
        height: height,
        textStyle: DS.textStyle.caption2,
        onTap: follow,
      );
    }
  }
}

class TEDeletableButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final void Function() onDelete;

  const TEDeletableButton({
    super.key,
    required this.onTap,
    required this.onDelete,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: DS.color.background700),
            borderRadius: BorderRadius.circular(
              DS.space.base,
            )),
        padding: EdgeInsets.symmetric(
            horizontal: DS.space.tiny, vertical: DS.space.xTiny),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: DS.textStyle.caption2.h14.b800.semiBold,
            ),
            DS.space.hXTiny,
            TEonTap(onTap: onDelete, child: DS.image.closeSm),
          ],
        ),
      ),
    );
  }
}
