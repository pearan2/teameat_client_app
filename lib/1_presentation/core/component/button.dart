import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/loading_provider.dart';

class TEPrimaryButton extends GetView<LoadingProvider> {
  final void Function() onTap;
  final bool isLoginRequired;
  final String text;

  const TEPrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoginRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: onTap,
      isLoginRequired: isLoginRequired,
      child: Container(
        width: double.infinity,
        height: DS.getSpace().large,
        decoration: BoxDecoration(
            color: DS.getColor().primary500,
            borderRadius: BorderRadius.circular(DS.getSpace().tiny)),
        child: Center(
          child: Text(
            text,
            style: DS.getTextStyle().paragraph1.copyWith(
                  color: DS.getColor().background000,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}

class TESecondaryButton extends GetView<LoadingProvider> {
  final void Function() onTap;
  final bool isLoginRequired;
  final String text;

  const TESecondaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoginRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: onTap,
      isLoginRequired: isLoginRequired,
      child: Container(
        width: double.infinity,
        height: DS.getSpace().large,
        decoration: BoxDecoration(
            border: Border.all(
                color: DS.getColor().primary500, width: DS.getSpace().xxTiny),
            color: DS.getColor().background000,
            borderRadius: BorderRadius.circular(DS.getSpace().tiny)),
        child: Center(
          child: Text(
            text,
            style: DS.getTextStyle().paragraph1.copyWith(
                  color: DS.getColor().primary500,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}

class TEToggle extends StatelessWidget {
  final String text;
  final bool isSelected;
  final double height;

  const TEToggle({
    super.key,
    required this.text,
    required this.isSelected,
    this.height = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
          color: isSelected
              ? DS.getColor().background700
              : DS.getColor().background100,
          borderRadius: BorderRadius.circular(DS.getSpace().xxTiny)),
      alignment: Alignment.center,
      child: Text(
        text,
        style: DS.getTextStyle().caption1.copyWith(
              color: isSelected
                  ? DS.getColor().background000
                  : DS.getColor().background800,
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
  final int numberOfRowChild;
  final double rowSpacing;
  final double columnSpacing;

  const TESelectorGrid({
    super.key,
    required this.selectedValues,
    required this.candidates,
    required this.onTap,
    required this.builder,
    this.numberOfRowChild = 1,
    this.rowSpacing = 8.0,
    this.columnSpacing = 12.0,
  }) : assert(candidates.length % numberOfRowChild == 0);

  Widget Function(T, bool) getBuilder() {
    bool flushed = false;
    int childCount = 0;
    final List<Widget> buffer = [];

    return (value, isSelected) {
      buffer.add(Expanded(
          child: TEonTap(
              onTap: () => onTap(value), child: builder(value, isSelected))));
      childCount++;

      if (childCount >= numberOfRowChild) {
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

  @override
  Widget build(BuildContext context) {
    final builder = getBuilder();
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, idx) =>
          builder(candidates[idx], selectedValues.contains(candidates[idx])),
      itemCount: candidates.length,
    );
  }
}
