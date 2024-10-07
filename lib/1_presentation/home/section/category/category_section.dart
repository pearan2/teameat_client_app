import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/store.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/home/section/common.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/main.dart';

class CategorySection extends StatelessWidget {
  final void Function(Code code) onCategorySelected;
  final bool withTitle;
  final double verticalPadding;
  final double horizontalPadding;

  const CategorySection({
    super.key,
    required this.onCategorySelected,
    this.verticalPadding = 16.0,
    this.horizontalPadding = AppWidget.horizontalPadding,
    this.withTitle = true,
  });

  List<Widget> _buildCategories(List<Code> categories) {
    final ret = <Widget>[];
    for (int i = 0; i < categories.length; i++) {
      ret.add(
        TEonTap(
            onTap: () => onCategorySelected(categories[i]),
            child: Category(categories[i])),
      );
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TitleAndSeeAll(
          title: DS.text.categorySectionTitle,
          description: DS.text.categorySectionDescription,
          horizontalPadding: 0.0,
        ).orEmpty(withTitle),
        DS.space.vSmall.orEmpty(withTitle),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildCategories(Code.getLargeCategories()),
        ),
      ],
    ).paddingSymmetric(
      horizontal: AppWidget.horizontalPadding,
      vertical: verticalPadding,
    );
  }
}
