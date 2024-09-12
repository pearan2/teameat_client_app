import 'package:get/get.dart';
import 'package:teameat/2_application/community/curation_detail_view_page_controller.dart';
import 'package:teameat/3_domain/curation/curation.dart';

class CurationDetailViewPageBinding implements Bindings {
  @override
  void dependencies() {
    final argMap = Get.arguments as Map<String, dynamic>;
    final curationId = argMap['curationId'] as int;
    final simple = argMap['curation'] as CurationListSimple?;

    Get.put(CurationDetailViewPageController(curationId, simple: simple),
        tag: curationId.toString());
  }
}
