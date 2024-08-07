import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/community/curation/curator_info_row.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/user/user_block_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/user/block/block.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class UserBlockPage extends GetView<UserBlockPageController> {
  const UserBlockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        appBar: TEAppBar(
          title: c.blockTargetType.title,
          leadingIconOnPressed: c.react.back,
          homeOnPressed: c.react.toUserOffAll,
        ),
        body: TERefreshIndicator(
          onRefresh: () async => c.pagingController.refresh(),
          child: PagedListView(
            pagingController: c.pagingController,
            builderDelegate: PagedChildBuilderDelegate<BlockTargetInfo>(
                noItemsFoundIndicatorBuilder: (_) =>
                    NoBlockTargetFound(c.blockTargetType),
                itemBuilder: (_, blockInfo, __) =>
                    BlockInfo(type: c.blockTargetType, info: blockInfo)),
          ),
        ));
  }
}

class BlockInfo extends StatelessWidget {
  final BlockTargetType type;
  final BlockTargetInfo info;

  const BlockInfo({
    super.key,
    required this.type,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    if (type == BlockTargetType.user) {
      return BlockUserInfo(info);
    } else if (type == BlockTargetType.curation) {
      return BlockCurationInfo(info);
    } else {
      throw 'not implemented yet';
    }
  }
}

class NoBlockTargetFound extends StatelessWidget {
  final BlockTargetType type;
  const NoBlockTargetFound(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(type.noDataDescription, style: DS.textStyle.caption1.b600),
        const SizedBox(),
        const SizedBox(),
      ],
    );
  }
}

class BlockUserInfo extends GetView<UserBlockPageController> {
  final BlockTargetInfo info;
  const BlockUserInfo(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CuratorInfoRow(
            CurationListCuratorInfo(
              id: info.id,
              nickname: info.title,
              profileImageUrl: info.imageUrl,
              oneLineIntroduce: info.description,
            ),
            isButton: false,
          ),
        ),
        DS.space.hSmall,
        TELoadingButton(
          text: DS.text.unBlock,
          onTap: () => c.unBlock(info.id),
        ),
      ],
    ).paddingAll(AppWidget.horizontalPadding);
  }
}

class BlockCurationInfo extends GetView<UserBlockPageController> {
  final BlockTargetInfo info;
  const BlockCurationInfo(this.info, {super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
