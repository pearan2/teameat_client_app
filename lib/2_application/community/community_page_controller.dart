import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/local_search_dialog.dart';
import 'package:teameat/1_presentation/core/image/image_multi_picker.dart';
import 'package:teameat/99_util/image.dart';

class CommunityPageController extends GetxController {
  final bytes = Rxn<Uint8List>();

  Future<void> onSearchStore() async {
    final local = await searchLocal();
    if (local == null) {
      return;
    }
    print(local);
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
}
