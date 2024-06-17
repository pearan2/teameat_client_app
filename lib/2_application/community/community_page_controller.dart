import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/local_search_dialog.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/image/image_multi_picker.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/3_domain/core/local.dart';
import 'package:teameat/3_domain/curation/curation.dart';
import 'package:teameat/3_domain/curation/i_curation_repository.dart';
import 'package:teameat/3_domain/store/i_store_repository.dart';
import 'package:teameat/99_util/image.dart';

class CommunityPageController extends GetxController {
  final bytes = Rxn<Uint8List>();

// repo
  final _storeRepo = Get.find<IStoreRepository>();
  final _curationRepo = Get.find<ICurationRepository>();

// state
  final _local = Rxn<Local>();
  final _localIsEntered = false.obs;
  final _isLoading = false.obs;

  // getter
  bool get localIsEntered => _localIsEntered.value;
  Local? get local => _local.value;
  bool get isLoading => _isLoading.value;

  Future<void> onSearchStore() async {
    final selected = await searchLocal();
    if (selected == null) {
      return;
    }
    _local.value = selected;
  }

  Future<void> onImageSelect() async {
    final images = await showMultiPhotoPickerBottomSheet(
      limit: 5,
      widthRatio: 3,
      heightRatio: 4,
      height: Get.mediaQuery.size.height - Get.mediaQuery.padding.top,
    );
    if (images != null && images.isNotEmpty) {
      final ret =
          await resize(ImageResizeParameter(images.first, ratio: 3 / 4));
      print(ret.width);
      print(ret.height);
      print(ret.width / ret.height);
      bytes.value = ret.bytes;
    }
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
  void onInit() {
    super.onInit();
    ever(_local, _searchLocalIsEntered);
  }
}
