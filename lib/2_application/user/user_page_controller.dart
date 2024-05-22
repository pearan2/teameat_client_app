import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/design/design_system.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/auth/i_auth_service.dart';
import 'package:teameat/3_domain/store/item/i_item_repository.dart';
import 'package:teameat/3_domain/store/item/item.dart';
import 'package:teameat/3_domain/store/store.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';

class UserPageController extends PageController {
  final _userRepo = Get.find<IUserRepository>();
  final _authService = Get.find<IAuthService>();
  final _itemRepo = Get.find<IStoreItemRepository>();

  final _user = User.visitor().obs;
  final _recentSeeItems = StoreDetail.empty().items.obs;

  User get user => _user.value;
  // ignore: invalid_use_of_protected_member
  List<ItemSimple> get recentSeeItems => _recentSeeItems.value;

  void onLogOut() {
    if (!_authService.isLogined()) {
      return showError(DS.text.notLogined);
    }
    _authService.logOut();
    _user.value = User.visitor();
  }

  Future<void> onSignOut() async {
    if (!_authService.isLogined()) {
      return showError(DS.text.notLogined);
    }
    final ret = await _userRepo.deleteMe();
    return ret.fold((l) => showError(l.desc), (r) {
      if (r) {
        showSuccess(DS.text.deleteUserSuccessSeeYouAgain);
        _authService.logOut();
        _user.value = User.visitor();
      } else {
        showError(DS.text.apiFail);
      }
    });
  }

  Future<void> _loadRecentSeeItems() async {
    return resolve(
        _itemRepo.findRecentSeeItems(), (r) => _recentSeeItems.value = r);
  }

  Future<void> _loadMe() async {
    final ret = await _userRepo.getMe();
    return ret.fold((l) => null, (r) => _user.value = r);
  }

  @override
  Future<bool> initialLoad() async {
    await Future.wait([_loadMe(), _loadRecentSeeItems()]);
    return true;
  }
}
