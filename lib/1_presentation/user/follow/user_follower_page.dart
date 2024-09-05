import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';

import 'package:teameat/1_presentation/core/component/not_found.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/refresh_indicator.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/user/user_follower_page_controller.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:teameat/99_util/extension/widget.dart';
import 'package:teameat/main.dart';

class UserFollowerPage extends GetView<UserFollowerPageController> {
  const UserFollowerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      appBar: TEAppBar(
        leadingIconOnPressed: controller.react.back,
        title: DS.text.follower,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppWidget.horizontalPadding),
        child: TERefreshIndicator(
          onRefresh: () async {
            controller.pagingController.refresh();
          },
          child: PagedListView.separated(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<Follower>(
              noItemsFoundIndicatorBuilder: (_) => Center(
                child: SimpleNotFound(
                  title: DS.text.followerNotFound,
                  buttonText: DS.text.goToCreateCuration,
                  onTap: () {
                    controller.react.toCurationOffAll();
                    controller.react.toCurationCreate(null);
                  },
                ),
              ),
              itemBuilder: (_, follower, idx) => TEonTap(
                onTap: () => controller.react.toCuratorSummary(follower.id),
                child: _FollowerCard(follower),
              ),
            ),
            separatorBuilder: (_, idx) =>
                TEDivider.thin().paddingVertical(DS.space.small),
          ),
        ),
      ),
    );
  }
}

class _FollowerCard extends StatelessWidget {
  final Follower follower;

  const _FollowerCard(this.follower);

  Widget _buildContent() {
    if (follower.oneLineIntroduce == null) {
      return Text(
        follower.nickname,
        style: DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.bold),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            follower.nickname,
            style:
                DS.textStyle.paragraph3.copyWith(fontWeight: FontWeight.bold),
          ),
          DS.space.vTiny,
          Text(
            follower.oneLineIntroduce!,
            style: DS.textStyle.caption1,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TECacheImage(
          src: follower.profileImageUrl,
          width: DS.space.large,
          ratio: 1,
          borderRadius: 300,
        ),
        DS.space.hTiny,
        _buildContent(),
      ],
    );
  }
}
