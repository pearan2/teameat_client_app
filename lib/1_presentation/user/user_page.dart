import 'package:clipboard/clipboard.dart';
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
import 'package:teameat/2_application/user/user_page_controller.dart';
import 'package:teameat/3_domain/user/user.dart';

class UserPage extends GetView<UserPageController> {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TEScaffold(
        onPop: (didPop) => controller.react.toHomeOffAll(),
        withBottomNavigator: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() =>
                    PageLoadingWrapper(child: UserCard(user: controller.user))),
                const UserPageDivider(),
                TERowButton(
                  onTap: controller.react.toCustomerService,
                  text: DS.getText().customerQuestion,
                ),
                const TEServicePolicyButton(),
                const TEPrivacyPolicyButton(),
                TERowButton(
                  onTap: () {
                    showTEBottomSheet(const BusinessRegistrationInformation());
                  },
                  text: DS.getText().businessRegistrationInformation,
                ),
                const UserPageDivider(),
                DS.getSpace().vSmall,
                Row(
                  children: [
                    DS.getSpace().hXBase,
                    Text(
                      DS.getText().recentSeeStoreItem,
                      style: DS
                          .getTextStyle()
                          .paragraph3
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                DS.getSpace().vTiny,
                Obx(() => PageLoadingWrapper(
                        child: StoreItemList(
                      notFound: const RecentSeeItemsNotFound(),
                      items: controller.recentSeeItems,
                      borderRadius: DS.getSpace().tiny,
                    ))),
                //
                const UserPageDivider(),
                TERowButton(
                  onTap: controller.onLogOut,
                  text: DS.getText().logOut,
                ),
                TERowButton(
                  onTap: controller.onSignOut,
                  text: DS.getText().signOut,
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
    return Divider(color: DS.getColor().background300);
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(DS.getSpace().xBase),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.email ?? '',
                style: DS
                    .getTextStyle()
                    .paragraph3
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              DS.getSpace().vTiny,
              Text(
                user.socialLoginType,
                style: DS.getTextStyle().caption1,
              )
            ],
          ),
          TEonTap(
            child: const Icon(Icons.copy),
            onTap: () async {
              FlutterClipboard.copy(user.id);
            },
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
      padding: EdgeInsets.all(DS.getSpace().xBase),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DS.getText().recentSeeStoreItemsNotFound,
            style: DS.getTextStyle().paragraph2.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          DS.getSpace().vTiny,
          TEPrimaryButton(
            onTap: controller.react.toHomeOffAll,
            text: DS.getText().goToSeeStoreItems,
            contentHorizontalPadding: DS.getSpace().small,
            fitContentWidth: true,
          ),
        ],
      ),
    );
  }
}
