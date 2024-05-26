import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/business_registration_information.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/component/page_loading_wrapper.dart';
import 'package:teameat/1_presentation/core/component/store/item/item.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/bottom_sheet.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/clipboard.dart';
import 'package:teameat/2_application/user/user_page_controller.dart';
import 'package:teameat/3_domain/user/user.dart';

class UserPage extends GetView<UserPageController> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topAreaHeight = MediaQuery.of(context).padding.top;
    return TEScaffold(
        onPop: (didPop) => controller.react.toHomeOffAll(),
        withBottomNavigator: true,
        body: Padding(
          padding: EdgeInsets.only(top: topAreaHeight),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() =>
                    PageLoadingWrapper(child: UserCard(user: controller.user))),
                const UserPageDivider(),
                TERowButton(
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
                Obx(() => PageLoadingWrapper(
                        child: StoreItemList(
                      notFound: const RecentSeeItemsNotFound(),
                      items: controller.recentSeeItems,
                      borderRadius: DS.space.tiny,
                    ))),
                //
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

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DS.space.xBase),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.email.isEmpty ? DS.text.logined : user.email,
                style: DS.textStyle.paragraph3
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              DS.space.vTiny,
              Text(
                user.socialLoginType,
                style: DS.textStyle.caption1,
              )
            ],
          ),
          TEonTap(
            child: const Icon(Icons.copy),
            onTap: () => TEClipboard.setText(user.id.toString()),
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
