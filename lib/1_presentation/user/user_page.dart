import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/business_registration_information.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/user/user_page_controller.dart';
import 'package:teameat/99_util/get.dart';

class UserPage extends GetView<UserPageController> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    return TEScaffold(
        onPop: (didPop) => controller.react.toHomeOffAll(),
        activated: BottomNavigatorType.profile,
        body: Padding(
          padding: EdgeInsets.only(top: topAreaHeight),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserCard(
                  onSettingClicked: c.onUserSettingClicked,
                ),
                const UserPageDivider(),
                TERowButton(
                  isLoginRequired: true,
                  onTap: controller.react.toItemLike,
                  text: DS.text.like,
                ),
                TERowButton(
                  isLoginRequired: true,
                  onTap: controller.react.toStoreLike,
                  text: DS.text.followStore,
                ),
                const UserPageDivider(),
                TERowButton(
                  onTap: controller.react.toCustomerService,
                  text: DS.text.customerQuestion,
                ),
                const TEServicePolicyButton(),
                const TEPrivacyPolicyButton(),
                TERowButton(
                  onTap: () {
                    showTEBottomSheet(const BusinessRegistrationInformation());
                  },
                  text: DS.text.businessRegistrationInformation,
                ),
                const UserPageDivider(),
                DS.space.vSmall,
                Row(
                  children: [
                    DS.space.hXBase,
                    Text(
                      DS.text.recentSeeStoreItem,
                      style: DS.textStyle.paragraph3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                DS.space.vTiny,
                c.recentSeeItems.obx((recentSeeItems) => StoreItemList(
                      notFound: const RecentSeeItemsNotFound(),
                      items: recentSeeItems,
                      borderRadius: DS.space.tiny,
                    )),
                const UserPageDivider(),
                TERowButton(
                  onTap: controller.onLogOut,
                  text: DS.text.logOut,
                ),
                TERowButton(
                  onTap: controller.onSignOut,
                  text: DS.text.signOut,
                ),
              ],
            ),
          ),
        ));
  }
}

class UserPageDivider extends StatelessWidget {
  const UserPageDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: DS.color.background300);
  }
}

class UserCard extends GetView<UserPageController> {
  final void Function() onSettingClicked;

  const UserCard({super.key, required this.onSettingClicked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DS.space.xBase),
      child: Row(
        children: [
          c.user.obx((user) => TENetworkImage(
                url: user.profileImageUrl,
                size: DS.space.large,
              )),
          DS.space.hTiny,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              c.user.obx((user) => Text(
                    user.nickname,
                    style: DS.textStyle.paragraph3
                        .copyWith(fontWeight: FontWeight.bold),
                  )),
              DS.space.vTiny,
              c.user.obx((user) => Text(
                    user.socialLoginType,
                    style: DS.textStyle.caption1,
                  )),
            ],
          ),
          const Expanded(child: SizedBox()),
          TEonTap(
            onTap: onSettingClicked,
            child: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

class RecentSeeItemsNotFound extends GetView<UserPageController> {
  const RecentSeeItemsNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DS.space.xBase),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DS.text.recentSeeStoreItemsNotFound,
            style: DS.textStyle.paragraph2.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          DS.space.vTiny,
          TEPrimaryButton(
            onTap: controller.react.toHomeOffAll,
            text: DS.text.goToSeeStoreItems,
            contentHorizontalPadding: DS.space.small,
            fitContentWidth: true,
          ),
        ],
      ),
    );
  }
}
