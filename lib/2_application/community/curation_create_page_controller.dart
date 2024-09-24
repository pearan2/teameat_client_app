import 'dart:io';

import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/1_presentation/user/curation/user_curation_page.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/local.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/curation/i_curation_temp_save_service.dart';
import 'package:teameat/3_domain/file/i_file_service.dart';

import 'package:flutter/material.dart' as mt;

class CurationCreatePageController extends PageController {
  final primaryButtonKey = mt.GlobalKey();

  // repo
  final _curationRepo = Get.find<ICurationRepository>();

  // service
  final _fileService = Get.find<IFileService>();
  final _tempSaveService = Get.find<ICurationTempSaveService>();

  // state
  bool _creationSuccess = false;

  final _local = Rxn<Local>();

  bool _isMenuImageLoading = false;
  List<dynamic> menuImages = [];
  bool _isStoreImageLoading = false;
  List<dynamic> storeImages = [];

  final menuNameController = TECupertinoTextFieldController();
  final menuPriceController = TECupertinoTextFieldController();
  final menuOneLineIntroduceController = TECupertinoTextFieldController();
  final menuIntroduceController = TECupertinoTextFieldController();

  final _isLoading = false.obs;

  // init
  final MyCurationDetail? curation;
  final bool startWithTempSave;
  CurationCreatePageController(this.curation, {this.startWithTempSave = false});

  void _initStates() {
    if (isEditMode) {
      _local.value = curation!.localInfo;
      menuImages = curation!.itemImageUrls;
      storeImages = curation!.storeImageUrls;
      menuNameController.text = curation!.name;
      menuPriceController.text = curation!.originalPrice.toString();
      menuOneLineIntroduceController.text = curation!.oneLineIntroduce;
      menuIntroduceController.text = curation!.introduce;
      return;
    }
    if (startWithTempSave) {
      final tempSaved = _tempSaveService.findTempSave();
      _local.value = tempSaved.local;
      menuImages = tempSaved.menuImages;
      storeImages = tempSaved.storeImages;
      menuNameController.text = tempSaved.menuName;
      menuPriceController.text = tempSaved.menuPrice;
      menuOneLineIntroduceController.text = tempSaved.menuOneLineIntroduce;
      menuIntroduceController.text = tempSaved.menuIntroduce;
    }
  }

  // getter
  Local? get local => _local.value;
  bool get isLoading => _isLoading.value;
  bool get isEditMode => curation != null;

  // setter
  set isMenuImageLoading(bool isLoading) => _isMenuImageLoading = isLoading;
  set isStoreImageLoading(bool isLoading) => _isStoreImageLoading = isLoading;

  void setLocal(Local local) {
    _local.value = local;
  }

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
    if (menuImages.isEmpty) {
      return _showErrorAndReturnFalse(DS.text.menuPictureIsEssential);
    }
    if (!menuNameController.checkIsValid() ||
        !menuPriceController.checkIsValid() ||
        !menuOneLineIntroduceController.checkIsValid() ||
        !menuIntroduceController.checkIsValid()) {
      return false;
    }
    menuNameController.unFocus();
    menuPriceController.unFocus();
    menuOneLineIntroduceController.unFocus();
    menuIntroduceController.unFocus();
    return true;
  }

  Future<List<String>> _uploadImage(List<dynamic> images) async {
    final uploadResults = await Future.wait(images.map((src) async {
      if (src is String) {
        return src;
      } else if (src is File) {
        final uploadRet = await _fileService.uploadImageFile(src);
        return uploadRet.fold((l) {
          showError(l.desc);
          return null;
        }, (r) => r);
      }
    }));
    return uploadResults.whereType<String>().toList();
  }

  Future<void> onPrimaryButtonClick() async {
    _isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () async {
      try {
        await _onSave();
      } catch (e) {
        showError(DS.text.errorOccurredWhileCurationUpload);
      } finally {
        _isLoading.value = false;
      }
    });
  }

  Future<void> _onSave() async {
    if (local == null) {
      return;
    }
    if (!checkInputValidIfNotShowError()) {
      return;
    }

    final imageUrlLists = await Future.wait(
        [_uploadImage(menuImages), _uploadImage(storeImages)]);

    /// 모든 파일이 다 업로드 되었는지
    final uploadedMenuImages = imageUrlLists[0];
    final uploadedStoreImages = imageUrlLists[1];

    if (uploadedMenuImages.length != menuImages.length ||
        uploadedStoreImages.length != storeImages.length) {
      return showError(DS.text.errorOccurredDuringFileUploadingPleaseReTry);
    }

    final request = CurationCreateRequest(
      localInfo: local!,
      name: menuNameController.text,
      originalPrice: int.parse(menuPriceController.text),
      oneLineIntroduce: menuOneLineIntroduceController.text,
      introduce: menuIntroduceController.text,
      itemImageUrls: imageUrlLists[0],
      storeImageUrls: imageUrlLists[1],
      isPublic: true,
    );

    if (isEditMode) {
      final ret = await _curationRepo.updateCuration(curation!.id, request);
      ret.fold(
        (l) => showError(l.desc),
        (_) {
          react.back(result: true);
        },
      );
    } else {
      final ret = await _curationRepo.registerCuration(request);
      ret.fold(
        (l) => showError(l.desc),
        (_) {
          _creationSuccess = true;
          if (Get.isRegistered<UserCurationPage>()) {
            react.toUserOffAll();
            react.toUserCuration();
          } else {
            react.toCurationOffAll();
          }
          showSuccess(DS.text.registerCurationSuccess);
        },
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (isEditMode) {
      return;
    }
    if (_creationSuccess) {
      _tempSaveService.clear();
      return;
    } else {
      _tempSaveService.tempSave(CurationCreate(
        menuImages: menuImages.map((src) => src as File).toList(),
        storeImages: storeImages.map((src) => src as File).toList(),
        local: local,
        menuName: menuNameController.text,
        menuPrice: menuPriceController.text,
        menuOneLineIntroduce: menuOneLineIntroduceController.text,
        menuIntroduce: menuIntroduceController.text,
      ));
    }
  }

  @override
  Future<bool> initialLoad() async {
    _initStates();
    return true;
  }
}
