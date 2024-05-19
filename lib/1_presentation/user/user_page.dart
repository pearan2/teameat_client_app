import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
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
              children: [
                UserCard(user: controller.user),
                const UserPageDivider(),
                TERowButton(
                  onTap: controller.react.toCustomerService,
                  text: DS.getText().customerQuestion,
                ),
                TERowButton(
                  onTap: controller.toServicePolicy,
                  text: DS.getText().servicePolicy,
                ),
                TERowButton(
                  onTap: controller.toPrivacyPolicy,
                  text: DS.getText().privacyPolicy,
                ),
                TERowButton(
                  onTap: controller.toBusinessRegistrationInformation,
                  text: DS.getText().businessRegistrationInformation,
                ),
                const UserPageDivider(),
                // Todo 최근 본 상품

                //
                const UserPageDivider(),
                TERowButton(
                  isLoginRequired: true,
                  onTap: controller.onLogOut,
                  text: DS.getText().logOut,
                ),
                TERowButton(
                  isLoginRequired: true,
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
