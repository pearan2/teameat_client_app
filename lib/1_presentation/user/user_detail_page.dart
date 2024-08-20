import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/button.dart';
import 'package:teameat/1_presentation/core/component/divider.dart';
import 'package:teameat/1_presentation/core/image/image.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/component/on_tap.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/app_bar.dart';
import 'package:teameat/1_presentation/core/layout/scaffold.dart';
import 'package:teameat/2_application/user/user_page_controller.dart';
import 'package:teameat/3_domain/user/user.dart';
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
            action: TEonTap(
              onTap: c.updateMe,
              child: Text(
                DS.text.save,
                style: DS.textStyle.paragraph2,
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              DS.space.vSmall,
              Center(
                  child: c.user.obx((user) => UserImage(
                        size: DS.space.large * 2,
                        url: user.profileImageUrl,
                        file: c.selectedProfileImageFile,
                        onTap: () => c.onProfileImageClicked(context),
                      ))),
              DS.space.vSmall,
              TEDivider.thick(),
              DS.space.vSmall,
              Padding(
                padding: const EdgeInsets.all(AppWidget.horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TECupertinoTextField(
                      isEssential: true,
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
                      isEssential: true,
                      controller: c.nicknameController,
                      autoFocus: false,
                      helperText: DS.text.userNickname,
                      hintText: 'teamEat',
                      validate: (value) {
                        return value.length >= 2 && value.length <= 8;
                      },
                      onEditingComplete:
                          c.oneLineIntroduceController.requestFocus,
                      errorText: DS.text.nicknameValidateFail,
                    ),
                    DS.space.vSmall,
                    TECupertinoTextField(
                      controller: c.oneLineIntroduceController,
                      autoFocus: false,
                      helperText: DS.text.oneLineIntroduce,
                      validate: (value) {
                        return value.isEmpty ||
                            (value.length >= 2 && value.length <= 30);
                      },
                      onEditingComplete: c.birthYearController.requestFocus,
                      errorText: DS.text.userOneLineIntroduceError,
                    ),
                    DS.space.vSmall,
                    Text(DS.text.userGender,
                        style: DS.textStyle.paragraph3
                            .copyWith(color: DS.color.background700)),
                    DS.space.vTiny,
                    Obx(() => TESelectorGrid<Gender>(
                          selectedValues: c.gender == null ? [] : [c.gender!],
                          candidates: Gender.values,
                          numberOfRowChildren: Gender.values.length,
                          onTap: (value) {
                            if (c.gender == value) {
                              c.gender = null;
                            } else {
                              c.gender = value;
                            }
                          },
                          builder: (value, isSelected) => TEToggle(
                            borderRadius: DS.space.tiny,
                            text: value.title,
                            isSelected: isSelected,
                          ),
                        )),
                    DS.space.vBase,
                    TECupertinoTextField(
                      controller: c.birthYearController,
                      autoFocus: false,
                      hintText: DS.text.userBirthYearHelperText,
                      helperText: DS.text.userBirthYear,
                      keyboardType: TextInputType.number,
                      validate: (value) {
                        if (value.isEmpty) {
                          return true;
                        }
                        final parsed = int.tryParse(value);
                        if (parsed == null) {
                          return false;
                        }
                        return parsed <= 2020 && parsed >= 1920;
                      },
                      onEditingComplete: c.bankNameController.requestFocus,
                      errorText: DS.text.userBirthYearError,
                    ),
                    DS.space.vMedium,
                    Text(DS.text.bankAccountInfo,
                        style: DS.textStyle.paragraph1
                            .copyWith(fontWeight: FontWeight.bold)),
                    DS.space.vBase,
                    TECupertinoTextField(
                      controller: c.bankNameController,
                      autoFocus: false,
                      helperText: DS.text.bankAccountBankName,
                      hintText: DS.text.bankAccountBankNameHint,
                      validate: (value) {
                        return (value.length >= 2 && value.length <= 10) ||
                            value.isEmpty;
                      },
                      onEditingComplete: c.holderNameController.requestFocus,
                      errorText: DS.text.bankAccountBankNameValidateFail,
                    ),
                    DS.space.vTiny,
                    TECupertinoTextField(
                      controller: c.holderNameController,
                      autoFocus: false,
                      helperText: DS.text.bankAccountHolderName,
                      hintText: DS.text.bankAccountHolderNameHint,
                      validate: (value) {
                        return (value.length >= 2 && value.length <= 10) ||
                            value.isEmpty;
                      },
                      onEditingComplete:
                          c.bankAccountNumberController.requestFocus,
                      errorText: DS.text.bankAccountHolderNameValidateFail,
                    ),
                    DS.space.vTiny,
                    TECupertinoTextField(
                      controller: c.bankAccountNumberController,
                      autoFocus: false,
                      helperText: DS.text.bankAccountNumber,
                      hintText: DS.text.bankAccountNumberHint,
                      validate: (value) {
                        return (value.length >= 2 && value.length <= 20) ||
                            value.isEmpty;
                      },
                      errorText: DS.text.bankAccountNumberValidateFail,
                      keyboardType: TextInputType.number,
                    ),
                    DS.space.vLarge,
                    TETextCopyButton(
                      textData: c.user.value.id,
                      style: DS.textStyle.caption1,
                      text: DS.text.copyUserId,
                    ),
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
      return TECacheImage(
        src: url!,
        width: size,
        ratio: 1,
        borderRadius: 300,
      );
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
