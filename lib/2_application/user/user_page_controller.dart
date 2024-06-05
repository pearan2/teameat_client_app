import 'dart:io';

import 'package:flutter/material.dart' as md;
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image_multi_picker.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/login_checker.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/file/i_file_service.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';

class UserPageController extends PageController {
  final _userRepo = Get.find<IUserRepository>();
  final _authService = Get.find<IAuthService>();
  final _itemRepo = Get.find<IStoreItemRepository>();
  final _fileService = Get.find<IFileService>();

  final _user = User.visitor().obs;
  final _recentSeeItems = StoreDetail.empty().items.obs;
  final _selectedProfileImageFile = Rxn<File>();
  final _isLoading = false.obs;

  User get user => _user.value;
  // ignore: invalid_use_of_protected_member
  List<ItemSimple> get recentSeeItems => _recentSeeItems.value;
  bool get loading => _isLoading.value;
  File? get selectedProfileImageFile => _selectedProfileImageFile.value;

  final emailController = md.TextEditingController();
  final emailFocusNode = md.FocusNode();
  final nicknameController = md.TextEditingController();
  final nicknameFocusNode = md.FocusNode();

  Future<void> onLogOut() async {
    if (!_authService.isLogined()) {
      return showError(DS.text.notLogined);
    }
    final isConfirmed = await showTEConfirmDialog(
      content: DS.text.logOutConfirm,
      leftButtonText: DS.text.back,
      rightButtonText: DS.text.goLogOut,
    );
    if (!isConfirmed) {
      return;
    }
    _authService.logOut();
    _user.value = User.visitor();
    showSuccess(DS.text.successLogOut);
  }

  Future<void> onSignOut() async {
    if (!_authService.isLogined()) {
      return showError(DS.text.notLogined);
    }
    final isConfirmed = await showTEConfirmDialog(
      content: DS.text.signOutConfirm,
      leftButtonText: DS.text.back,
      rightButtonText: DS.text.goSignOut,
    );
    if (!isConfirmed) {
      return;
    }

    final ret = await _userRepo.deleteMe();
    return ret.fold((l) => showError(l.desc), (r) {
      if (r) {
        showSuccess(DS.text.deleteUserSuccessSeeYouAgain);
        _authService.logOut();
        _user.value = User.visitor();
      } else {
        showError(DS.text.apiFail);
      }
    });
  }

  Future<void> onUserSettingClicked() async {
    return loginWrapper(react.toUserDetail);
  }

  Future<void> _loadRecentSeeItems() async {
    return resolve(
        _itemRepo.findRecentSeeItems(), (r) => _recentSeeItems.value = r);
  }

  Future<void> _loadMe() async {
    final ret = await _userRepo.getMe();
    return ret.fold((l) => null, (r) => _user.value = r);
  }

  Future<void> onProfileImageClicked() async {
    final files = await showMultiPhotoPickerBottomSheet(limit: 1);
    if (files == null || files.length != 1) {
      return;
    }
    _selectedProfileImageFile.value = files.first;
  }

  Future<void> updateMe() async {
    _isLoading.value = true;
    _isLoading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
    nicknameController.dispose();
    nicknameFocusNode.dispose();
  }

  @override
  Future<bool> initialLoad() async {
    await Future.wait([_loadMe(), _loadRecentSeeItems()]);
    return true;
  }
}
