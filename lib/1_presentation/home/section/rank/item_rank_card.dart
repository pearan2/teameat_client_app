import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/3_domain/store/item/item.dart';

class ItemRankCard extends StatelessWidget {
  final ItemSimple item;
  final double imageWidth;
  final double imageHeight;

  const ItemRankCard(
    this.item, {
    super.key,
    required this.imageWidth,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return StoreItemColumnCard(
      item: item,
      imageWidth: imageWidth,
      borderRadius: DS.space.xTiny,
      onTap: Get.find<IReact>().toStoreItemDetail,
    );
  }
}
