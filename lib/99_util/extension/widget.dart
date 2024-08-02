import 'package:flutter/widgets.dart';
import 'package:teameat/main.dart';

extension TEWidgetExtension on Widget {
  Widget get withBasePadding => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppWidget.horizontalPadding),
        child: this,
      );

  SliverToBoxAdapter get toSliver => SliverToBoxAdapter(child: this);
}
