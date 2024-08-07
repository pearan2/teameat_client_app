import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/failure.dart';
import 'package:teameat/3_domain/user/block/block.dart';
import 'package:teameat/3_domain/user/block/i_user_block_repository.dart';

class UserBlockPageController extends PageController {
  final _blockRepo = Get.find<IUserBlockRepository>();

  late final PagingController<int, BlockTargetInfo> pagingController =
      PagingController(firstPageKey: 0);

  final BlockTargetType blockTargetType;

  UserBlockPageController(this.blockTargetType);

  Future<void> unBlock(int targetId) async {
    late final Either<Failure, Unit> ret;
    if (blockTargetType == BlockTargetType.user) {
      ret = await _blockRepo.unblockUser(targetId);
    } else if (blockTargetType == BlockTargetType.curation) {
      ret = await _blockRepo.unblockCuration(targetId);
    } else {
      throw 'not implemented yet';
    }
    ret.fold((l) => showError(l.desc), (r) {
      final items = pagingController.itemList;
      if (items == null) return;

      final newItems = [...items]..removeWhere((item) => item.id == targetId);
      pagingController.itemList = newItems;
    });
    return;
  }

  Future<void> _loadBlockTargets(int pageNumber) async {
    final searchOption = BlockTargetSearchList.empty(blockTargetType)
        .copyWith(pageNumber: pageNumber);
    final ret = await _blockRepo.findAll(searchOption);
    return ret.fold((l) => showError(l.desc), (r) {
      if (r.length < searchOption.pageSize) {
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
    pagingController.addPageRequestListener(_loadBlockTargets);
    return super.initialLoad();
  }
}
