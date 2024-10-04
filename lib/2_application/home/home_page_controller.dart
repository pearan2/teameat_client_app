import 'package:get/get.dart';
import 'package:teameat/1_presentation/core/layout/snack_bar.dart';
import 'package:teameat/2_application/core/location_controller.dart';
import 'package:teameat/2_application/core/page_controller.dart';
import 'package:teameat/3_domain/core/code/code.dart';
import 'package:teameat/3_domain/core/code/i_code_repository.dart';
import 'package:teameat/3_domain/core/searchable_address.dart';

class HomePageController extends PageController {
  /// repos
  final _codeRepo = Get.find<ICodeRepository>();

  /// controllers
  final locationController = Get.find<LocationController>();

  /// 상태
  final _searchableAddresses = <SearchableAddress>[].obs;
  late final _selectedAddress =
      Rxn<SearchableAddress>(_codeRepo.lastSearchableAddressNyUser());
  final _categories = <Code>[].obs;
  final _isLoading = false.obs;
  final _sectionRefreshCount = 0.obs;

  int get sectionRefreshCount => _sectionRefreshCount.value;

  // ignore: invalid_use_of_protected_member
  List<SearchableAddress> get searchableAddresses => _searchableAddresses.value;
  SearchableAddress? get selectedAddress => _selectedAddress.value;
  // ignore: invalid_use_of_protected_member
  List<Code> get categories => _categories.value;

  bool get loading => _isLoading.value;

  Future<void> refreshPage() async {
    _loadSearchableAddresses();
    _sectionRefreshCount.value++;
  }

  Future<void> _loadSearchableAddresses() async {
    final ret = await _codeRepo.getSearchableAddress();
    return ret.fold(
        (l) => showError(l.desc), (r) => _searchableAddresses.value = r);
  }

  Future<void> _loadCategories() async {
    final ret = await _codeRepo.getCode(CodeKey.storeSearchCategory());
    return ret.fold((l) => showError(l.desc), (r) => _categories.value = r);
  }

  Future<void> onSelectedAddressChanged(SearchableAddress? address) async {
    _codeRepo.setLastSearchableAddressByUser(address);
    _selectedAddress.value = address;
  }

  Future<void> onDistanceViewOn() async {
    _isLoading.value = true;
    await locationController.init(showTimeoutError: false);
    _isLoading.value = false;
  }

  @override
  Future<bool> initialLoad() async {
    _loadSearchableAddresses();
    _loadCategories();
    return true;
  }
}
