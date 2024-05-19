import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/voucher/i_voucher_repository.dart';
import 'package:teameat/3_domain/voucher/voucher.dart';

class VoucherPageController extends PageController {
  final numberOfVouchersPerPage = 10;

  final _codeRepo = Get.find<ICodeRepository>();
  final _voucherRepo = Get.find<IVoucherRepository>();

  /// controllers
  final PagingController<int, VoucherSimple> pagingController =
      PagingController(firstPageKey: 0);

  final _numberOfRemainVouchers = RxInt(0);
  final _filterCodes = RxList<Code>.empty();
  final _orderCodes = RxList<Code>.empty();
  final _searchOption = SearchVoucherSimpleList.empty().obs;

  int get numberOfRemainVoucher => _numberOfRemainVouchers.value;
  SearchVoucherSimpleList get searchOption => _searchOption.value;
  List<Code> get filters => _filterCodes;
  List<Code> get orders => _orderCodes;

  void onFilterChanged(Code newFilter) {
    _searchOption.value =
        searchOption.copyWith(status: newFilter, pageNumber: 0);
    pagingController.refresh();
  }

  void onOrderChanged(Code newOrder) {
    _searchOption.value =
        searchOption.copyWith(orderBy: newOrder, pageNumber: 0);
    pagingController.refresh();
  }

  Future<void> onVoucherCardClickHandler(int voucherId) async {
    final ret = await react.toVoucherDetailPage(voucherId);
    final needToUpdate = ret == null ? false : (ret as bool);
    if (needToUpdate) {
      _searchOption.value = SearchVoucherSimpleList.empty();
      pagingController.refresh();
    }
  }

  Future<void> _loadCodes() async {
    await Future.wait([
      resolve(_codeRepo.getCode(CodeKey.voucherFilter()), (codes) {
        _filterCodes.value = codes;
      }),
      resolve(_codeRepo.getCode(CodeKey.voucherOrder()), (codes) {
        _orderCodes.value = codes;
      }),
    ]);
  }

  Future<void> _loadVouchers(int currentPageNumber) async {
    final ret = await _voucherRepo.findAllVouchers(_searchOption.value);
    return ret.fold((l) => showError(l.desc), (r) {
      if (r.length < numberOfVouchersPerPage) {
        pagingController.appendLastPage(r);
      } else {
        pagingController.appendPage(r, currentPageNumber + 1);
        _searchOption.value =
            searchOption.copyWith(pageNumber: currentPageNumber + 1);
      }
    });
  }

  Future<void> _loadNumberOfRemainVouchers() async {
    final ret = await _voucherRepo.findNumberOfUsableVouchers();
    return ret.fold(
        (l) => showError(l.desc), (r) => _numberOfRemainVouchers.value = r);
  }

  @override
  Future<bool> initialLoad() async {
    pagingController.addPageRequestListener(_loadVouchers);
    await Future.wait([_loadCodes(), _loadNumberOfRemainVouchers()]);
    return true;
  }
}
