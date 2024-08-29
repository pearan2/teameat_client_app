import 'package:flutter/widgets.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/main.dart';

extension TEWidgetExtension on Widget {
  Widget get withBasePadding => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppWidget.horizontalPadding),
        child: this,
      );

  Widget paddingHorizontal(double horizontal) => Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal), child: this);

  Widget paddingVertical(double vertical) =>
      Padding(padding: EdgeInsets.symmetric(vertical: vertical), child: this);

  SliverToBoxAdapter get toSliver => SliverToBoxAdapter(child: this);

  Widget orEmpty(bool condition) {
    if (condition) {
      return this;
    } else {
      return const SizedBox();
    }
  }

  Widget withTitle(String title,
      {TextStyle? style, double spacing = 24.0, bool withBasePadding = true}) {
    final titleStyle = style ?? DS.textStyle.title3.bold.b800.h14;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withBasePadding
            ? Text(title, style: titleStyle).withBasePadding
            : Text(title, style: titleStyle),
        SizedBox(height: spacing),
        this,
      ],
    );
  }

  Widget withDivider(Widget divider, {double spacing = 32.0}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        divider,
        SizedBox(height: spacing),
        this,
      ],
    );
  }
}
