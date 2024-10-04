import 'package:flutter/material.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/main.dart';

class TitleAndSeeAll extends StatelessWidget {
  final String title;
  final String description;
  final void Function()? onTap;
  final double horizontalPadding;

  const TitleAndSeeAll(
      {super.key,
      required this.title,
      required this.description,
      this.onTap,
      this.horizontalPadding = AppWidget.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: DS.textStyle.paragraph1.semiBold.h14.b900,
            ),
            TEonTap(
              onTap: onTap ?? () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DS.text.seeAll,
                    style: DS.textStyle.caption1.h14.s900,
                  ),
                  DS.image.rightArrow(
                    size: DS.space.xBase,
                    color: DS.color.secondary900,
                  )
                ],
              ),
            ).orEmpty(onTap != null),
          ],
        ),
        Text(description, style: DS.textStyle.caption1.h14.b600),
      ],
    ).paddingHorizontal(horizontalPadding);
  }
}
