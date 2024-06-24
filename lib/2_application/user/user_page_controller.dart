import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image_multi_picker.dart';
import 'package:teameat/1_presentation/core/layout/dialog.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/component/like_controller.dart';
import 'package:teameat/2_application/core/login_checker.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/file/i_file_service.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:teameat/99_util/get.dart';

class UserPageController extends PageController {
  final _userRepo = Get.find<IUserRepository>();
  final _authService = Get.find<IAuthService>();
  final _itemRepo = Get.find<IStoreItemRepository>();
  final _fileService = Get.find<IFileService>();

  late final user = User.visitor().wrap(_loadMe);
  late final recentSeeItems = <ItemSimple>[
    ItemSimple.empty(),
    ItemSimple.empty()
  ].wrap(_loadRecentSeeItems);

  final _selectedProfileImageFile = Rxn<File>();
  final _isLoading = false.obs;

  final _storeLikeController = Get.find<LikeController<IStoreRepository>>();
  final _itemLikeController = Get.find<LikeController<IStoreItemRepository>>();

  // ignore: invalid_use_of_protected_member
  bool get loading => _isLoading.value;
  File? get selectedProfileImageFile => _selectedProfileImageFile.value;

  final emailController = TECupertinoTextFieldController();
  final nicknameController = TECupertinoTextFieldController();
  final oneLineIntroduceController = TECupertinoTextFieldController();
  final bankNameController = TECupertinoTextFieldController();
  final holderNameController = TECupertinoTextFieldController();
  final bankAccountNumberController = TECupertinoTextFieldController();

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
    _itemLikeController.clean();
    _storeLikeController.clean();
    user.value = User.visitor();
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
        user.value = User.visitor();
      } else {
        showError(DS.text.apiFail);
      }
    });
  }

  Future<void> toUserDetail() async {
    if (user.value == User.visitor()) {
      await user.load();
    }
    react.toUserDetail();
  }

  Future<void> onUserSettingClicked() async {
    return loginWrapper(toUserDetail);
  }

  Future<Either<Failure, List<ItemSimple>>> _loadRecentSeeItems() async {
    return _itemRepo.findRecentSeeItems();
  }

  Future<Either<Failure, User>> _loadMe() async {
    final ret = await _userRepo.getMe();
    return ret.fold((l) => right(User.visitor()), (r) {
      emailController.text = r.email;
      nicknameController.text = r.nickname;
      oneLineIntroduceController.text = r.oneLineIntroduce ?? '';
      bankAccountNumberController.text = r.bankAccount?.number ?? '';
      holderNameController.text = r.bankAccount?.holderName ?? '';
      bankNameController.text = r.bankAccount?.bankName ?? '';
      return right(r);
    });
  }

  Future<void> onProfileImageClicked() async {
    final files = await showMultiPhotoPickerBottomSheet(limit: 1);
    if (files == null || files.length != 1) {
      return;
    }
    _selectedProfileImageFile.value = files.first;
  }

  Future<void> updateMe() async {
    if (!((bankNameController.text.isEmpty ==
            holderNameController.text.isEmpty) &&
        (holderNameController.text.isEmpty ==
            bankAccountNumberController.text.isEmpty))) {
      showError(DS.text.bankAccountInfoValidateFail);
      return;
    }

    if (!emailController.checkIsValid() ||
        !nicknameController.checkIsValid() ||
        !oneLineIntroduceController.checkIsValid() ||
        !bankNameController.checkIsValid() ||
        !holderNameController.checkIsValid() ||
        !bankAccountNumberController.checkIsValid()) {
      _isLoading.value = false;
      return;
    }

    emailController.unFocus();
    nicknameController.unFocus();
    oneLineIntroduceController.unFocus();
    bankNameController.unFocus();
    holderNameController.unFocus();
    bankAccountNumberController.unFocus();

    late final BankAccount? bankAccount;
    if (bankNameController.text.isEmpty ||
        holderNameController.text.isEmpty ||
        bankAccountNumberController.text.isEmpty) {
      bankAccount = null;
    } else {
      bankAccount = BankAccount(
          holderName: holderNameController.text,
          bankName: bankNameController.text,
          number: bankAccountNumberController.text);
    }

    _isLoading.value = true;
    String profileImageUrl = user.value.profileImageUrl;
    if (selectedProfileImageFile != null) {
      final profileImageUploadResult =
          await _fileService.uploadImageFile(selectedProfileImageFile!);
      profileImageUploadResult.fold((l) => showError(l.desc), (r) {
        profileImageUrl = r;
        _selectedProfileImageFile.value = null;
      });
    }
    final ret = await _userRepo.updateMe(UserUpdate(
      email: emailController.text,
      profileImageUrl: profileImageUrl,
      nickname: nicknameController.text,
      oneLineIntroduce: oneLineIntroduceController.text,
      bankAccount: bankAccount,
    ));
    ret.fold((l) => showError(l.desc), (r) {
      react.back();
      showSuccess(DS.text.editSuccess);
      user.value = r;
    });
    _isLoading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    nicknameController.dispose();
    oneLineIntroduceController.dispose();
    bankNameController.dispose();
    holderNameController.dispose();
    bankAccountNumberController.dispose();
    super.onClose();
  }
}
