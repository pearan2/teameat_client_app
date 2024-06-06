import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/component/image.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/core/clipboard.dart';
import 'package:teameat/2_application/user/user_page_controller.dart';
import 'package:teameat/99_util/get.dart';
import 'package:teameat/main.dart';

class UserDetailPage extends GetView<UserPageController> {
  const UserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => TEScaffold(
          loading: c.loading,
          appBar: TEAppBar(
            title: DS.text.userMeInfo,
          ),
          bottomSheet: const SaveButton(),
          body: Column(
            children: [
              DS.space.vSmall,
              Center(
                child: Obx(() => UserImage(
                      size: DS.space.large * 2,
                      url: c.user.profileImageUrl,
                      file: c.selectedProfileImageFile,
                      onTap: c.onProfileImageClicked,
                    )),
              ),
              DS.space.vSmall,
              TEDivider.thick(),
              DS.space.vSmall,
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(AppWidget.horizontalPadding),
                  children: [
                    TECupertinoTextField(
                      maxLines: 1,
                      controller: c.emailController,
                      autoFocus: false,
                      helperText: DS.text.userEmail,
                      hintText: 'teameat@teameat.kr',
                      validate: (value) => value.isEmail,
                      errorText: DS.text.emailValidateFail,
                      onEditingComplete: c.nicknameController.requestFocus,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    DS.space.vSmall,
                    TECupertinoTextField(
                      maxLines: 1,
                      controller: c.nicknameController,
                      autoFocus: false,
                      helperText: DS.text.userNickname,
                      hintText: 'teamEat',
                      validate: (value) {
                        final trimmed = value.trim();
                        if (trimmed.length != value.length) {
                          return false;
                        }
                        return trimmed.length >= 2 && trimmed.length <= 8;
                      },
                      errorText: DS.text.nicknameValidateFail,
                    ),
                    DS.space.vLarge,
                    TEonTap(
                      onTap: () => TEClipboard.setText(c.user.id),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DS.text.copyUserId,
                            style: DS.textStyle.caption1,
                          ),
                          DS.space.hXTiny,
                          Icon(
                            Icons.copy,
                            size: DS.space.xSmall,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class UserImage extends StatelessWidget {
  final String? url;
  final File? file;
  final double size;
  final void Function() onTap;

  const UserImage({
    super.key,
    this.url,
    this.file,
    required this.size,
    required this.onTap,
  }) : assert(url != null || file != null);

  Widget _buildImage() {
    if (file == null) {
      return TENetworkImage(url: url!, size: size);
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(300),
      child: Image.file(
        file!,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TEonTap(
          onTap: onTap,
          child: _buildImage(),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(DS.space.xTiny),
            decoration: BoxDecoration(
                border: Border.all(color: DS.color.background600),
                borderRadius: BorderRadius.circular(300),
                color: DS.color.background000),
            child: Icon(
              Icons.camera_alt,
              size: DS.space.small,
            ),
          ),
        )
      ],
    );
  }
}

class SaveButton extends GetView<UserPageController> {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppWidget.horizontalPadding),
      child: TEPrimaryButton(onTap: c.updateMe, text: DS.text.save),
    );
  }
}
