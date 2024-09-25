import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' as mt;
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
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/event/coupon/coupon.dart';
import 'package:teameat/3_domain/event/coupon/i_coupon_repository.dart';
import 'package:teameat/3_domain/file/i_file_service.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:teameat/99_util/get.dart';

class UserPageController extends PageController {
  final _userRepo = Get.find<IUserRepository>();
  final _couponRepo = Get.find<ICouponRepository>();
  final _itemRepo = Get.find<IStoreItemRepository>();
  final _authService = Get.find<IAuthService>();
  final _fileService = Get.find<IFileService>();

  late final user = User.visitor().wrap(_loadMe);
  late final couponSummary = MyCouponSummary.empty().wrap(_loadCouponSummary);

  late final recentSeeItems = <ItemSimple>[
    ItemSimple.empty(),
    ItemSimple.empty()
  ].wrap(_loadRecentSeeItems);

  final _selectedProfileImageFile = Rxn<File>();
  final _isLoading = false.obs;

  final _storeLikeController = Get.find<LikeController<IStoreRepository>>();
  final _itemLikeController = Get.find<LikeController<IStoreItemRepository>>();
  final _curationLikeController =
      Get.find<LikeController<ICurationRepository>>();

  // ignore: invalid_use_of_protected_member
  bool get loading => _isLoading.value;
  File? get selectedProfileImageFile => _selectedProfileImageFile.value;

  final receiveGiftFromUrlController = TECupertinoTextFieldController();

  final emailController = TECupertinoTextFieldController();
  final nicknameController = TECupertinoTextFieldController();
  final oneLineIntroduceController = TECupertinoTextFieldController();
  final bankNameController = TECupertinoTextFieldController();
  final holderNameController = TECupertinoTextFieldController();
  final bankAccountNumberController = TECupertinoTextFieldController();
  final birthYearController = TECupertinoTextFieldController();
  final _gender = Rxn<Gender>();

  Gender? get gender => _gender.value;
  set gender(Gender? newValue) => _gender.value = newValue;

  void onSummaryClick() {
    if (user.value == User.visitor()) {
      return;
    }
    react.toCuratorSummary(user.value.identifier);
  }

  void onReceiveGiftFromUrl() {
    final input = receiveGiftFromUrlController.text.trim();
    late final String giftId;
    if (input.isURL) {
      giftId = input.split('gift/').last;
    } else {
      giftId = input;
    }
    react.toGiftReceive(giftId: giftId);
  }

  void _afterLogOutCleaning() {
    _itemLikeController.clean();
    _storeLikeController.clean();
    _curationLikeController.clean();
    couponSummary.value = MyCouponSummary.empty();
    user.value = User.visitor();
  }

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
    _afterLogOutCleaning();
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
        _authService.logOut();
        _afterLogOutCleaning();
        showSuccess(DS.text.deleteUserSuccessSeeYouAgain);
      } else {
        showError(DS.text.apiFail);
      }
    });
  }

  Future<void> toUserDetail() async {
    await user.load();
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
      couponSummary.load();
      emailController.text = r.email;
      nicknameController.text = r.nickname;
      oneLineIntroduceController.text = r.oneLineIntroduce ?? '';
      bankAccountNumberController.text = r.bankAccount?.number ?? '';
      holderNameController.text = r.bankAccount?.holderName ?? '';
      bankNameController.text = r.bankAccount?.bankName ?? '';
      gender = Gender.fromCode(r.gender);
      birthYearController.text = r.birthYear ?? '';
      return right(r);
    });
  }

  Future<Either<Failure, MyCouponSummary>> _loadCouponSummary() async {
    if (!_authService.isLogined()) {
      return right(MyCouponSummary.empty());
    }
    final ret = await _couponRepo.findMyCouponSummary();
    return ret.fold((l) => right(MyCouponSummary.empty()), (r) => right(r));
  }

  Future<void> onProfileImageClicked(mt.BuildContext context) async {
    showInstaAssetPicker(context, cropRatio: 1 / 1, maxAssets: 1,
        onCompleted: (stream) {
      stream.listen((data) {
        if (data.croppedFiles.isNotEmpty) {
          _selectedProfileImageFile.value = data.croppedFiles.first;
        }
      });
    });
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
        !bankAccountNumberController.checkIsValid() ||
        !birthYearController.checkIsValid()) {
      _isLoading.value = false;
      return;
    }

    emailController.unFocus();
    nicknameController.unFocus();
    oneLineIntroduceController.unFocus();
    bankNameController.unFocus();
    holderNameController.unFocus();
    bankAccountNumberController.unFocus();
    birthYearController.unFocus();

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
      birthYear: birthYearController.text,
      gender: gender?.code,
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
    birthYearController.dispose();
    super.onClose();
  }
}
