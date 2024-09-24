import 'package:get/get.dart';
import 'package:teameat/2_application/community/curation_create_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';

class CurationCreatePageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final curation = argMap['curation'] as MyCurationDetail?;
    final startWithTempSave = argMap['startWithTempSave'] as bool;

    Get.put(CurationCreatePageController(
      curation,
      startWithTempSave: startWithTempSave,
    ));
  }
}
