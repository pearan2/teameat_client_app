import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/component/local_search_dialog.dart';
import 'package:teameat/1_presentation/core/image/image_multi_picker.dart';

class CommunityPageController extends GetxController {
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
      ratio: 3 / 4,
      height: Get.mediaQuery.size.height - Get.mediaQuery.padding.top,
    );
  }
}
