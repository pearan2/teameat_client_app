import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';

class UserPageController extends PageController {
  final _userRepo = Get.find<IUserRepository>();
  final _authService = Get.find<IAuthService>();

  final _user = User.visitor().obs;

  User get user => _user.value;

  void onLogOut() {
    if (!_authService.isLogined()) {
      return showError(DS.getText().notLogined);
    }
    _authService.logOut();
    _user.value = User.visitor();
  }

  Future<void> onSignOut() async {
    if (!_authService.isLogined()) {
      return showError(DS.getText().notLogined);
    }
    final ret = await _userRepo.deleteMe();
    return ret.fold((l) => showError(l.desc), (r) {
      if (r) {
        showSuccess(DS.getText().deleteUserSuccessSeeYouAgain);
        _authService.logOut();
        _user.value = User.visitor();
      } else {
        showError(DS.getText().apiFail);
      }
    });
  }

  Future<void> _loadMe() async {
    final ret = await _userRepo.getMe();
    return ret.fold((l) => null, (r) => _user.value = r);
  }

  @override
  Future<bool> initialLoad() async {
    await _loadMe();
    return true;
  }
}
