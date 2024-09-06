import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/user/i_user_repository.dart';
import 'package:teameat/3_domain/user/user.dart';

class UserFollowerPageController extends PageController {
  static const pageSize = 20;

  final _userRepo = Get.find<IUserRepository>();

  final PagingController<int, Follower> pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _loadStores(int pageNumber) async {
    final ret = await _userRepo.getMyFollowers(
        pageSize: pageSize, pageNumber: pageNumber);
    return ret.fold((l) => showError(l.desc), (r) {
      if (r.length < pageSize) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, pageNumber + 1);
      }
    });
  }

  @override
  void onReady() {
    pagingController.error = '';
    pagingController.refresh();
    pagingController.error = null;
    super.onReady();
  }

  @override
  Future<bool> initialLoad() {
    pagingController.itemList = [];
    pagingController.addPageRequestListener(_loadStores);
    return super.initialLoad();
  }
}
