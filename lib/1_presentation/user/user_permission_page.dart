import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/i_react.dart';
import 'package:teameat/2_application/core/location_controller.dart';
import 'package:teameat/99_util/extension/text_style.dart';
import 'package:teameat/main.dart';

class UserPermissionPage extends StatelessWidget {
  const UserPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = Get.find<LocationController>();
    final router = Get.find<IReact>();

    return TEScaffold(
      appBar: TEAppBar(
        title: DS.text.permissionSetting,
        leadingIconOnPressed: router.back,
        homeOnPressed: router.toHomeOffAll,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppWidget.horizontalPadding),
        child: Column(
          children: [
            OnOffButtonWrapper(
              DS.text.locationInfoTitle,
              desc: DS.text.locationInfoDesc,
              child: TEPermissionButton(
                Permission.location,
                onPermitted: locationController.init,
              ),
            ),
            OnOffButtonWrapper(
              DS.text.notificationInfoTitle,
              desc: DS.text.notificationInfoDesc,
              child: const TEPermissionButton(Permission.notification),
            ),
            OnOffButtonWrapper(DS.text.photoInfoTitle,
                desc: DS.text.photoInfoDesc,
                child: const TEPermissionButton(Permission.photos)),
            OnOffButtonWrapper(DS.text.cameraInfoTitle,
                desc: DS.text.cameraInfoDesc,
                child: const TEPermissionButton(Permission.camera)),
          ],
        ),
      ),
    );
  }
}

class OnOffButtonWrapper extends StatelessWidget {
  final String title;
  final String desc;
  final Widget child;
  const OnOffButtonWrapper(this.title,
      {super.key, required this.child, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DS.space.xBase,
        vertical: DS.space.small,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: DS.textStyle.paragraph2.semiBold),
              child,
            ],
          ),
          DS.space.vXTiny,
          Text(desc, style: DS.textStyle.caption1.b700),
        ],
      ),
    );
  }
}
