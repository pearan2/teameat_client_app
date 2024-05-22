import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/2_application/core/i_react.dart';

class StoreSimpleInfoRow extends GetView<IReact> {
  final int storeId;
  final String profileImageUrl;
  final String name;
  final String subInfo;
  final bool isButton;

  const StoreSimpleInfoRow({
    super.key,
    required this.profileImageUrl,
    required this.name,
    required this.subInfo,
    required this.storeId,
    this.isButton = true,
  });

  Widget _buildButton() {
    if (!isButton) return const SizedBox();
    return const Icon(Icons.keyboard_arrow_right);
  }

  @override
  Widget build(BuildContext context) {
    return TEonTap(
      onTap: () {
        if (isButton) {
          controller.toStoreDetail(storeId);
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(300),
            child: TENetworkImage(url: profileImageUrl, width: DS.space.large),
          ),
          DS.space.hTiny,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: DS.textStyle.paragraph2
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                DS.space.vXTiny,
                Text(
                  subInfo,
                  overflow: TextOverflow.ellipsis,
                  style: DS.textStyle.caption1,
                ),
              ],
            ),
          ),
          _buildButton(),
        ],
      ),
    );
  }
}
