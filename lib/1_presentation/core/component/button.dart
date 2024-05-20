import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/loading.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/loading_provider.dart';
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
  });

  TextStyle getContentStyle() {
    return DS.getTextStyle().paragraph1.copyWith(
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
                DS
                    .getSpace()
                    .tiny // Todo 계산완료 후 tiny 정도를 더해준다. 왜 이래야 정상적으로 레이아웃이 1줄로 나오는지 잘 모르겠음.
            : double.infinity,
        height: DS.getSpace().large,
        decoration: BoxDecoration(
          border: _buildBorder(),
          color: fillColor,
          borderRadius:
              BorderRadius.circular(borderRadius ?? DS.getSpace().tiny),
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
  });

  @override
  Widget build(BuildContext context) {
    return TEMainButton(
      onTap: onTap,
      text: text,
      isLoginRequired: isLoginRequired,
      listenEventLoading: listenEventLoading,
      fillColor: DS.getColor().primary500,
      contentColor: DS.getColor().background000,
      contentHorizontalPadding: contentHorizontalPadding,
      contentVerticalPadding: contentVerticalPadding,
      fitContentWidth: fitContentWidth,
      borderRadius: borderRadius,
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

  const TESecondaryButton(
      {super.key,
      this.onTap,
      required this.text,
      this.isLoginRequired = false,
      this.listenEventLoading = false,
      this.contentHorizontalPadding,
      this.contentVerticalPadding,
      this.borderRadius,
      this.fitContentWidth = false});

  @override
  Widget build(BuildContext context) {
    return TEMainButton(
      onTap: onTap,
      text: text,
      isLoginRequired: isLoginRequired,
      listenEventLoading: listenEventLoading,
      fillColor: DS.getColor().background000,
      contentColor: DS.getColor().primary500,
      borderColor: DS.getColor().primary500,
      borderWidth: DS.getSpace().xxTiny,
      contentHorizontalPadding: contentHorizontalPadding,
      contentVerticalPadding: contentVerticalPadding,
      fitContentWidth: fitContentWidth,
      borderRadius: borderRadius,
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
  });

  @override
  Widget build(BuildContext context) {
    final boxSelected = this.boxSelected ?? DS.getColor().background700;
    final boxUnSelected = this.boxUnSelected ?? DS.getColor().background100;
    final textSelected = this.textSelected ?? DS.getColor().background000;
    final textUnSelected = this.textUnSelected ?? DS.getColor().background800;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
          color: isSelected ? boxSelected : boxUnSelected,
          borderRadius: BorderRadius.circular(borderRadius)),
      alignment: Alignment.center,
      child: Text(
        text,
        style: DS.getTextStyle().caption1.copyWith(
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
    if (selectedValue == null) {
      return false;
    } else {
      if (isEqual == null) {
        return selectedValue! == value;
      } else {
        return isEqual!(selectedValue as T, value);
      }
    }
  }

  TextStyle getTextStyle(T value) {
    return DS.getTextStyle().paragraph2.copyWith(
          color: isSelected(value)
              ? DS.getColor().background800
              : DS.getColor().background700,
          fontWeight: isSelected(value) ? FontWeight.bold : null,
        );
  }

  void showSelector(double maxHeight) {
    final react = Get.find<IReact>();

    showTEBottomSheet(Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      padding: EdgeInsets.only(bottom: DS.getSpace().tiny),
      child: ListView.separated(
        padding: EdgeInsets.all(DS.getSpace().xBase),
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
        separatorBuilder: (_, __) => DS.getSpace().vSmall,
        itemCount: candidates.length,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () => showSelector(MediaQuery.of(context).size.height / 2),
      child: Container(
        width: width,
        height: height ?? DS.getSpace().medium,
        padding: EdgeInsets.symmetric(horizontal: DS.getSpace().tiny),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? DS.getColor().background100,
          borderRadius: BorderRadius.circular(borderRadius ?? 300.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: DS.getTextStyle().caption1,
            ),
            DS.getSpace().hXXTiny,
            Icon(
              icon,
              size: DS.getSpace().xSmall,
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
                horizontal: DS.getSpace().xBase, vertical: DS.getSpace().small),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: DS.getTextStyle().paragraph3.copyWith(
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
      text: DS.getText().servicePolicy,
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
      text: DS.getText().privacyPolicy,
    );
  }
}
