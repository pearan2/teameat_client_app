import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/input_text.dart';
import 'package:teameat/1_presentation/core/component/local_search_dialog.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/local.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/99_util/image.dart';

class CommunityCreatePageController extends PageController {
  final double menuImageRatio = 3 / 4;
  final double storeImageRatio = 1 / 1;

  final bytes = Rxn<Uint8List>();

// repo
  final _storeRepo = Get.find<IStoreRepository>();
  final _curationRepo = Get.find<ICurationRepository>();

// state

  final _local = Rxn<Local>();
  final _localIsEntered = false.obs;
  final _isInputValid = false.obs;

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
  bool get isInputValid => _isInputValid.value;

  // setter
  set isMenuImageLoading(bool isLoading) => _isMenuImageLoading = isLoading;
  set menuImages(List<ImageResizeResult> images) => _menuImages = images;
  set isStoreImageLoading(bool isLoading) => _isStoreImageLoading = isLoading;
  set storeImages(List<ImageResizeResult> images) => _storeImages = images;

  void toPreview() {}

  Future<void> onSearchStore() async {
    final selected = await searchLocal();
    if (selected == null) {
      return;
    }
    _local.value = selected;
  }

  Future<void> _searchLocalIsEntered(Local? local) async {
    if (local == null) {
      return;
    }
    final ret = await _storeRepo.isStoreEntered(local.storeId);
    ret.fold((l) => showError(l.desc), (r) => _localIsEntered.value = r);
  }

  Future<void> onCreateCuration() async {
    if (local == null) {
      return;
    }
    final ret = await _curationRepo.registerCuration(CurationCreateRequest(
      localInfo: local!,
      name: 'test',
      originalPrice: 1000,
      oneLineIntroduce: '킹줄소개',
      introduce: '겁나소개',
      itemImageUrls: ['asdf', '1234'],
      storeImageUrls: [],
    ));
    ret.fold(
      (l) => showError(l.desc),
      (_) => showSuccess(DS.text.registerCurationSuccess),
    );
  }

  @override
  Future<bool> initialLoad() async {
    ever(_local, _searchLocalIsEntered);
    return true;
  }
}
