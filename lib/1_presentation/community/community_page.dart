import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/community/community_page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class CommunityPage extends GetView<CommunityPageController> {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
      appBar: TEAppBar(height: 0),
      activated: BottomNavigatorType.community,
      bottomSheet: const CurationApplicationButton(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: DS.space.tiny, horizontal: AppWidget.horizontalPadding),
        child: CustomScrollView(
          slivers: [
            BannerSliver(),
            UserInfoSliver(),
            CurationStatusSelectorSliver(),
          ],
        ),
      ),
    );
  }
}

class UserInfoSliver extends GetView<CommunityPageController> {
  const UserInfoSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox(),
      backgroundColor: DS.color.background000,
      surfaceTintColor: DS.color.background000,
      snap: true,
      floating: true,
      toolbarHeight: DS.space.medium,
      flexibleSpace: Container(
        padding: EdgeInsets.only(top: DS.space.tiny),
        alignment: Alignment.centerLeft,
        child: c.me.obx((me) => Text(
              '${me.nickname} ${DS.text.applicationsOfUserFormat}',
              style: DS.textStyle.paragraph2.copyWith(
                fontWeight: FontWeight.w600,
                color: DS.color.background800,
              ),
            )),
      ),
    );
  }
}

class BannerSliver extends StatelessWidget {
  const BannerSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox(),
      backgroundColor: DS.color.background000,
      surfaceTintColor: DS.color.background000,
      snap: true,
      floating: true,
      expandedHeight: DS.space.large * 3,
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.circular(DS.space.xTiny),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          color: DS.color.primary600,
          child: DS.image.communityBanner1,
        ),
      ),
    );
  }
}

class CurationStatusSelectorSliver extends GetView<CommunityPageController> {
  const CurationStatusSelectorSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const SizedBox(),
      backgroundColor: DS.color.background000,
      surfaceTintColor: DS.color.background000,
      pinned: true,
      toolbarHeight: DS.space.base * 2,
      flexibleSpace: Obx(
        () => Container(
          alignment: Alignment.center,
          child: TESelectorGrid<Code>(
            selectedValues: [c.searchOption.status],
            numberOfRowChildren: c.filters.length,
            candidates: c.filters,
            isEqual: (lhs, rhs) => lhs.code == rhs.code,
            onTap: c.onFilterChanged,
            rowSpacing: DS.space.tiny,
            builder: (value, isSelected) => TEToggle(
              textUnSelected: DS.color.background600,
              textSelected: DS.color.background000,
              boxUnSelected: DS.color.background000,
              boxSelected: DS.color.primary600,
              borderRadius: DS.space.tiny,
              text: value.title,
              isSelected: isSelected,
              textStyle: DS.textStyle.paragraph3,
              withShadow: true,
            ),
          ),
        ),
      ),
    );
  }
}

class CurationApplicationButton extends GetView<CommunityPageController> {
  const CurationApplicationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: DS.space.base,
        right: DS.space.base,
        bottom: DS.space.base,
      ),
      child: TEPrimaryButton(
        isLoginRequired: true,
        listenEventLoading: false,
        onTap: c.onCurationApplicationClicked,
        text: DS.text.menuApplication,
        withShadow: true,
      ),
    );
  }
}
