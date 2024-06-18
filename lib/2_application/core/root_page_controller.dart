import 'package:get/get.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';

class RootPageController extends PageController {
  final _codeRepo = Get.find<ICodeRepository>();

  Future<void> _loadCode() {
    return Future.wait([
      _codeRepo.getCode(CodeKey.voucherFilter()),
      _codeRepo.getCode(CodeKey.voucherOrder()),
      _codeRepo.getCode(CodeKey.curationFilter())
    ]);
  }

  @override
  Future<bool> initialLoad() async {
    await _loadCode();
    react.toHomeOffAll();
    return true;
  }
}
