import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/component/local_search_dialog.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/1_presentation/store/item/store_item_page.dart';
import 'package:teameat/1_presentation/store/item/store_item_page_binding.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/local.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/file/i_file_service.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';
import 'package:teameat/99_util/image.dart';
import 'package:flutter/material.dart' as mt;

class CommunityCreatePageController extends PageController {
  final double menuImageRatio = 3 / 4;
  final double storeImageRatio = 1 / 1;
  final primaryButtonKey = mt.GlobalKey();

  final bytes = Rxn<Uint8List>();

// repo
  final _storeRepo = Get.find<IStoreRepository>();
  final _curationRepo = Get.find<ICurationRepository>();
  final _userRepo = Get.find<IUserRepository>();

  // service
  final _fileService = Get.find<IFileService>();

// state

  final _local = Rxn<Local>();
  final _localIsEntered = false.obs;
  // final _isInputValid = false.obs;

  bool _isMenuImageLoading = false;
  List<ImageResizeResult> _menuImages = [];
  bool _isStoreImageLoading = false;
  List<ImageResizeResult> _storeImages = [];

  final storeNameController = TECupertinoTextFieldController();
  final menuNameController = TECupertinoTextFieldController();
  final menuPriceController = TECupertinoTextFieldController();
  final menuOneLineIntroduceController = TECupertinoTextFieldController();
  final menuIntroduceController = TECupertinoTextFieldController();

  final _isLoading = false.obs;

  // getter
  bool get localIsEntered => _localIsEntered.value;
  Local? get local => _local.value;
  bool get isLoading => _isLoading.value;
  // bool get isInputValid => _isInputValid.value;

  // setter
  set isMenuImageLoading(bool isLoading) => _isMenuImageLoading = isLoading;
  set menuImages(List<ImageResizeResult> images) => _menuImages = images;
  set isStoreImageLoading(bool isLoading) => _isStoreImageLoading = isLoading;
  set storeImages(List<ImageResizeResult> images) => _storeImages = images;

  Future<void> onLastInputFocused() async {
    // 추후 제거해야되는 기능이 될수도 있음.
    await Future.delayed(const Duration(seconds: 1));
    final context = primaryButtonKey.currentContext;
    if (context == null) {
      return;
    }
    // ignore: use_build_context_synchronously
    mt.Scrollable.ensureVisible(context,
        duration: const Duration(milliseconds: 300));
  }

  Future<void> toPreview() async {
    if (!checkInputValidIfNotShowError()) {
      return;
    }
    _isLoading.value = true;
    final meEither = await _userRepo.getMe();
    if (meEither.isLeft()) {
      return showError('unknown error occurred, please contact developer');
    }
    final me = meEither.getOrElse(() => User.visitor());
    _isLoading.value = false;

    final menuOriginalPrice = int.parse(menuPriceController.text);

    final item = ItemDetail.empty().copyWith(
      name: menuNameController.text,
      originalPrice: menuOriginalPrice,
      price: (menuOriginalPrice * 0.9).round(),
      imageUrls: _menuImages.map((r) => r.bytes).toList(),
      store: StoreDetail.empty().copyWith(
        name: local!.title,
        address: local!.roadAddress,
        location: local!.location,
      ),
      curation: CurationMain(
        curatorId: -1,
        curatorProfileImageUrl: me.profileImageUrl,
        curatorNickname: me.nickname,
        storeImageUrls: _storeImages.map((r) => r.bytes).toList(),
        oneLineIntroduce: menuOneLineIntroduceController.text,
        introduce: menuIntroduceController.text,
      ),
    );

    Get.to(
      () => StoreItemPage(item.id.toString()),
      arguments: {
        'itemId': item.id,
        'itemDetail': item,
        'onApplyCuration': () async {
          Get.back();
          _isLoading.value = true;
          await _onCreateCuration();
          _isLoading.value = false;
        }
      },
      preventDuplicates: false,
      binding: StoreItemPageBinding(),
      duration: const Duration(milliseconds: 200),
      transition: Transition.rightToLeft,
    );
  }

  bool _showErrorAndReturnFalse(String errorText) {
    showError(errorText);
    return false;
  }

  bool checkInputValidIfNotShowError() {
    if (_isMenuImageLoading || _isStoreImageLoading) {
      return _showErrorAndReturnFalse(DS.text.pictureIsLoadingTryAgainLater);
    }
    if (local == null) {
      return _showErrorAndReturnFalse(DS.text.localIsEssential);
    }
    if (_menuImages.isEmpty) {
      return _showErrorAndReturnFalse(DS.text.menuPictureIsEssential);
    }
    if (!menuNameController.checkIsValid() ||
        !menuPriceController.checkIsValid() ||
        !menuOneLineIntroduceController.checkIsValid() ||
        !menuIntroduceController.checkIsValid()) {
      return false;
    }
    return true;
  }

  Future<void> onSearchStore() async {
    final selected = await searchLocal();
    if (selected == null) {
      return;
    }
    _local.value = selected;
    storeNameController.text = selected.title;
  }

  Future<void> _searchLocalIsEntered(Local? local) async {
    if (local == null) {
      return;
    }
    final ret = await _storeRepo.isStoreEntered(local.storeId);
    ret.fold((l) => showError(l.desc), (r) => _localIsEntered.value = r);
  }

  Future<List<String>> _uploadImage(List<ImageResizeResult> images) async {
    final uploadResults =
        await Future.wait(images.map(_fileService.uploadImage));
    final rets = <String>[];
    for (final uploadResult in uploadResults) {
      uploadResult.fold((l) => showError(l.desc), (r) => rets.add(r));
    }
    return rets;
  }

  Future<void> _onCreateCuration() async {
    if (local == null) {
      return;
    }

    final imageUrlLists = await Future.wait(
        [_uploadImage(_menuImages), _uploadImage(_storeImages)]);

    final ret = await _curationRepo.registerCuration(CurationCreateRequest(
      localInfo: local!,
      name: menuNameController.text,
      originalPrice: int.parse(menuPriceController.text),
      oneLineIntroduce: menuOneLineIntroduceController.text,
      introduce: menuIntroduceController.text,
      itemImageUrls: imageUrlLists[0],
      storeImageUrls: imageUrlLists[1],
    ));
    ret.fold(
      (l) => showError(l.desc),
      (_) {
        react.toCommunityOffAll();
        showSuccess(DS.text.registerCurationSuccess);
      },
    );
  }

  @override
  Future<bool> initialLoad() async {
    ever(_local, _searchLocalIsEntered);
    return true;
  }
}
